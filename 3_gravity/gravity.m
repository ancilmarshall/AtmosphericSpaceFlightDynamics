function [gc,gnorth] = gravity(r,lat)
% GRAVITY Calculate earth's gravitational nonspherical vector as function
% of position in space
%   [gc,gnorth] = gravity(r,lat)
%  
%   Inputs: 
%     r   - distance from center of the earth (m)
%     lat - latitude (rad)
%   Outputs: Gravity compenents in NED coordinate frame, where
%     gc     - component in the N direction
%     gnorth - component in the D direction
% 
%   Uses Jeffery's constants J2, J3, J4 
%
% (c) 2006 Ashish Tewari

phi = pi/2-lat;
mu = 3.986004e14; % mu=GMe
Re = 6378.135e3;  % m
J2 = 1.08263e-3; 
J3 = 2.532153e-7; 
J4 = 1.6109876e-7;

gc = mu*(1-1.5*J2*(3*cos(phi)^2-1)*(Re/r)^2-2*J3*cos(phi) ...
    *(5*cos(phi)^2-3)*(Re/r)^3-(5/8)*J4*(35*cos(phi)^4 ...
    -30*cos(phi)^2+3)*(Re/r)^4)/r^2;

gnorth = - 3*mu*sin(phi)*cos(phi)*(Re/r)*(Re/r) ...
         *(J2+0.5*J3*(5*cos(phi)^2-1) ...
         *(Re/r)/cos(phi) ...
         +(5/6)*J4*(7*cos(phi)^2-1)*(Re/r)^2)/r^2;
     

