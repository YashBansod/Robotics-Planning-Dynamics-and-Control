function Trans = PUMA_TransMatrices(alpha, a, d, theta)
% This creates the Robot Manipulator Link(s) Transformation Matrix.
% The entries of the DH Table are passed in as the parameter.

%% Handle errors (if any) for the parameters passed into the function

% Check for the dimensions of the parameters passed
[~, c(1)] = size(alpha);
[~, c(2)] = size(a);
[~, c(3)] = size(d);
[~, c(4)] = size(theta);

if (c(1) ~= c(2) || c(1) ~= c(3) || c(1) ~= c(4))
    error('Invalid arguments. Size of all the arguments should be same')
    return
end

%% Generate the Transformation Matrices from the DH-parameters passed

% Find the Transformation matrix from the first row of DH-Table
% This will give us the position and orientation of the end of first link
% of the Robot Manipulator
Trans(:,:,1) = PUMA_Transformation(alpha(1), a(1), d(1), theta(1));

% Find the Transformation matrix from the rest of the rows of DH-Table
% This will give us the position and orientation of the rest of the links
% of the Robot Manipulator
for i = 2:c(1)
    Trans(:,:,i)= PUMA_Transformation(alpha(i), a(i), d(i), theta(i), Trans(:,:, i-1));
end

end

