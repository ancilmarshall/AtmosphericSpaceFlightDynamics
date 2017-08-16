classdef DynamicCircle < Circle
   
   properties
      vSignal = Dynamic(0);
   end
   
   methods
      
      function self = DynamicCircle(consts)
         self = self@Circle(consts);
      end
      
   end
   
end