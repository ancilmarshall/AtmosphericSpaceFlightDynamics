

h=200; %km
circle = Circle(OrbConstants().earth);
velC = circle.calcVelocityForHeight(h);

deltaV = 0.5; %km/s

% ellipse
ellipse = Ellipse(OrbConstants().earth);

% conditions r, v at the apogee
velA = velC-deltaV;
rA = circle.consts.radius + h;

% once r, v, phi known, we can define the constants
ellipse.setRVPhi(rA,velA,0);

rP = 2*ellipse.a - rA;
velP = ellipse.velocityFromREnergy(rP,ellipse.energy);

% change r, solve for v, phi, 
r = OrbConstants().earth.radius+100;
v = ellipse.velocityFromREnergy(r,ellipse.energy);
phi = ellipse.fpaFromHRV(ellipse.momentum,r,v);

ellipse.setRVPhi(r,v,-phi);
