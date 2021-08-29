% This file defines variables used for the stochastic simulations. It
% is required for the function "TauLeapWendy_Hippo.m" to run.

% This function needs a specific value of kYTup0 for it to run.
function [S1, P, K] = Hippo_SDE(t,y,kYTup0)

global n 
global kL1 kL2 JL kL3
global kYTup1 JYTup1 kYTup2 JYTup2 
global kYTup3 JYTup3 kYTup4 JYTup4 kYTup5
global kYTp1
global kS1 kS2 JS kS3
global kN1 kN2 JN kN3 
global Omega

L = y(1)/Omega;
YTup = y(2)/Omega;
YTp = y(3)/Omega;
S = y(4)/Omega;
N = y(5)/Omega;


   %L YT YTp S N
S1 =[
    %L
    0 0 0 0 0
    0 0 0 0 0
    1 0 0 0 0
    %YTup
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 1 0 0 0  % this line might require L to have 1.  YTup --> YTp 
    0 0 1 0 0
    0 1 0 0 0
    
    %YTp
    0 0 1 0 0
    
    %S
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 1 0
    
    %N
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 1 
    ];
    
P =[
    %L
    1 0 0 0 0
    1 0 0 0 0
    0 0 0 0 0
    %Yup
    0 1 0 0 0
    0 1 0 0 0
    0 1 0 0 0
    0 0 1 0 0
    0 1 0 0 0
    0 0 0 0 0
    
    %Yp
    0 0 0 0 0
    
    %S
    0 0 0 1 0
    0 0 0 1 0
    0 0 0 0 0
    
    %N
    0 0 0 0 1
    0 0 0 0 1
    0 0 0 0 0
    ];

K =[
    kL1*Omega
    kL2*YTup^n/(YTup^n+JL^n)*Omega %%%%%%%%%%%%
    kL3  % L-->, kL3*[L]*Omega
    
    kYTup0*Omega
    kYTup1*S^n/(S^n+JYTup1^n)*Omega
    kYTup2*N^n/(N^n+JYTup2^n)*Omega
    kYTup3*YTup*L/(YTup+JYTup3)*Omega/(YTup*Omega) % YTup --> YTp, dYTup/dt*Omega=-kYTup3*YTup/(YTup+JYTup3)*L*Omega
    kYTup4*YTp/(YTp+JYTup4)*Omega/(YTp*Omega)
    kYTup5
    
    kYTp1
    
    kS1*Omega
    kS2*YTup^n/(YTup^n+JS^n)*Omega
    kS3
    
    kN1*Omega
    kN2*YTup^n/(YTup^n+JN^n)*Omega
    kN3
];