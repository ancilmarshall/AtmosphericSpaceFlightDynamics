d2r = pi/180;
orbit = Ellipse(OrbConstants().earth);

r = [6524.834;6862.875;6448.296];
v = [4.901327;5.533756;-1.976341];

orbit.orbitFromRV(r,v);