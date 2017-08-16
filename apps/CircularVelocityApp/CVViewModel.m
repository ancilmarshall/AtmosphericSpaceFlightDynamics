classdef CVViewModel < handle
   
   %TODO: Avoid the need to change already constructed classes like Circle
   %to add Dynamic properties that will need changing the lines of the code
   %to call the property.value. Should just need to change ViewModel if
   %possible
   
   properties
      velocityLabelSignal = Dynamic('Empty');
      alt;
   end
   
   properties (Access = private)
      model;
   end
   
   methods
      
      %constructor
      function self = CVViewModel()
         self.model = CVModel();
         self.model.circle.vSignal > @self.updateVelocityLabelText;
      end
      
      function updateVelocityLabelText(self,vel)
         self.velocityLabelSignal.value = ...
            sprintf('Circular velocity is %5.3f km/s',vel);
      end
      
      function set.alt(self,value)
         self.model.circle.alt = value; %#ok<MCSUP>
      end
      
      
   end
   
   
end