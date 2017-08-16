classdef (Abstract) ConicInterface < handle
    
   properties
       consts;          % constants for the central body
       a;               % semi-major axis
       e;               % eccentricity
       p;               % parameter
       period;          % period
       n;               % mean motion (omega)
       energy;          % total specific energy
       h;               % total specific angular momentum 
       phi;             % flight path angle
       r;               % position magnitude
       v;               % vector magnitude
       ra;              % apoapsis distance
       rp;              % periapsis distance
       theta;           % true anomaly
       tau;             % time since periapsis
       E;               % eccentric anomaly
       H;               % hyperbolic anomaly
       M;               % mean anomaly
       Omega;           % right ascension of ascending node
       i;               % inclination
       omega;           % argument of periapsis
       
       CtoPFromI;       % rotation matrix
       
       rvec;            % celestial position vector
       vvec;            % celestial velocity vector
       
       type;            % enum stating the orbit type
       conic;           % delegate that take care of each conic's calculations
   end
      
   % add property observers and signals for matlab app designer
   properties
      vSignal = Dynamic(0.0);
   end
   
   methods 
      function set.v(self,value)
         self.v = value;
         self.vSignal.value = value;
      end
      
      function set.e(self,value)
         self.e = value;
         [self.conic self.type] = ConicFactory.create(value);
      end
      
   end
end