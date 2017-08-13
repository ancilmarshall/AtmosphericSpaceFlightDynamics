% Circular Coplanar Rendezvous example
dtr = pi/180;
rtd = 1/dtr;

consts = OrbConstants().earth;
circleInt = Circle(consts);   % initial circular orbit of interceptor
circleTgt = Circle(consts);   % circular orbit of target
ellipse     = Ellipse(consts);  % transfer orbit

circleInt.updateR(15000); % km
circleTgt.updateR(30000); % km

rp = 15000;
ra = 30000;
a = (rp+ra)/2;
ellipse.a = a;
ellipse.calcPeriod();

tau = ellipse.period/2;
alphaL = circleTgt.n * tau; % lead angle
nu = alphaL - pi;
theta0_tgt = 45*dtr;
theta0_int = 10*dtr;
nui = theta0_int-theta0_tgt;

k=0;
twait = (nu - nui + 2*pi*k)/(circleInt.n-circleTgt.n);
while twait < 0
    k = k+1;
    twait = (nu - nui + 2*pi*k)/(circleInt.n-circleTgt.n);
end







