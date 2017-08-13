classdef CVViewModel < handle
   
   %TODO: Avoid the need to change already constructed classes like Circle
   %to add Dynamic properties that will need changing the lines of the code
   %to call the property.value. Should just need to change ViewModel if
   %possible
   
   properties
      velocityLabel = Dynamic('Empty');
      alt;
   end
   
   properties (Access = private)
      model;
   end
   
   methods
      
      %constructor
      function self = CVViewModel()
         self.model = CVModel();
         self.model.circle.v.bind(@self.updateVelocityLabelText);
      end
      
      function updateVelocityLabelText(self,vel)
         self.velocityLabel.value = ...
            sprintf('Circular velocity is %5.3f km/s',vel);
      end
      
      function set.alt(self,value)
         self.model.circle.alt = value; %#ok<MCSUP>
         
         % TODO: also need to bind to changes in the model to be represented
         % in the view model
         
         %          if isempty(self.model.circle.v)
         %             self.velocityLabel.value = ...
         %                'Circular velocity is n/a km/s';
         %             return
         %          end
         %
         %          self.velocityLabel.value = ...
         %             sprintf('Circular velocity is %5.3f km/s',self.model.circle.v);
         %
      end
      
      
   end
   
   
end