classdef CVModel < handle
     
   properties 
       circle;
   end
   
   methods
       %constructor
       function self = CVModel()
           self.circle = Circle(OrbConstants().earth);
       end
   end
    
    
end