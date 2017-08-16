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
      
      % TODO: figure out why I need this MSCUP ignore
      function set.value(self,value)
         self.value = value;         
         if isempty(self.listener) %#ok<MCSUP>
            return
         end
         self.listener(self.value) %#ok<MCSUP>
      end
      
      function bind(self,listener)
         self.listener = listener;
      end
      
      function bindAndFire(self,listener)
         self.listener = listener;
         listener(self.value);
      end
      
      function gt(self,obj)
         self.listener = obj;
      end
      
      function obj = get(self)
         obj = self.value;
      end
      
      function obj = eval(self)
         obj = self.value;
      end
      
   end
   
end