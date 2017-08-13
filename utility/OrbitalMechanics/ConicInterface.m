classdef ConicInterface < handle
    
   properties
       a;               % semi-major axis
       e;               % eccentricity
       p;               % parameter
       period;          % period
       n;               % mean motion (omega)
       energy;          % total specific energy
       momentum;        % total specific angular momentum 
       phi;             % flight path angle
       r;               % position magnitude
       v;               % vector magnitude
       theta;           % true anomaly
       tau;             % time since periapsis
       E;               % eccentric anomaly
       H;               % hyperbolic anomaly
       M;               % mean anomaly
       consts;          % constants for the central body
       
   end
   
   methods (Abstract)
      calcPeriod(obj)
   end
    
end