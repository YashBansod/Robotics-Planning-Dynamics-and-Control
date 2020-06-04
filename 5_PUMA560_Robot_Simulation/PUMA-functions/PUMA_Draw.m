function [] = PUMA_Draw(X, Y, Z)
% This is used to draw lines in a 3D space using an array of coordinates
% passed in as the parameter

%% Handle errors (if any) due to invalid dimensions of the parameters
[r(1), c(1)] = size(X);
[r(2), c(2)] = size(Y);
[r(3), c(3)] = size(Z);

if (c(1) ~= c(2) | c(1) ~= c(3))
    error('Invalid arguments. Size of all the arguments should be same')
    return
end

if (c(1) < 2)
    error('The input coordinate arrays should have atleast 2 entries')
end

%% Draw the line through the points marked by the parameter
% hold on
for i = 1:(c(1)-1)
    plot3([X(i), X(i+1)], [Y(i), Y(i+1)], [Z(i), Z(i+1)]);
end
drawnow;

end
