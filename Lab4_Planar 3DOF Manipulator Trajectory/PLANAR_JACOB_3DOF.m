%%
%   Author: Yash Bansod  
%
% GitHub: <https://github.com/YashBansod>  
%
% Demonstrates the calculation of Jacobian for a 3DOF 2D Planar Robot


%% Clear the environment and the command line
clear;
clc;
close all;

%% Calculation of Jacobian for 3DOF 2D Planar Robot
syms t1 t2 t3 L1 L2 L3
orgX = 0;
orgY = 0;

X(1)= orgX+ L1*cos(t1);
Y(1)= orgY+ L1*sin(t1);
X(2)= X(1)+ L2*cos(t1 + t2);
Y(2)= Y(1)+ L2*sin(t1 + t2);
X(3)= X(2)+ L3*cos(t1 + t2 + t3);
Y(3)= Y(2)+ L3*sin(t1 + t2 + t3);

Jacob = [diff(X(3),t1) , diff(X(3), t2) , diff(X(3), t3);
            diff(Y(3), t1), diff(Y(3), t2) , diff(Y(3), t3)]