classdef Ellipse < ConicInterface
     
    methods
        
        %constructor
        function obj = Ellipse(consts)
            obj.consts=consts;
        end
        
        function vel = calcVelocityForR(self,r)
            assert(~isEmpty(self.a))
            vel = sqrt(2*self.consts.mu/r - self.consts.mu/self.a);
        end
        
        function period = calcPeriod(obj)
            period = 2*pi*sqrt(obj.a^3/obj.consts.mu);
        end
        
        function h = momentumFromRVFpa(~,r,v,fpa)
            h = r*v*cos(fpa);
        end
        
        function self = energyFromRV(self,r,v)
            self.energy = v^2/2 - self.consts.mu/r;
            if (isempty(self.a))
                self.a = self.aFromEnergy(self.energy);
            end
        end
        
        function val = aFromEnergy(self,e)
            self.a = -self.consts.mu/(2*e);
            val=self.a;
        end
        
        function val = velocityFromREnergy(self,r,energy)
           val = sqrt(2*(energy+self.consts.mu/r));
        end
        
        function val = fpaFromHRV(~,h,r,v)
            val = acos(h/(r*v));
        end
        
        function val = pFromH(self,h)
            val = h^2/self.consts.mu;
        end
        
        function val = eFromPA(~,p,a)
            val = sqrt( 1 - p/a );
        end
        
        
        
    end
    
end