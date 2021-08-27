% This script generates Fig 2 in the supplementary material. It uses the data 
% from the stochastic simulations in which the concentrations of each of the 
% proteins and the time values were saved. The plots display the dynamics 
% of YAP/TAZ, SIRT1, and NOTCH to show the stochastic transitions from the
% homeostatic state to the degeneration or tumorigenic states
%% Import data to plot Stochastic Transitions to Disease States
clear;clc;close all;
load('SI_taufulldata_Fig2.mat')

kYTup0=[0.004, .005, .007, 0.012, 0.014];

%% Determine number of cells to plot
numcells = 10; 
% Select random cells from 1000 simulations
cells = randi([1 length(Conc{1,1}(:,1))],1,numcells); % Picks random cells from 1000 cells

%%
tiles = tiledlayout(3,1,'TileSpacing','Compact','Padding','Compact');
xlims = [25, 80, 80, 70, 60];
for i=1:length(Conc)
    concs = Conc{i};
    figure(i)
    tiles(i) = tiledlayout(3,1,'TileSpacing','Compact','Padding','Compact');
    title(tiles(i),'kYTup0 = '+string(kYTup0(i)))
        
    for j = 1:length(cells)
        % Define variables for number of YTup, S, and N
        YTup = concs{cells(j),1}(:,2);
        S = concs{cells(j),1}(:,4);
        N = concs{cells(j),1}(:,5);
        
        % Defined variable for time
        time = Conc{i}{cells(j),2}(:,1);
        
        %Plot YTup dynamics for specific value of kYTup0
        nexttile(1)
        plot(time', YTup); hold on;
        xlim([0 30*24])
        ylim([0 300])
        ylabel('Number of YT_u_p')
        yline(15,'--')
        yline(130,'--')

        %Plot S dynamics for specific value of kYTup0
        nexttile(2)
        plot(time', S'); hold on;
        xlim([0 30*24])
        ylim([0 500])
        ylabel('Number of S')
        yline(75,'--')
        yline(375,'--')
        
        %Plot N dynamics for specific value of kYTup0
        nexttile(3)
        plot(time', N'); hold on;
        xlim([0 30*24])
        ylim([0 175])
        xlabel('Time')
        ylabel('Number of N')
        set(gcf, 'Position', [700 150 500 600])
    end
        yline(10,'--')
        yline(80,'--')
    % Change renderer for appropriate export to SVG
    set(gcf, 'Renderer', 'painters') 
end
 