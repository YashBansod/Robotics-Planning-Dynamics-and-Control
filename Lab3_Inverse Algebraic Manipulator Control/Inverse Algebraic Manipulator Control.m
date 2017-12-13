L1 = 10;
L2 = 10;
X = 20;
Y = 0;

while true

C2 = (X^2 + Y^2 - L1^2 -L2^2)/(2 * L1 * L2);
S2 = sqrt(1-C2^2);

theta2 = atan2(S2, C2)

K1 = L1 + L2* cos(theta2);
K2 = L2 * sin(theta2);
theta1 = atan2(Y, X) - atan2(K2, K1)

X1 = L1*cos(theta1)
Y1 = L1*sin(theta1)

X2 = L1*cos(theta1) + L2*cos(theta1 + theta2)
Y2 = L1*sin(theta1) + L2*sin(theta1 + theta2)

plot([0, X1], [0,Y1]);
hold on;
plot([X1,X2], [Y1, Y2]);
title('2 DOF Planar Manipulator');
legend('1st Link of Arm', '2nd Link of Arm');
grid on;
axis([-30 30 -30 30]);

[X,Y] = ginput;

end
