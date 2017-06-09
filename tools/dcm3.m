function C = dcm3(x)
c = cos(x);
s = sin(x);
C = [c s 0;
    -s c 0;
     0 0 1];
end