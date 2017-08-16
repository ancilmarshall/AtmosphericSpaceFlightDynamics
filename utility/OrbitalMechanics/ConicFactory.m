classdef ConicFactory < handle
   
   methods (Static)
      
      function [conic, type] = create(e)
         
         if ( e > 0.0 && e < 1.0 )
            type = 'Ellipse';
            conic = Ellipse;
         end
      end
      
   end
   
end