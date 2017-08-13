classdef Dynamic < handle
   
   properties
      value
   end
   
   properties (Access = private)
      listener
   end
  
   methods
      
      % constructor
      function self = Dynamic(value)
         self.value = value;
      end
      
      % TODO: figure out why I cannot access listener directory but have to
      % go through this fireListener function which does the same thing
      % anyway. 
      function set.value(self,value)
         self.value = value;
         self.fireListener();
      end
      
      function fireListener(self)
         if isempty(self.listener)
            return
         end
         
         self.listener(self.value)
      end
      
      function bind(self,listener)
         self.listener = listener;
      end
      
      
   end
   
end