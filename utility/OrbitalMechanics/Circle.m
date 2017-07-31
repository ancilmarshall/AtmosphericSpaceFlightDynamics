classdef Circle < ConicInterface
 
    methods
        
        function obj = Circle(consts)
            obj.consts=consts;
        end
        
        function vel = calcVelocityForR(self,r)
            vel = sqrt(self.consts.mu/r);
        end
        
        function vel = calcVelocityForHeight(self,h)
            r = self.consts.radius + h;
            vel = sqrt(self.consts.mu/r);
        end
        
        function period = calcPeriod(self)
            period = 2*pi*sqrt(self.r^3/self.consts.mu);
        end
    end
    
end