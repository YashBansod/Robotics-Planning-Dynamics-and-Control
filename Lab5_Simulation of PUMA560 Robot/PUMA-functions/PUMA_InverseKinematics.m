function [] = PUMA_InverseKinematics(Trans, theta, th, dstPoint)
%% Variable Initialization

% Variables to store error related data
Kp = 0.0045;
errorThreshold = 0.1;

% Matrix containing Joint angle Information and Desired Point Location
t1 = th(1); t2 = th(2); t3 = th(3);
Theta = [double(subs(theta(1))); double(subs(theta(2))); double(subs(theta(3)))];

% Make a column matrix representing the Position of the End-Effector
endPoint = [Trans(1,4,6); Trans(2,4,6); Trans(3,4,6)];
% Find the current numeric end-effector position
currPoint = double(subs(endPoint));
% Find the error vector
errorVec = (dstPoint - currPoint);
% Create a Jacobian Matrix using the given Theta values
Jacobian = PUMA_Jacob(Theta(1,1), Theta(2,1), Theta(3,1));

for i=1:3
    [X(i), Y(i), Z(i)] = PUMA_Plot(double(subs(Trans(:,:,i))));
end
for i=4:6
    X(i) = double(subs(Trans(1,4,i))); 
    Y(i) = double(subs(Trans(2,4,i))); 
    Z(i) = double(subs(Trans(3,4,i)));
end

PUMA_Draw(X, Y, Z);

%% Inverse Kinematics Initialization

% Apply the control equation to the error vector
deltaTheta = transpose(Jacobian) * errorVec * Kp;
% Apply the control changes to the Joint Angles
Theta(1,1) = Theta(1,1) + deltaTheta(1,1);
Theta(2,1) = Theta(2,1) + deltaTheta(2,1);
Theta(3,1) = Theta(3,1) + deltaTheta(3,1);
t1 = Theta(1,1); t2 = Theta(2,1); t3 = Theta(3,1);

% Find the euclidean distance between the desired and current position of
% the manipulator.
dist = sqrt((dstPoint(1,1) - currPoint(1,1))^2 + ...
    (dstPoint(2,1)-currPoint(2,1))^2 +(dstPoint(3,1)-currPoint(3,1))^2);

%% Iterative Inverse Kinematics for correcting the manipulator position.

% Correct the manipulator position to reduce the distance.
while (dist > errorThreshold)
    Jacobian = PUMA_Jacob(Theta(1,1), Theta(2,1), Theta(3,1));
    currPoint = double(subs(endPoint));
    errorVec = (dstPoint - currPoint);
    deltaTheta = transpose(Jacobian) * errorVec * Kp;
    Theta(1,1) = Theta(1,1) + deltaTheta(1,1);
    Theta(2,1) = Theta(2,1) + deltaTheta(2,1);
    Theta(3,1) = Theta(3,1) + deltaTheta(3,1);
    t1 = Theta(1,1); t2 = Theta(2,1); t3 = Theta(3,1);
    dist = sqrt((dstPoint(1,1) - currPoint(1,1))^2 + ...
        (dstPoint(2,1)-currPoint(2,1))^2 +(dstPoint(3,1)-currPoint(3,1))^2);
    
    for i=1:3
        [X(i), Y(i), Z(i)] = PUMA_Plot(double(subs(Trans(:,:,i))));
    end
    for i=4:6
        X(i) = double(subs(Trans(1,4,i))); 
        Y(i) = double(subs(Trans(2,4,i))); Z(i) = double(subs(Trans(3,4,i)));
    end
    PUMA_Draw(X, Y, Z);
    
end

cla
for i=1:3
    [X(i), Y(i), Z(i)] = PUMA_Plot(double(subs(Trans(:,:,i))));
end
for i=4:6
    X(i) = double(subs(Trans(1,4,i))); 
    Y(i) = double(subs(Trans(2,4,i))); 
    Z(i) = double(subs(Trans(3,4,i)));
end
PUMA_Draw(X, Y, Z);
end
