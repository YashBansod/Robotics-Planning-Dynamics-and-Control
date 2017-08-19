function Trans = PUMA_Transformation(alpha, a, d, theta, Trans)
% This generates the Transformation Matrix using the DH-parameters
% The parameteres required are the values of a row in DH Table

%% Create the Transformation Matrix based on number of parameters passed

% If only 4 parameters were passed, assume that the transformation matrix
% generated has reference frame same as global reference frame (origin).
if (nargin == 4)
    Trans = [cos(theta), -sin(theta), 0, a;
        sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
        sin(theta)*sin(alpha), cos(theta)*sin(alpha), cos(alpha), cos(alpha)*d;
        0, 0, 0, 1];

% If all 5 parameters were passed, the passed transfomation matrix is used
% as reference frame and new transformation matrix is generated using DH
% parameters. It is then multiplied with passed transformation matrix to
% give new transfomation matrix with respect to global reference frame.
else
    tempTrans = [cos(theta), -sin(theta), 0, a;
        sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
        sin(theta)*sin(alpha), cos(theta)*sin(alpha), cos(alpha), cos(alpha)*d;
        0, 0, 0, 1];
    
    Trans = Trans * tempTrans;
end

end