% This file defines the parameters and their values for our model.

global n
global kL1 kL2 JL kL3
global kYTup1 JYTup1 kYTup2 JYTup2 
global kYTup3 JYTup3 kYTup4 JYTup4 kYTup5
global kYTp1
global kS1 kS2 JS kS3
global kN1 kN2 JN kN3 
global Para0 paranum 

kL1 =.15; kL2 = .2; JL = .05; kL3 =.2166;
kYTup1 = .0225; JYTup1 =1; kYTup2 = .105; JYTup2 =1;  
kYTup3 =.045; JYTup3 = 1; kYTup4 =.05; JYTup4 = 1; kYTup5 = .033;
kYTp1 =.05;
kS1 =.01; kS2 = 1; JS = .5; kS3 =.231; 
kN1 =.01; kN2 = .525; JN = 1.95; kN3 =.231;   
n = 2;

Para0 = [
kL1 kL2 JL kL3 ...
kYTup1 JYTup1 kYTup2 JYTup2 ...
kYTup3 JYTup3 kYTup4 JYTup4 kYTup5 ...
kYTp1 kS1 kS2 JS kS3 ...
kN1 kN2 JN kN3];
%
paranum = size(Para0, 2);
