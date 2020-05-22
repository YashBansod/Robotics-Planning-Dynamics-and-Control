% This creates the Robot Manipulator Link(s) position and orientation.
% The entries of the DH Table are passed as the parameter.

function [] = DH_table(alpha, a, d, theta)

[~, c(1)] = size(alpha);
[~, c(2)] = size(a);
[~, c(3)] = size(d);
[~, c(4)] = size(theta);

if (c(1) ~= c(2) || c(1) ~= c(3) || c(1) ~= c(4))
    error('Invalid arguments. Size of all the arguments should be same')
    return
end

% Plot the Global Reference frame
Trans = DH_para(0,0,0,0);
% or Trans = DH_orient(0,0,0,0,0,0); could also be used
[X(1),Y(1),Z(1)] = DH_plot(Trans);

for i = 1:c(1)
    Trans = DH_para(alpha(i), a(i), d(i), theta(i), Trans);
    [X(i+1),Y(i+1),Z(i+1)] = DH_plot(Trans);
end

DH_draw(X, Y, Z);

end

