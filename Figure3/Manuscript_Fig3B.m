% This script plots the dynamics of [YTup], as seen in Fig 3B of the
% manuscript. 

% The script used to generate Fig 2A is run to obtain the
% coordinates of the saddle nodes. These coordinates are then used to 
% calculate the specific value of kYTup0 used in plotting the [YTup]
% dynamics.

%% Get kYTUp0 value for Fig 3B
clear;clc;

run ..\Figure2\Manuscript_Fig2A
clearvars -except pts
global kYTup0
kYTup0 = (pts(1,1)+pts(1,4))/2;

%% Plot [YTup] over time
close all;
%run ..\
Para2 
options = odeset('RelTol', 1e-4);
L_init = repmat([.5, 2.5], 1, 3);
YTup_init = repmat([.15:.5:1.15], 1, 2);

% Set up initial conditions for trajectories
init = [L_init; YTup_init]';

L0 = num2cell(L_init);
YTup0 = num2cell(YTup_init);

% For loop iterates over each initial condition to plot the trajectories
for i= 1:length(init)
   sol = ode15s(@(t,y) Hippo_Null_ODE(t,y), [0 1000], init(i,:), options);
   length(sol.y(2,:));
   figure(1)
   plot(sol.x(1,:), sol.y(2,:), 'Linewidth', 1.5,'DisplayName',strcat('[L](0)', '=', string(L0(i)), ',',' [YT_u_p](0)', '=', string(YTup0(i)) )); hold on;
end
xlim([0 500])
ylim([0 1.5])
xlabel('Time')
ylabel('[YT_u_p]')
legend
h = figure(1);
title('Figure 3B')

