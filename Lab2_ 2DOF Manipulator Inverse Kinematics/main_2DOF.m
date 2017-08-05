% Clear the workspace and the command window.
clear;
clc;

% Set the length of the links of the manipulator robot.
L1 = 5;
L2 = 5;

% This function will take desired manipulator position from user via mouse 
% pointer.
[expPoint, Joint] = INV_KIN_2DOF(L1,L2);

% Also the user can choose to pass the desired manipulator position
% directly as absolute coordinates too.
% expX = 5;
% expY = 7;
% [expPoint, Joint] = INV_KIN_2DOF(L1, L2, expX, expY);

expPoint
[m, n] = size(Joint);
currPoint = [Joint(m,1); Joint(m,2)]
dist = sqrt((expPoint(1,1) - currPoint(1,1))^2 +(expPoint(2,1)-currPoint(2,1))^2)

msgbox('Operation Complete')
