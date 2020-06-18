Author: Yash Bansod  
GitHub: https://github.com/YashBansod  

This is the main program. Just call DH_main in command line or run this file to run the program.

## Clear the environment and the command line

```matlab
clear;
clc;
close all;
```

## Add the directory containing relevant functions to the path variables

```matlab
addpath('./DH-functions/')
```

## Define the DH table parameters

```matlab
a = [5, 5, 0];                      % Link Lengths (Along X axis)
alpha = [0, 0, 0];                  % Link Twist (Across X axis)
d = [0, 0, 2];                      % Link Offset (Along Z axis)
theta = [15, 30, 0];                % Link Rotation (Across Z axis)
```

## Call the function that creates and plots the Manipulator

```matlab
DH_table(alpha, a, d, theta);
```

## Results

<div><span class="image fit"><img src="./images/DH_main_01.png" alt="Multi-DOF manipulator"></span></div>

