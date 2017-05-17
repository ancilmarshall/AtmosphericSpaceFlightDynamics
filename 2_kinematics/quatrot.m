function qpp = quatrot(q,qp)
% program for combining two successive rotations, given by the quaternions
% q and qp, to produce the final orientation given by the quaternion qpp.
% All the quaternions are stored as row vectors
% (c) 2006 Ashish Tewari

qp1 = qp(1);
qp2 = qp(2);
qp3 = qp(3);
qp4 = qp(4);

qpp = q * [ qp4  qp3 -qp2  qp1; 
           -qp3  qp4  qp1  qp2;
            qp2 -qp1  qp4  qp3;
           -qp1 -qp2 -qp3  qp4
           ]';
