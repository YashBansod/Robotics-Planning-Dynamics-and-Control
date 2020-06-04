function [Jacobian, Joint] = PLANAR_ARM_3DOF(L1, L2, L3, theta1, theta2, theta3, draw)

orgX = 0;
orgY = 0;

%% Modelling of the Manipulator
X(1)= orgX+ L1*cosd(theta1);
Y(1)= orgY+ L1*sind(theta1);
X(2)= X(1)+ L2*cosd(theta1 + theta2);
Y(2)= Y(1)+ L2*sind(theta1 + theta2);
X(3)= X(2)+ L3*cosd(theta1 + theta2 + theta3);
Y(3)= Y(2)+ L3*sind(theta1 + theta2 + theta3);

% Storing the Joint Locations of the Manipulator
Joint = [orgX, orgY; X(1), Y(1); X(2), Y(2); X(3), Y(3)];

% Storing the Jacobian matrix for the current Manipulator configuration
Jacobian = [- L2*sind(theta1 + theta2) - L1*sind(theta1) - L3*sind(theta1 + theta2 + theta3), - L2*sind(theta1 + theta2) - L3*sind(theta1 + theta2 + theta3), -L3*sind(theta1 + theta2 + theta3);
    L2*cosd(theta1 + theta2) + L1*cosd(theta1) + L3*cosd(theta1 + theta2 + theta3), L2*cosd(theta1 + theta2) + L3*cosd(theta1 + theta2 + theta3), L3*cosd(theta1 + theta2 + theta3)];

% If it was mentioned in the parameter 'draw' then draw the manipulator.

if draw == true
    hold on;
    plot([orgX,X(1)],[orgY,Y(1)]);
    plot([X(1),X(2)],[Y(1),Y(2)]);
    plot([X(2),X(3)],[Y(2),Y(3)]);
    hold off;
    axis([-(L1 + L2 + L3) (L1 + L2 + L3) -(L1 + L2 + L3) (L1 + L2 + L3)]);
    % mark the graph with details
    title('3 DOF Planar Manipulator');
    legend('1st Link of Arm', '2nd Link of Arm' , '3rd Link of Arm');
    drawnow;
end

end

