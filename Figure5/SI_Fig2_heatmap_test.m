%% Load Intrinsic Simulations Data
load('SI_fulldata_Fig2.mat')
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
% fig(1) = figure(1);
% t = tiledlayout(5,1,'TileSpacing','Compact','Padding','Compact');
dis_kvals = [5, 6, 8, 13, 15];
% % 8:min(size(A2))-1
% for i= dis_kvals
%     nexttile
%     histogram(A2(:,i), 25, 'FaceColor','k', 'EdgeColor','k', 'FaceAlpha', 1)
%     title('kYTup0 = '+ string(kvals(i)))
%     ylim([0 250])
% %     xlim([0 maxXval])
%     xlim([0 350])
%     xline(15,'--')
%     xline(130,'--')
%     xticks([0:50:400])    
% end
% set(gcf, 'Position', [600 100 300 550])
% xlabel(t, 'Number of YT_u_p');
% ylabel(t, 'Number of cells')
% title(t, '0% Parameter Variation')

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
cb. Label.FontSize = 12;

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
cb. Label.FontSize = 12;

%%
cd SI_Fig2_Figures\
saveas(fig(2), 'YTupvS_heatmap_intrsim_Fig5A_test.png')
saveas(fig(3), 'YTupvN_heatmap_intrsim_Fig5A_test.png')

saveas(fig(2), 'YTupvS_heatmap_intrsim_Fig5A_test.svg')
saveas(fig(3), 'YTupvN_heatmap_intrsim_Fig5A_test.svg')

cd ..
% %% Tristable region due to YAP/TAZ-LATS1/2 Feedback Loop Strength
% % Made kYTup3 =.85*kYTup3 and kept kYTup0 as 0.0073
% load('Conc_intr_100_1000cells_correct_tristab.85.mat')
% Conc_tri = Conc;
% 
% A3 = Conc_tri{2,2}(:,end);  % YTup
% B3 = Conc_tri{2,4}(:,end);  % S
% C3 = Conc_tri{2,5}(:,end);  % N
% %%
% YTvbins = 0:bsize:max(A3);
% Svbins = 0:bsize:max(B3);
% 
% fig(3) = figure(3);
% N = histcounts2(A3, B3, YTvbins, Svbins);
% imagesc(YTvbins, Svbins, N)
% set(gca, 'XLim', YTvbins([1 end]), 'YLim', Svbins([1 end]), 'YDir', 'normal');
% title('kYTup0 = '+ string(0.0073))
% xlabel('[YT_u_p]')
% ylabel('[S]')
% % set(gcf, 'Position', [100 50 1750 350])
% colormap jet;
% cb = colorbar;
% caxis([0 15])
% 
% cb.Label.String = 'Cell Count';
% cb. Label.FontSize = 12;
