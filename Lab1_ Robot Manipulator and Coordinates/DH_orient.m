% This generates the Transformation Matrix using the orientation and
% position information of the 3 axes.

function Trans = DH_orient(A, B, G, dX, dY, dZ)

Rot= [cosd(G)*cosd(B), cosd(G)*sind(B)*sind(A)-sind(A)*cosd(A), cosd(G)*sind(B)*cosd(A)+sind(G)*sind(A);
    sind(G)*sind(B), sind(G)*sind(B)*sind(A)+cosd(G)*cosd(A), sind(G)*sind(B)*cosd(G)-cosd(G)*sind(A);
    -sind(B), cosd(B)*sind(A), cosd(B)*cosd(A);
    0, 0, 0];
Disp = [dX; dY; dZ; 1];

Trans = horzcat(Rot, Disp); 
end