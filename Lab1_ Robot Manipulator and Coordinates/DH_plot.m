% This function takes in the Transformation matrix as a parameter and draws
% the coordinate system using it. It also returns the origin of the newly
% created coordinate system.

function [orgX, orgY, orgZ] = DH_plot(Trans)

[r, c] = size(Trans);
if (r ~= 4 | c ~= 4)
    error('Invalid Argument. Transformation Matrix not of correct dimension.');
end

orgX = Trans(1,4);
orgY = Trans(2,4);
orgZ = Trans(3,4);

X = plot3([orgX,Trans(1,4)+Trans(1,1)], [orgY, Trans(2,4)+Trans(2,1)], [orgZ, Trans(3,4)+Trans(3,1)]);
hold on
Y = plot3([orgX,Trans(1,4)+Trans(1,2)], [orgY, Trans(2,4)+Trans(2,2)], [orgZ, Trans(3,4)+Trans(3,2)]);
hold on
Z = plot3([orgX,Trans(1,4)+Trans(1,3)], [orgY, Trans(2,4)+Trans(2,3)], [orgZ, Trans(3,4)+Trans(3,3)]);
hold on

end