clear;
clc;

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

PUMA_InverseKinematics(Trans, theta, th, dstPoint)
