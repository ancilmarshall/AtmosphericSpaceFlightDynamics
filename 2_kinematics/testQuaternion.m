% original euler angles
psi0 = pi/4;theta0 = 0.5*pi;phi0 = pi/3;

% form direction cosine matrix 3-1-3
C = dcm3(phi0)*dcm1(theta0)*dcm3(psi0);
q = quaternion(C);

% check with built in matlab functions
Cstd = angle2dcm(psi0,theta0,phi0,'ZXZ');
qstd = dcm2quat(Cstd);


function qnew = toStd(q)
    qnew = [q(4) q(1:3)];
end

function qnew = toNormal(q)
    qnew = [q(2:4) q(1)];
end
