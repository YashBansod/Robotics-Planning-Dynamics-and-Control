% This generates the Transformation Matrix using the DH parameters
% The parameteres required are the values of a row in DH Table

function Trans = DH_para(alpha, a, d, theta, Trans)
    
% If only 4 parameters were passed, assume that the transformation matrix
% generated has reference frame same as global reference frame (origin).
if (nargin == 4)
    Trans = [cosd(theta), -sind(theta)*cosd(alpha), sind(theta)*sind(alpha), a*cosd(theta);
        sind(theta), cosd(theta)*cosd(alpha), -cosd(theta)*sind(alpha), a*sind(theta);
        0, sind(alpha), cosd(alpha), d;
        0, 0, 0, 1];

% If all 5 parameters were passed, the passed transfomation matrix is used
% as reference frame and new transformation matrix is generated using DH
% parameters. It is then multiplied with passed transformation matrix to
% give new transfomation matrix with respect to global reference frame.
else
    tempTrans =[cosd(theta), -sind(theta)*cosd(alpha), sind(theta)*sind(alpha), a*cosd(theta);
        sind(theta), cosd(theta)*cosd(alpha), -cosd(theta)*sind(alpha), a*sind(theta);
        0, sind(alpha), cosd(alpha), d;
        0, 0, 0, 1];
    
    Trans = Trans * tempTrans;
end

end