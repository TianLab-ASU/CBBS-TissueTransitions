% This script generates Fig 3E as seen in the manuscript. The figure plots
% the [L]- and [YTup]-nullclines when kYTup0 is within a tristable range.

% The script requires the 1-parameter bifurcation data when kYTup0 is within a
% tristable range due to a variation in kYTup3. This data exported from
% Oscill8 is within the "NFL-bifurcationdata" folder.

%% Get data for Fig 3E
% Data is obtained when there is a tristable region as observed in Fig 3C
clc;clear;close all
cd ..\Figure2\NFL_bifurcationdata

orig = importdata('bifanalysis_0.85.txt');
pts =findchange(orig);

Para2
cd ..\..\Figure3_4
global kYTup0
%% Plot Nullcline when tristable region is present
% Use kYTup0 value between SN2 and SN4
kYTup0 =(pts(1,4)-pts(1,1))/2+pts(1,1);  % kYTup0 between SN2 and SN4
kYTup3 = 0.85*kYTup3;  % kYTup3 is 85% of its standard parameter set value

%% Plot Fig 3A
% Set up arrays for implicit function in fimplicit
syms L YTup
N = (kN1+kN2*YTup^n/(YTup^n+JN^n))/kN3;
S = (kS1+kS2*YTup^n/(YTup^n+JS^n))/kS3;

U =  kYTup3*YTup*L/(YTup+JYTup3);
V = -(U-kYTup4-kYTp1*JYTup4);
W = (V^2+4*kYTp1*U*JYTup4)^.5;
YTp = (-V+W)/(2*kYTp1);

f(1) = figure(1);
% Plot [L]-nullcline
L_nullcline(L, YTup) =kL1+kL2*YTup^n/(YTup^n+JL^n)-kL3*L==0;
g(1)= fimplicit(L_nullcline, [0 3 0 3], 'Linewidth', 2.5);
hold on

% Plot [YTup]-nullcline
YTup_nullcline(L, YTup) = kYTup0+kYTup1*S^n/(S^n+JYTup1^n)+kYTup2*N^n/(N^n+JYTup2^n)-kYTup3*YTup*L/(YTup+JYTup3)+kYTup4*YTp/(YTp+JYTup4)-kYTup5*YTup==0;
g(2) = fimplicit(YTup_nullcline, [0 3 0 3], 'Linewidth', 2.5);
hold on

% Plot vector field
step = .15; 
vectfield(@Hippo_Null_ODE,[0:step:3],[0:step:3]); hold on;
cb = colorbar;
ylabel(cb, 'Field Strength', 'FontSize', 12)
xlim([0 3])
ylim([0 3])
ylabel('[YT_u_p]')
xlabel('[L]')
legend([g(1) g(2)], '[L]-nullcline', '[YT_u_p-nullcline]')
title('Figure 3E')
%% Functions 
% Function below finds the saddle nodes of the bifurcation diagrams
function Coord = findchange(file)
pos = file(:,1);
x = file(:,4);
y = file(:,5);

A = diff(sign(diff(x)));
B =diff(sign(diff(pos)));

q1 = find(abs(A)==2);
q2 = find(abs(B)==2);

x1 = x(q2)';
y1 = y(q2)';
Coord = [x1; y1];

end