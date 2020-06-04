%%
%   Author: Yash Bansod  
%
% GitHub: <https://github.com/YashBansod>  
%
% This is the main program.    

%% Clear the environment and the command line
clear;
clc;
close all;

%% Add the directory containing relevant functions to the path variables
addpath('./PUMA-functions/')  

%% Define the input parameters and simulate

% Initialize the DH-Parameters
% Angle values must be in radians
alpha   = [0, -pi/2, 0, -pi/2, pi/2, -pi/2];
a       = [0, 0, 10, 10, 0, 0];
d       = [0, 0, 1, 1, 0, 0];
% Create the symbolic variables for theta1, theta2, ... , theta6
theta   = sym('t', [1 6]);

% Find the Transformation Matrices using the DH-Parameters
Trans = PUMA_TransMatrices(alpha, a, d, theta);
% Make a column matrix representing the Position of the End-Effector
endPoint = [Trans(1,4,6); Trans(2,4,6); Trans(3,4,6)];
% Find the Jacobian Matrix using the Position matrix of the End-Effector
tempJacob = jacobian(endPoint, theta);

% Create a simplified Jacobian matrix using 'matlabFunction'
matlabFunction(tempJacob, 'File', 'PUMA_Jacob');


% Set the desired destination position of the end-effector
dstPoint = [-1;3;-10];

% Set the values of the theta at present configuration
th(1) = pi/2;  th(2) = pi/3;  th(3) = pi/6;

% Calculate the initial transform matrix
% Matrix containing Joint angle Information and Desired Point Location
t1 = th(1); t2 = th(2); t3 = th(3);
currPoint = [double(subs(Trans(1,4,6))); double(subs(Trans(2,4,6))); ...
                        double(subs(Trans(3,4,6)))];

% Initialize the plot 
scatter3(0, 0, 0, '*');
hold on
scatter3(currPoint(1), currPoint(2), currPoint(3));
scatter3(dstPoint(1), dstPoint(2), dstPoint(3));
title('PUMA 560 Manipulator Simulation')
xlabel('X-Coordinate Axis')
ylabel('Y-Coordinate Axis')
zlabel('Z-Coordinate Axis')
axis square
hold on

PUMA_InverseKinematics(Trans, theta, th, dstPoint)

% Finalize the plot
figure(1)
scatter3(0, 0, 0, '*');
scatter3(currPoint(1), currPoint(2), currPoint(3));
scatter3(dstPoint(1), dstPoint(2), dstPoint(3));
title('PUMA 560 Manipulator Simulation')
xlabel('X-Coordinate Axis')
ylabel('Y-Coordinate Axis')
zlabel('Z-Coordinate Axis')