classdef ConicInterface
    
   properties
       a;
       e;
       p;
       period;
       energy;
       momentum;
       fpa;
       r;
       v;
       consts;
   end
   
   methods (Abstract)
      calcVelocityForR(obj,r)
      calcPeriod(obj)
   end
    
end