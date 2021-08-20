
function [dy] = Hippo_ODE(~,y,kYTup0)

global n

global kL1 kL2 JL kL3

global kYTup1 JYTup1 kYTup2 JYTup2 

global kYTup3 JYTup3 kYTup4 JYTup4 kYTup5

global kYTp1

global kS1 kS2 JS kS3

global kN1 kN2 JN kN3 


L = y(1); 
YTup = y(2);
YTp= y(3);
S = y(4);
N = y(5);

%Equations
dy = [kL1+kL2*YTup^n/(YTup^n+JL^n)-kL3*L;
kYTup0+ kYTup1*S^n/(S^n+JYTup1^n)+kYTup2*N^n/(N^n+JYTup2^n)-kYTup3*YTup*L/(YTup+JYTup3)+kYTup4*YTp/(YTp+JYTup4)-kYTup5*YTup;
kYTup3*YTup*L/(YTup+JYTup3)-kYTup4*YTp/(YTp+JYTup4)-kYTp1*YTp;
kS1 + kS2*YTup^n/(YTup^n+JS^n)-kS3*S;
kN1 + kN2*YTup^n/(YTup^n+JN^n)-kN3*N;];

end