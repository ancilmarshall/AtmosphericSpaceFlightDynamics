function xdot = eomRotation(t,x,massModel,forceModel)
%EOMROTATION Euler's equation of motion with with inertia and force model
%input. Quaternions is the kinematic differential equations
%
% x(1)= omega_x, x(2)=omega_y, x(3) = omega_z (angular velocity in rad/s)
% x(4)= q1, x(5)=q2, x(6)=q3, x(7)=q4, where q4 is the scalar part of the
% quaternions

J = massModel;
M = forceModel;

w = x(1:3);
q = x(4:6);
q4 =x(7);

wdot = J\(M-cross(w,J*w));
qdot = 0.5*(q4*w-cross(w,q));
q4dot = -0.5*dot(w,q);
quaternionDot = [qdot;q4dot];

xdot = [wdot;quaternionDot];
