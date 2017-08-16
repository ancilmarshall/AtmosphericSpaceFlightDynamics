classdef Ellipse < handle
   
   properties
      consts
   end
   
   methods 
      function self = Ellipse(consts)
         if nargin == 0
            self.consts = OrbConstants().earth;
         else
            self.consts = consts;
         end
      end
      
      function val = raFromAE(~,a,e)
         val = a*(1+e);
      end
      
      function val = rpFromAE(~,a,e)
         val = a*(1-e);
      end
      
      
   end
   
end