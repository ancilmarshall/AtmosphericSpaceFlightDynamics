classdef Ellipse < ConicInterface
     
    methods
        
        %constructor
        function self = Ellipse(consts)
            self.consts = consts;
        end
        
        function setRVPhi(self,r,v,phi)
            self.r = r;
            self.v = v;
            self.phi = phi;
            self.momentumFromRVPhi(r,v,phi);
            self.energyFromRV(r,v);
            self.aFromEnergy(self.energy);
            self.pFromH(self.momentum);
            self.eFromPA(self.p,self.a);
            self.calcPeriod();
            self.calcTheta();
            self.calcE();
            self.calcMeanMotion();
            self.calcTau();
        end
        
        function calcTau(self)
            self.tau = - (self.E-self.e*sin(self.E))/self.n; 
        end
        
        function calcE(self)
           e = self.e;
           theta = self.theta;
           self.E = 2*atan2(tan(theta/2),sqrt((1+e)/(1-e)));
        end
        
        
        function calcMeanMotion(self)
            self.n = sqrt(self.consts.mu/(self.a)^3);
        end
        
        function calcTheta(self)
            h = self.momentum;
            phi = self.phi;
            mu = self.consts.mu;
            e = self.e;
            v = self.v;
            sinTheta = sin(phi)*h*v/(mu*e);
            cosTheta = ( h*v*cos(phi)/mu - 1)/e;
            self.theta = atan2(sinTheta,cosTheta);
        end
        
        function calcVelocityForR(self,r)
            assert(~isEmpty(self.a))
            self.v = sqrt(2*self.consts.mu/r - self.consts.mu/self.a);
        end
        
        function calcPeriod(self)
            self.period = 2*pi*sqrt(self.a^3/self.consts.mu);
        end
        
        function momentumFromRVPhi(self,r,v,phi)
            self.momentum = r*v*cos(phi);
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
            val = acos(h/(r*v));
        end
        
        function pFromH(self,h)
            self.p = h^2/self.consts.mu;
        end
        
        function eFromPA(self,p,a)
            self.e = sqrt( 1 - p/a );
        end
        
    end
    
end