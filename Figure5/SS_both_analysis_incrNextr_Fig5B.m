% This script generates the second panel in Fig 5. This panel shows the
% distribution of YTup from 100 stochastic simulations in which both 
% intrinsic and extrinsic noise.

% This script requires data obtained from running the simulations with 
% intrinsic noise by using the Tau-leap-based Gillespie algorithm. 
% These simulations also included extrinsic noise through varying the 
% parameter values from the standard parameter set by 5% using Latin 
% Hypercubic sampling. 
%% Import data
clear;clc;close all

% Load Simulations Data
load('both_100_1000cells_correct_.05extrN.mat')
Conc_05 = Conc;

%%
kvals = 0:.001:.015;
% Following data includes 5% change in parameter values 
for i = 1:length(Conc_05(2:end, 2))
    A1(:,i)= Conc_05{1+i, 2}(:,end);  %YTup values at end of simulation
    B1(:,i)= Conc_05{1+i, 4}(:,end);  %S values at end of simulation
    C1(:,i)= Conc_05{1+i, 5}(:,end);  %N values at end of simulation
end


%% Distribution of [YTup] for simulations with increasing Extrinsic noise(Transitions)
% maxXval = max(max([A1, A2, A3]));
maxYval = 250;
fig(1) = figure(1);
t = tiledlayout(5,1,'TileSpacing','Compact','Padding','Compact');
dis_kvals = [5, 6, 8, 13, 15];
% 8:min(size(A2))-1
for i= dis_kvals
    nexttile
    histogram(A1(:,i), 25, 'FaceColor','k', 'EdgeColor','k', 'FaceAlpha', 1)
    title('kYTup0 = '+ string(kvals(i)))
    ylim([0 maxYval])
%     xlim([0 maxXval])
    xlim([0 350])
    xline(15,'--')
    xline(130,'--')
    xticks([0:50:400])    
end
set(gcf, 'Position', [600 100 300 550])
xlabel(t, '[YT_u_p]');
ylabel(t, 'Number of cells')
title(t, '5% Parameter Variation')
 

 