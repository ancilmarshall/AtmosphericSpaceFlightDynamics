function xdot = eomRotation(t,x,massModel,forceModel)
%SPACEROTATION Program for torque-free rotational dynamics and Euler 3-1-3
%kinematics of a rigid body spacecraft
%
% x(1)= omega_x, x(2)=omega_y, x(3) = omega_z (angular velocity in rad/s)
% x(4)=psi, x(5)=theta, x(6) = phi (euler angles in rad)
%
% (c) 2006 Ashish Tewari

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
