% This script generates both panels Fig 5A and the first panel in Fig 5B.
% The panels in Fig 5A show heatmaps to display the stochastic transitions 
% of cells from the homeostatic state to the degenerative or tumorigenic state. 
% The first panel in Fig 5B displays the distribution of YTup from 1000
% stochastic simulations with only intrinsic noise. 

% The script requires data obtained from running simulations with the
% Tau-leap-based Gillespie algorithm, to include intrinsic noise.
%% Load Intrinsic Simulations Data
load('intr_100_2500_1000cells_r_allcorrect.mat')
Conc_intr = Conc;

%%
kvals = 0:.001:.015;

% Get data at end of simulations with only intrinsic noise
for i = 1:length(Conc_intr(2:end, 2))
    A2(:,i)= Conc_intr{1+i, 2}(:,end);  %YTup values at end of simulation
    B2(:,i)= Conc_intr{1+i, 4}(:,end);  %S values at end of simulation
    C2(:,i)= Conc_intr{1+i, 5}(:,end);  %N values at end of simulation
end

%% Distribution for Intrinsic Simulation(Transitions)
fig(1) = figure(1);
t = tiledlayout(5,1,'TileSpacing','Compact','Padding','Compact');
dis_kvals = [5, 6, 8, 13, 15];

% Plot YTup0 distribution for several values of kYTup0
for i= dis_kvals
    nexttile
    histogram(A2(:,i), 25, 'FaceColor','k', 'EdgeColor','k', 'FaceAlpha', 1)
    title('kYTup0 = '+ string(kvals(i)))
    
    ylim([0 250])
    xlim([0 350])
    xline(15,'--')
    xline(130,'--')
    xticks([0:50:400])    
end

set(gcf, 'Position', [600 100 300 550])
xlabel(t, 'Number of YT_u_p');
ylabel(t, 'Number of cells')
title(t, '0% Parameter Variation')

%% Heatmap for YTup vs S
% Define binsize
bsize = 50;

% Create grid
YTvbins = linspace(0, max(max(A2)), bsize);
Svbins = linspace(0, max(max(B2)), bsize);

fig(2) = figure(2);
t1 = tiledlayout(1,5,'TileSpacing','Compact','Padding','Compact');

for k = dis_kvals
    nexttile
    % Get cell count for each square in grid
    N = histcounts2(B2(:,k), A2(:,k), Svbins, YTvbins);
    % Plot heatmap using grid and cell count for each square
    imagesc(YTvbins, Svbins, N)
    set(gca, 'XLim', YTvbins([1 end]), 'YLim', Svbins([1 end]), 'YDir', 'normal');
    title('kYTup0 = '+ string(kvals(k)))
    colormap jet;
    cb = colorbar;
end
xlabel(t1, 'Number of YT_u_p')
ylabel(t1, 'Number of S')
set(gcf, 'Position', [100 450 1750 350])

% caxis([0 max(max(N))])
cb.Label.String = 'Cell Count';
cb.Label.FontSize = 12;
title(t1, "Figure 5A")
%% Heatmap for YTup vs N
% Create grid
Nvbins = linspace(0, max(max(C2)), bsize);

fig(3) = figure(3);
t2 = tiledlayout(1,5,'TileSpacing','Compact','Padding','Compact');
for k = dis_kvals
    nexttile
    % Get cell count for each square in grid
    N = histcounts2(C2(:,k), A2(:,k), Nvbins, YTvbins);
    % Plot heatmap using grid and cell count for each square
    imagesc(YTvbins, Nvbins, N)
    set(gca, 'XLim', YTvbins([1 end]), 'YLim', Nvbins([1 end]), 'YDir', 'normal');
    title('kYTup0 = '+ string(kvals(k)))
    colormap jet;
    cb = colorbar;
end
xlabel(t2, 'Number of YT_u_p')
ylabel(t2, 'Number of N')
set(gcf, 'Position', [100 50 1750 350])


cb.Label.String = 'Cell Count';
cb.Label.FontSize = 12;
title(t2, "Figure 5A")
 
