classdef Circle < ConicInterface
 
    properties 
       alt;
    end
    
    methods
        
        % constructor
        function obj = Circle(consts)
            obj.consts=consts;
        end
        
        function set.alt(self,value)
           self.alt = value;
           self.updateR(self.consts.radius+value);
        end
        
        function updateR(self,r)
           self.r = r;
           self.a = r;
           self.calcVelocity()
           self.calcEnergy();
           self.calcPeriod();
           self.calcMeanMotion();
        end
                
        function calcMomentum(self)
           self.momentum = self.r * self.v; 
        end
        
        function calcEnergy(self)
            self.energy = (self.v^2)/2 - self.consts.mu/self.r;
        end
        
        function calcPeriod(self)
            self.period = 2*pi*sqrt(self.r^3/self.consts.mu);
        end
        
        function calcMeanMotion(self)
            self.n = sqrt(self.consts.mu/(self.r)^3);
        end
        
        function calcVelocity(self)
            self.v = sqrt(self.consts.mu/self.r);
        end
    end
    
end