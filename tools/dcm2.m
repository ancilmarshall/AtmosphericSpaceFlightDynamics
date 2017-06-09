function C = dcm2(x)
c = cos(x);
s = sin(x);
C = [c 0 -s;
     0 1  0;
     s 0  c];
end