function C = dcm1(x)
c = cos(x);
s = sin(x);
C = [1  0 0;
     0  c s;
     0 -s c];
end
