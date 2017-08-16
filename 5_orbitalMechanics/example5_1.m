d2r = pi/180;
orbit = Orbit;

a = 8000; %km
e = 0.5;
tau = 50*60 - (-1000);
omega = -85*d2r;
Omega = 60*d2r;
i     = 98*d2r;

orbit.rvFromOrbit(Omega,i,omega,a,e,tau);
