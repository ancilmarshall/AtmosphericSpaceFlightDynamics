classdef Hohmann < handle
    
properties
   consts;
   ra; % outer radius
   rp; % inner radius
   T;  % transfer time
   ellipse;    
   innerCircle;
   outerCircle;
end


methods
    function self = Hohmann(consts)
        self.consts = consts;
        self.ellipse = Ellipse(consts);
        self.innerCircle = Circle(consts);
        self.outerCircle = Circle(consts);
    end
    
    function setRadii(self,rp,ra)
       self.rp = rp;
       self.ra = ra;
       
       self.innerCircle.updateR(rp);
       self.outerCircle.updateR(ra);
       self.ellipse.setRVPhi(rp,self.innerCircle.v,0);
       self.T = self.ellipse.period/2;
    end
    
end
    
end
