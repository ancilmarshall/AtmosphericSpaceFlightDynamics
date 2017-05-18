function xdot = spacerotation(t,x)
%SPACEROTATION Program for torque-free rotational dynamics and Euler 3-1-3
%kinematics of a rigid body spacecraft
%
% x(1)= omega_x, x(2)=omega_y, x(3) = omega_z (angular velocity in rad/s)
% x(4)=psi, x(5)=theta, x(6) = phi (euler angles in rad)
%
% (c) 2006 Ashish Tewari

J1=4000; J2=7500; J3=8500; % principal moments of inertia (kg.m^2)
x1=x(1); x2=x(2); x3=x(3); x4=x(4); x5=x(5); x6=x(6);

xdot(1,1) = x2*x3*(J2-J3)/J1;
xdot(2,1) = x3*x1*(J3-J1)/J2;
xdot(3,1) = x1*x2*(J1-J2)/J3;
xdot(4,1) = sin(x6)*x1+cos(x6)*x2/sin(x5);
xdot(5,1) = cos(x6)*x1-sin(x6)*x2;
xdot(6,1) = x3-(sin(x6)*cos(x5)*x1+cos(x6)*cos(x5)*x2)/sin(x5);