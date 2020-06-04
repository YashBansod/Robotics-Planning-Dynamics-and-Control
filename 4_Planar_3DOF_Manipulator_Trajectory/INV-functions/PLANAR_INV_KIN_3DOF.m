function [expPoint, Joint, Theta] = PLANAR_INV_KIN_3DOF(L1, L2, L3, expX, expY, theta1, theta2, theta3)
%% Variable Initialization
% Variables to store error related data
Kp = 0.3;       % Proportional constant for inverse jacobian controller
errorThreshold = 0.01;

% Matrix containing Joint angle Information and Desired Point Location
Theta = [theta1; theta2; theta3];
expPoint = [expX; expY];

%% Inverse Kinematics Initialization

% Draw the original position of the manipulator
[Jacobian, Joint] = PLANAR_ARM_3DOF(L1, L2, L3, theta1, theta2, theta3, false);
[m, ~] = size(Joint);
currPoint = [Joint(m,1); Joint(m,2)];

% Get the error vector representing difference between current and desired
% position of the manipulator
errorVec = (expPoint - currPoint);

% Apply the control equation to the error vector
deltaTheta = transpose(Jacobian) * errorVec * Kp;

% Apply the control changes to the Joint Angles
Theta(1,1) = Theta(1,1) + deltaTheta(1,1);
Theta(2,1) = Theta(2,1) + deltaTheta(2,1);
Theta(3,1) = Theta(3,1) + deltaTheta(3,1);

% Find the euclidean distance between the desired and current position of
% the manipulator.
dist = hypot((expPoint(1,1) - currPoint(1,1)), (expPoint(2,1)-currPoint(2,1)));

%% Iterative Inverse Kinematics for correcting the manipulator position.

% Correct the manipulator position to reduce the distance.
while (dist > errorThreshold)
    [Jacobian, Joint] = PLANAR_ARM_3DOF(L1, L2, L3, Theta(1,1), ...
                                        Theta(2,1), Theta(3,1), false);
    currPoint = [Joint(m,1); Joint(m,2)];
    errorVec = (expPoint - currPoint);
    deltaTheta = transpose(Jacobian) * errorVec * Kp;
    Theta(1,1) = Theta(1,1) + deltaTheta(1,1);
    Theta(2,1) = Theta(2,1) + deltaTheta(2,1);
    Theta(3,1) = Theta(3,1) + deltaTheta(3,1);
    dist = hypot((expPoint(1,1) - currPoint(1,1)), (expPoint(2,1)-currPoint(2,1)));
end

[~, Joint] = PLANAR_ARM_3DOF(L1, L2, L3, Theta(1,1), Theta(2,1), Theta(3,1), true);
end
