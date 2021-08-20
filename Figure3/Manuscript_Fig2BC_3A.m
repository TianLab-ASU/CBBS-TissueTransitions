% This script outputs three figures, Fig 2B, 2C, and 3A as seen in the
% manuscript. All three figures include the [L]- and [YTup]-nullclines but
% with different values of kYTup0. The script to generate Fig 2A is ran to obtain
% the coordinates of the saddle nodes, which are later used to determine the
% specific kYTup0 values for each figure

%% Get kYTup0 value for Fig 3A
% kYTup0 is in the middle of the monostable homeostatic region
clc;clear;close all
run ..\Figure2\Manuscript_Fig2
clearvars -except kYTup0_1 pts ;close all;clc

Para2 
global kYTup0

kYTup0 = kYTup0_1;   % this value of kYTup0_1 was calculated in the file "Manuscript_Fig3"

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

%% Plot examples of trajectories from different starting points 
% Create meshgrid to use for streamline
[L1 YTup1] = meshgrid(0:0.01:3,0:0.01:3);
N1= (kN1+kN2*YTup1.^n./(YTup1.^n+JN^n))/kN3;
S1 = (kS1+kS2*YTup1.^n./(YTup1.^n+JS^n))/kS3;

U =  kYTup3*YTup1.*L1./(YTup1+JYTup3);
V = -(U-kYTup4-kYTp1*JYTup4);
W = (V.^2+4*kYTp1*U*JYTup4).^.5;
YTp = (-V+W)/(2*kYTp1);

dLdt= kL1+kL2*YTup1.^n./(YTup1.^n+JL^n)-kL3*L1;
dYTdt = kYTup0+kYTup1*S1.^n./(S1.^n+JYTup1^n)+kYTup2*N1.^n./(N1.^n+JYTup2^n)-kYTup3*YTup1.*L1./(YTup1+JYTup3)+kYTup4*YTp./(YTp+JYTup4)-kYTup5*YTup1; 

% Set coordinates for initial conditions of trajectories
startx = [.5, .5, .5, 2.5, 2.5, 2.5];
starty = [.15, .65, 1.15,.15, .65, 1.15];

% Plot the trajectories
traj =streamline(L1, YTup1,dLdt, dYTdt, startx,starty ); hold on;
set(traj, 'Linewidth', 2, 'Color', 'k')
g(3) = plot(startx, starty, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 2.5);

legend([g(1), g(2), g(3)], '[L]-nullcline', '[YT_u_p]-nullcline', 'Trajectories','Location', 'northeast')


%% Set kYTup0 value for Fig 2B 
% kYTup0 is in the middle of the first bistable region(degenerative-homeostatic)

kYTup0 = (pts(1,1)+pts(1,2))/2;

%% Plot Fig 2B
% Set up arrays for implicit function in fimplicit
syms L YTup
N = (kN1+kN2*YTup^n/(YTup^n+JN^n))/kN3;
S = (kS1+kS2*YTup^n/(YTup^n+JS^n))/kS3;

U =  kYTup3*YTup*L/(YTup+JYTup3);
V = -(U-kYTup4-kYTp1*JYTup4);
W = (V^2+4*kYTp1*U*JYTup4)^.5;
YTp = (-V+W)/(2*kYTp1);

f(2) = figure(2);
% Plot [L]-nullcline
L_nullcline(L, YTup) =kL1+kL2*YTup^n/(YTup^n+JL^n)-kL3*L==0;
g(1)= fimplicit(L_nullcline, [0 3 0 3], 'Linewidth', 2.5);
hold on

% Plot [YTup]-nullcline
YTup_nullcline(L, YTup) = kYTup0+kYTup1*S^n/(S^n+JYTup1^n)+kYTup2*N^n/(N^n+JYTup2^n)-kYTup3*YTup*L/(YTup+JYTup3)+kYTup4*YTp/(YTp+JYTup4)-kYTup5*YTup==0;
g(2) = fimplicit(YTup_nullcline, [0 3 0 3], 'Linewidth', 2.5);
hold on

% Plot vector field
step = .15; % .15(first) and .1(second)
vectfield(@Hippo_Null_ODE,[0:step:3],[0:step:3]); hold on;
cb = colorbar;
ylabel(cb, 'Field Strength', 'FontSize', 12)
xlim([0 3])
ylim([0 3])
ylabel('[YT_u_p]')
xlabel('[L]')
%% Plot examples of trajectories from different starting points 
% Create meshgrid to use for streamline
[L1 YTup1] = meshgrid(0:0.01:3,0:0.01:3);
N1= (kN1+kN2*YTup1.^n./(YTup1.^n+JN^n))/kN3;
S1 = (kS1+kS2*YTup1.^n./(YTup1.^n+JS^n))/kS3;

U =  kYTup3*YTup1.*L1./(YTup1+JYTup3);
V = -(U-kYTup4-kYTp1*JYTup4);
W = (V.^2+4*kYTp1*U*JYTup4).^.5;
YTp = (-V+W)/(2*kYTp1);

dLdt= kL1+kL2*YTup1.^n./(YTup1.^n+JL^n)-kL3*L1;
dYTdt = kYTup0+kYTup1*S1.^n./(S1.^n+JYTup1^n)+kYTup2*N1.^n./(N1.^n+JYTup2^n)-kYTup3*YTup1.*L1./(YTup1+JYTup3)+kYTup4*YTp./(YTp+JYTup4)-kYTup5*YTup1; 

% Set coordinates for initial conditions of trajectories
startx = [.5, .5, .5, 2.5, 2.5, 2.5];
starty = [.15, .65, 1.15,.15, .65, 1.15];

% Plot the trajectories
traj =streamline(L1, YTup1,dLdt, dYTdt, startx,starty ); hold on;
set(traj, 'Linewidth', 2, 'Color', 'k')
g(3) = plot(startx, starty, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 2.5);

legend([g(1), g(2), g(3)], '[L]-nullcline', '[YT_u_p]-nullcline', 'Trajectories','Location', 'northeast')

%% Set kYTup0 value for Fig 2C 
% kYTup0 is in the middle of the second bistable region(homeostatic-tumorigenic)
kYTup0 = (pts(1,3)+pts(1,4))/2;

%% Plot Fig 2C
% Set up arrays for implicit function in fimplicit
syms L YTup
N = (kN1+kN2*YTup^n/(YTup^n+JN^n))/kN3;
S = (kS1+kS2*YTup^n/(YTup^n+JS^n))/kS3;

U =  kYTup3*YTup*L/(YTup+JYTup3);
V = -(U-kYTup4-kYTp1*JYTup4);
W = (V^2+4*kYTp1*U*JYTup4)^.5;
YTp = (-V+W)/(2*kYTp1);

f(3) = figure(3);
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

%% Plot examples of trajectories from different starting points 
% Create meshgrid to use for streamline
[L1 YTup1] = meshgrid(0:0.01:3,0:0.01:3);
N1= (kN1+kN2*YTup1.^n./(YTup1.^n+JN^n))/kN3;
S1 = (kS1+kS2*YTup1.^n./(YTup1.^n+JS^n))/kS3;

U =  kYTup3*YTup1.*L1./(YTup1+JYTup3);
V = -(U-kYTup4-kYTp1*JYTup4);
W = (V.^2+4*kYTp1*U*JYTup4).^.5;
YTp = (-V+W)/(2*kYTp1);

dLdt= kL1+kL2*YTup1.^n./(YTup1.^n+JL^n)-kL3*L1;
dYTdt = kYTup0+kYTup1*S1.^n./(S1.^n+JYTup1^n)+kYTup2*N1.^n./(N1.^n+JYTup2^n)-kYTup3*YTup1.*L1./(YTup1+JYTup3)+kYTup4*YTp./(YTp+JYTup4)-kYTup5*YTup1; 

% Set coordinates for initial conditions of trajectories
startx = [.5, .5, .5, 2.5, 2.5, 2.5];
starty = [.15, .65, 1.15,.15, .65, 1.15];

% Plot the trajectories
traj =streamline(L1, YTup1,dLdt, dYTdt, startx,starty ); hold on;
set(traj, 'Linewidth', 2, 'Color', 'k')
g(3) = plot(startx, starty, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 2.5);


legend([g(1), g(2), g(3)], '[L]-nullcline', '[YT_u_p]-nullcline', 'Trajectories','Location', 'northeast')


%% Save Figures
cd ..\FinalizedFigures 
saveas(f(1), 'Nullclines_H_Fig3A.png');
saveas(f(2), 'Nullclines_1stSwitch_Fig2B.png');
saveas(f(3), 'Nullclines_2ndSwitch_Fig2C.png');

cd SVG_files
saveas(f(1), 'Nullclines_H_Fig3A.svg');
saveas(f(2), 'Nullclines_1stSwitch_Fig2B.svg');
saveas(f(3), 'Nullclines_2ndSwitch_Fig2C.svg');

cd ..\..\Figure3
