function [expPoint, Joint] = INV_KIN_2DOF(L1, L2, expX, expY, theta1, theta2, orgX, orgY)
%% Function Configuration

% If only Lengths (L1, L2) of the links was passed into the funtion, then
% use the following code sequence.
if (nargin == 2)
    theta1 = 0;
    theta2 = 0;
    orgX = 0;
    orgY = 0;
    [Jacobian, Joint] = ARM_2DOF(L1, L2, theta1, theta2, true, orgX, orgY);
    [expX, expY] = ginput;
    
    % If the Lengths (L1, L2) and the Final desired position of manipulator
    % (expX, expY) was passed then use this code sequence.
elseif (nargin == 4)
    theta1 = 0;
    theta2 = 0;
    orgX = 0;
    orgY = 0;
    
    % If All parameters were passed except the origin of the manipulator (orgX,
    % orgY) then use the following code sequence.
elseif (nargin == 6)
    orgX = 0;
    orgY = 0;
end

expX = expX(end);
expY = expY(end);
fprintf("The selected point for end effector is (%0.2f, %0.2f)\n", [expX, expY])
if hypot(orgX - expX, orgY - expY) > L1 + L2
    error("Point out of reach");
    return
end

%% Variable Initialization

% Control Variables for the PI controller
Kp = 0.4;
Ki = 0.05;

% Variables to store error related data
sumErrorVec = 0;
errorThreshold = 0.1;

% Matrix containing Joint angle Information and Desired Point Location
Theta = [theta1; theta2];
expPoint = [expX; expY];

%% Inverse Kinematics Initialization

% Draw the original position of the manipulator
[Jacobian, Joint] = ARM_2DOF(L1, L2, theta1, theta2, true, orgX, orgY);
[m, n] = size(Joint);
currPoint = [Joint(m,1); Joint(m,2)];

% Get the error vector representing difference between current and desired
% position of the manipulator
errorVec = (expPoint - currPoint);
sumErrorVec = errorVec + sumErrorVec;

% Apply the control equation to the error vector
controlErrorVec = errorVec * Kp + sumErrorVec * Ki;
deltaTheta = transpose(Jacobian) * controlErrorVec;

% Apply the control changes to the Joint Angles
Theta(1,1) = Theta(1,1) + deltaTheta(1,1);
Theta(2,1) = Theta(2,1) + deltaTheta(2,1);

% Find the euclidean distance between the desired and current position of
% the manipulator.
dist = sqrt((expPoint(1,1) - currPoint(1,1))^2 + ...
            (expPoint(2,1)-currPoint(2,1))^2);

%% Iterative Inverse Kinematics for correcting the manipulator position.

% Correct the manipulator position to reduce the distance.
while (dist > errorThreshold)
    [Jacobian, Joint] = ARM_2DOF(L1, L2, Theta(1,1), Theta(2,1), ...
                                                        true, orgX, orgY);
    currPoint = [Joint(m,1); Joint(m,2)];
    errorVec = (expPoint - currPoint);
    sumErrorVec = errorVec + sumErrorVec;
    controlErrorVec = errorVec * Kp + sumErrorVec * Ki;
    deltaTheta = transpose(Jacobian) * controlErrorVec;
    Theta(1,1) = Theta(1,1) + deltaTheta(1,1);
    Theta(2,1) = Theta(2,1) + deltaTheta(2,1);
    dist = sqrt((expPoint(1,1) - currPoint(1,1))^2 + ...
                (expPoint(2,1)-currPoint(2,1))^2);
end

end
