

h=200; %km
circle = Circle(OrbConstants().earth);
velC = circle.calcVelocityForHeight(h);

deltaV = 0.5; %km/s

% ellipse
ellipse = Ellipse(OrbConstants().earth);

% conditions r, v at the apogee
velA = velC-deltaV;
rA = circle.consts.radius + h;

% once r, v, fpa known, we can define the constants
momentum = ellipse.momentumFromRVFpa(rA,velA,0);
ellipse = ellipse.energyFromRV(rA,velA); 
energy = ellipse.energy;
p = ellipse.pFromH(momentum);
a = ellipse.aFromEnergy(energy);
e = ellipse.eFromPA(p,a);

rP = 2*a - rA;
velP = ellipse.velocityFromREnergy(rP,energy);

% change r, solve for v, fpa, 
r = OrbConstants().earth.radius+100;
v = ellipse.velocityFromREnergy(r,energy);
fpa = ellipse.fpaFromHRV(momentum,r,v);

