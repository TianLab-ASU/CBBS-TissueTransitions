% This file contains the functions used to solve the reduced 2-ODE system.
function dy = Hippo_Null_ODE(t,y)
global n
global kL1 kL2 JL kL3
global kYTup1 JYTup1 kYTup2 JYTup2 
global kYTup3 JYTup3 kYTup4 JYTup4 kYTup5
global kYTp1
global kS1 kS2 JS kS3
global kN1 kN2 JN kN3 
global Para0 paranum 

global kYTup0 
L = y(1);
YTup= y(2);

N= (kN1+kN2*YTup^n/(YTup^n+JN^n))/kN3;
S = (kS1+kS2*YTup^n/(YTup^n+JS^n))/kS3;


U =  kYTup3*YTup*L/(YTup+JYTup3);
V = -(U-kYTup4-kYTp1*JYTup4);
W = (V^2+4*kYTp1*U*JYTup4)^.5;
YTp = (-V+W)/(2*kYTp1);

dy = [
       kL1+kL2*YTup^n/(YTup^n+JL^n)-kL3*L;
       kYTup0+kYTup1*S^n/(S^n+JYTup1^n)+kYTup2*N^n/(N^n+JYTup2^n)-kYTup3*YTup*L/(YTup+JYTup3)+kYTup4*YTp/(YTp+JYTup4)-kYTup5*YTup; 
       ];
end