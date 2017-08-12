% Clear the workspace and the command window.
clear;
clc;

% Set the length of the links of the manipulator robot.
L1 = 5;
L2 = 5;
L3 = 5;
theta1 = 15;
theta2 = 0;
theta3 = 15;

% Code for drawing a circle
for i = -10: 0.1: 10
    expX = i;
    expY = sqrt(100 - expX^2);
    [expPoint, Joint, Theta] = PLANAR_INV_KIN_3DOF(L1, L2, L3, expX, expY, theta1, theta2, theta3);
    theta1 = Theta(1, 1);
    theta2 = Theta(2, 1);
    theta3 = Theta(3, 1);
    expPoint
    [m, n] = size(Joint);
    currPoint = [Joint(m,1); Joint(m,2)]
    dist = sqrt((expPoint(1,1) - currPoint(1,1))^2 +(expPoint(2,1)-currPoint(2,1))^2)
end

for i = 10: -0.1: -10
    expX = i;
    expY = -sqrt(100 - expX^2);
    [expPoint, Joint, Theta] = PLANAR_INV_KIN_3DOF(L1, L2, L3, expX, expY, theta1, theta2, theta3);
    theta1 = Theta(1, 1)
    theta2 = Theta(2, 1)
    theta3 = Theta(3, 1)
    expPoint
    [m, n] = size(Joint);
    currPoint = [Joint(m,1); Joint(m,2)]
    dist = sqrt((expPoint(1,1) - currPoint(1,1))^2 +(expPoint(2,1)-currPoint(2,1))^2)
end

% mark the graph with details
title('3 DOF Planar Manipulator');
legend('1st Link of Arm', '2nd Link of Arm' , '3rd Link of Arm');

% msgbox('Operation Complete')
