classdef Orbit < ConicInterface
   
   methods
      
      %constructor
      function self = Orbit(consts)
         
         if nargin == 0
            self.consts = OrbConstants().earth;
         else 
            self.consts = consts;
         end
         
      end
      
      %TODO: calculate the velocity vectors and then use other global
      %funtions to calculate the rest of the orbit
      function setRVPhi(self,r,v,phi)
         self.r = r;
         self.v = v;
         self.phi = phi;
         
         %TODO: function for different formulations of perifocal r, v
         %[rvec, vvec] = self.perifocalFromRVPhi(r,v,phi);
         
         self.momentumFromRVPhi(r,v,phi);
         self.energyFromRV(r,v);
         self.aFromEnergy(self.energy);
         self.pFromH(self.h);
         self.eFromPA(self.p,self.a);
         self.periodFromA(self.a);
         self.thetaFromPhiHEV(phi,self.h,self.e,v);
         
         %TODO: is there a mean motion for parabola and hyperbola?
         if ( e>0.0 && e < 1.0 )
            self.meanMotionFromA(self.a);
            self.EfromEccTheta(self.e,self.theta);
            self.tauFromEccEN(self.e,self.E,self.n);
         elseif ( e > 1.0 ) 
            self.HFromEccTheta(self.e,self.theta);
            self.tauFromEccAH(self.e,self.a,self.H);
         end 
         
      end
      
      % tau, time since periapsis
      function tauFromEccEN(self,e,E,n)
         self.tau = - (E-e*sin(E))/n;
      end
      
      function tauFromEccAH(self,e,a,H)
         self.tau = (H-e*sinh(H))/sqrt(-self.consts.mu/a^3);
      end
      
      % Eccentric and Hyperbolic anaomalies
      function EFromEccTheta(self,e,theta)
         self.E = 2*atan2(tan(theta/2),sqrt((1+e)/(1-e)));
      end
      
      function HFromEccTheta(self,e,theta)
         self.H = 2*atanh(tan(theta/2)*sqrt((e-1)/(1+e)));
      end
      
      function meanMotionFromA(self,a)
         self.n = sqrt(self.consts.mu/(a)^3);
      end
      
      function thetaFromPhiHEV(self,phi,h,e,v)
         mu = self.consts.mu;
         sinTheta = sin(phi)*h*v/(mu*e);
         cosTheta = ( h*v*cos(phi)/mu - 1)/e;
         self.theta = atan2(sinTheta,cosTheta);
      end
      
      function thetaFromRPFrame(self,rvec,ie,ip)
         cosTheta = dot(ie,rvec);
         sinTheta = dot(ip,rvec);
         theta = atan2(sinTheta,cosTheta);
         self.theta = theta;
      end
      
      function vFromRA(self,r,a)
         mu = self.consts.mu;
         self.v = sqrt(2*mu/r - mu/a);
      end
      
      function periodFromA(self,a)
         self.period = 2*pi*sqrt(a^3/self.consts.mu);
      end
      
      function momentumFromRVPhi(self,r,v,phi)
         self.h = r*v*cos(phi);
      end
      
      function energyFromRV(self,r,v)
         self.energy = v^2/2 - self.consts.mu/r;
      end
      
      function aFromEnergy(self,energy)
         self.a = -self.consts.mu/(2*energy);
      end
      
      function val = velocityFromREnergy(self,r,energy)
         val = sqrt(2*(energy+self.consts.mu/r));
      end
      
      function val = fpaFromHRV(~,h,r,v)
         %TODO: update to take care of sign ambiguity
         val = acos(h/(r*v));
      end
      
      function phiFromEccTheta(self,e,theta)
         self.phi = atan2(e*sin(theta),1+e*cos(theta));
      end
      
      function pFromH(self,h)
         self.p = h^2/self.consts.mu;
      end
      
      function eFromPA(self,p,a)
         self.e = sqrt( 1 - p/a );
      end
      
      function calcCtoPFromI(self,Omega,i,omega)
         self.CtoPFromI = dcm3(omega)*dcm1(i)*dcm3(Omega);
      end
      
      % solve transcendental equation for E
      function kepler(self,e,M)
         fun = @(E) E-e*sin(E)-M;
         E0 = M + e*sin(M);
         self.E = fzero(fun,E0);
      end
      
      %TODO: are these orbital elements only valid for closed orbits?
      function rvFromOrbit(self,Omega,i,omega,a,e,tau)
         self.a = a;
         self.e = e;
         self.tau = tau;
                  
         self.n = sqrt(self.consts.mu/a^3);
         self.M = self.n*tau;
         self.kepler(self.e,self.M);
         
         E = self.E;
         n = self.n;
         
         %perifocal frame
         rvec = [ a*(cos(E)-e); a*sqrt(1-e^2)*sin(E); 0];
         vvec = [ -a*n*sin(E); a*n*sqrt(1-e^2)*cos(E);0]./(1-e*cos(E));
         
         %convert to celestial or inertial frame
         self.calcCtoPFromI(Omega,i,omega);
         C = self.CtoPFromI;
         
         self.rvec = transpose(C)*rvec;
         self.vvec = transpose(C)*vvec;
         
         % TODO: some calculations are redundant here. Update
         self.orbitFromRV(self.rvec,self.vvec);
         
      end
      
      %rvec,vvec are in celestial frame (inertial)
      function orbitFromRV(self,rvec,vvec)
         self.rvec = rvec;
         self.vvec = vvec;
         
         r=mag(rvec);
         v=mag(vvec);
         
         hvec = cross(rvec,vvec);
         h = mag(hvec);
         ih = hvec/h;
         
         nvec = cross([0;0;1],ih);
         nvec = nvec/mag(nvec);
         
         cosOmega = dot(nvec,[1;0;0]);
         sinOmega = dot(nvec,[0;1;0]);
         Omega = atan2(sinOmega,cosOmega);
         
         i = acos(dot([0;0;1],ih));
         
         mu = self.consts.mu;
         evec = cross(vvec,hvec)/mu - rvec/r;
         e = mag(evec);
         ie = evec/e;
         
         ip = cross(ih,ie);
         
         cosomega = dot(nvec,ie);
         sinomega = dot(ih,cross(nvec,ie));
         omega = atan2(sinomega,cosomega);
         
         self.r = r;
         self.v = v;
         self.h = h;
         self.e = e;
         self.Omega = Omega;
         self.i = i;
         self.omega = omega;
         self.calcCtoPFromI(Omega,i,omega);
         
         % calculate all other orbit parameters
         self.energyFromRV(r,v);
         self.pFromH(self.h);
         self.thetaFromRPFrame(rvec,ie,ip);
         self.phiFromEccTheta(self.e,self.theta);
         
         self.ra = self.conic.raFromAE(self.a,self.e);
         self.rp = self.conic.rpFromAE(self.a,self.e);
         
         % for an ellipse
         if ( e > 0.0 && e < 1.0)
            self.aFromEnergy(self.energy);

            self.EFromEccTheta(self.e,self.theta);
            self.meanMotionFromA(self.a);
            
            self.periodFromA(self.a);
            self.tauFromEccEN(self.e,self.E,self.n);
         
         % for a hyperbola
         elseif ( e > 1.0 )
            self.aFromEnergy(self.energy);
            self.HFromEccTheta(self.e,self.theta);
            self.tauFromEccAH(self.e,self.a,self.H);
         
         % for a prabola
         elseif (e == 1.0 )
            self.a = Inf;
            
         % for a circle
         elseif (e == 0.0 )
            
         end
      end
   end
end
