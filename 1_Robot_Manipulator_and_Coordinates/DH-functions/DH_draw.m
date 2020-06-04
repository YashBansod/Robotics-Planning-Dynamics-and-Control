% This is used to draw lines in a 3D space using an array of coordinates
% passed in as the parameter

function [] = DH_draw(X, Y, Z)

[~, c(1)] = size(X);
[~, c(2)] = size(Y);
[~, c(3)] = size(Z);

if (c(1) ~= c(2) || c(1) ~= c(3))
    error('Invalid arguments. Size of all the arguments should be same')
    return
end

if (c(1) < 2)
    error('The input coordinate arrays should have atleast 2 entries')
end

for i = 1:(c(1)-1)
    plot3([X(i), X(i+1)], [Y(i), Y(i+1)], [Z(i), Z(i+1)]);
    hold on
end

end
