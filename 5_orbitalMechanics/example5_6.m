% Example 5_6
d2r = pi/180;

orb1 = Orbit;
orb2 = Orbit;

R = OrbConstants().earth.radius;

orb1.r = 500 + R;
orb1.i = 10 * d2r;
orb1.vFromRA(orb1.r,orb1.r); % cirular velocity

orb2.ra = 700 + R;
orb2.rp = 200 + R;
orb2.a = 0.5*(orb2.ra + orb2.rp); 
orb2.e = orb2.ra/orb2.a - 1; % eFromARa

% at intersection of ellipse and circle, r = r_circle
orb2.vFromRA(orb1.r,orb2.a);
orb2.p = orb2.a * (1 - orb2.e^2);
orb2.h = sqrt( OrbConstants().earth.mu * orb2.p );
h = orb2.h;
v = orb2.v;
r = orb1.r;

phi = acos( h / (r*v) );

% go from initial orbit of vel vi to final orbit of vel vf with angle phi
vi = orb1.v;
vf = orb2.v;

deltav = sqrt( vi^2 + vf^2 - 2*vi*vf*cos(phi));

% to perform the plane change maneuver, do so at the apogee
orb2.vFromRA(orb2.ra,orb2.a);
vi = orb2.v;
alpha = 5*d2r;


