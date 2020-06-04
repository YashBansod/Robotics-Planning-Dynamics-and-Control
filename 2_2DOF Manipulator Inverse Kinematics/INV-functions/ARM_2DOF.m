function [Jacobian, Joint] = ARM_2DOF(L1, L2, theta1, theta2, draw, orgX, orgY)
%% Function Configuration
if (nargin == 5)
    orgX = 0;
    orgY = 0;
end

%% Modelling of the Manipulator
X(1)= orgX+ L1*cosd(theta1);
Y(1)= orgY+ L1*sind(theta1);
X(2)= X(1)+ L2*cosd(theta1 + theta2);
Y(2)= Y(1)+ L2*sind(theta1 + theta2);

% Storing the Joint Locations of the Manipulator
Joint = [orgX, orgY; X(1), Y(1); X(2), Y(2)];

% Storing the Jacobian matrix for the current Manipulator configuration
Jacobian = [-L1*sind(theta1) - L2*sind(theta1+theta2), -L2*sind(theta1+theta2);
    L1*cosd(theta1)+ L2*cosd(theta1+theta2), L2*cosd(theta1+theta2)];

% If it was mentioned in the parameter 'draw' then draw the manipulator.
if draw == true
    plot([orgX,X(1)],[orgY,Y(1)]);
    hold on
    plot([X(1),X(2)],[Y(1),Y(2)]);
    axis([-(L1 + L2), (L1 + L2), -(L1 + L2), (L1 + L2)]);
    hold off;
    title('2 DOF Planar Manipulator');
    legend('1st Link of Arm', '2nd Link of Arm');
    drawnow;
end

end

