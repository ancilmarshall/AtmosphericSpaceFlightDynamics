d2r = pi/180;
orbit = Ellipse(OrbConstants().earth);

r = [-5000;0;12500];
v = [5;-8;0];

orbit.orbitFromRV(r,v);
