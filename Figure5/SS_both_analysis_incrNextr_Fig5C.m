clear;clc;close all
run ..\Figure2\Manuscript_Fig2

clearvars -except pts;clc; close all

% Load Simulations Data
load('both_100_1000cells_correct_.05extrN.mat')
Conc_05 = Conc;

% load('both_100_1000cells_correct_.10extrN.mat')
% Conc_10 = Conc;
% 
% load('both_100_1000cells_correct_.15extrN.mat')
Conc_15 = Conc;
% All simulations within the 3 datasets are done with intrinsic noise
% Difference between each dataset is parameter variation due to extrinsic
% noise(5%, 10%, 15%)
%%
kvals = 0:.001:.015;
% Following data includes 5% change in parameter values 
for i = 1:length(Conc_05(2:end, 2))
    A1(:,i)= Conc_05{1+i, 2}(:,end);  %YTup values at end of simulation
    B1(:,i)= Conc_05{1+i, 4}(:,end);  %S values at end of simulation
    C1(:,i)= Conc_05{1+i, 5}(:,end);  %N values at end of simulation
end


% % Following data includes 10% change in parameter values
% for i = 1:length(Conc_10(2:end, 2))
%     A2(:,i)= Conc_10{1+i, 2}(:,end);  %YTup values at end of simulation
%     B2(:,i)= Conc_10{1+i, 4}(:,end);  %S values at end of simulation
%     C2(:,i)= Conc_10{1+i, 5}(:,end);  %N values at end of simulation
% end
% 
% % Following data includes 15% change in parameter values
% for i = 1:length(Conc_15(2:end, 2))
%     A3(:,i)= Conc_15{1+i, 2}(:,end);  %YTup values at end of simulation
%     B3(:,i)= Conc_15{1+i, 4}(:,end);  %S values at end of simulation
%     C3(:,i)= Conc_15{1+i, 5}(:,end);  %N values at end of simulation
% end

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
% 
% fig(2) = figure(2);
% t = tiledlayout(5,1,'TileSpacing','Compact','Padding','Compact');
% dis_kvals = [5, 6, 8, 13, 15];
% % 8:min(size(A2))-1
% for i= dis_kvals
%     nexttile
%     histogram(A2(:,i), 25, 'FaceColor','k', 'EdgeColor','k', 'FaceAlpha', 1)
%     title('kYTup0 = '+ string(kvals(i)))
%     ylim([0 maxYval])
% %     xlim([0 maxXval])
%     xlim([0 350])
%     xline(15,'--')
%     xline(130,'--')
%     xticks([0:50:400])    
% end
% set(gcf, 'Position', [600 100 300 550])
% xlabel(t, '[YT_u_p]');
% ylabel(t, 'Number of cells')
% title(t, '10% Parameter Variation')
% 
% 
% fig(3) = figure(3);
% t = tiledlayout(5,1,'TileSpacing','Compact','Padding','Compact');
% dis_kvals = [5, 6, 8, 13, 15];
% % 8:min(size(A2))-1
% for i= dis_kvals
%     nexttile
%     histogram(A3(:,i), 25, 'FaceColor','k', 'EdgeColor','k', 'FaceAlpha', 1)
%     title('kYTup0 = '+ string(kvals(i)))
%     ylim([0 maxYval])
% %     xlim([0 maxXval])
%     xlim([0 350])
%     xline(15,'--')
%     xline(130,'--')
%     xticks([0:50:400])
% end
% set(gcf, 'Position', [600 100 300 550])
% xlabel(t, '[YT_u_p]');
% ylabel(t, 'Number of cells')
% title(t, '15% Parameter Variation')

%% Heatmaps for YTup vs S for Increasing Extrinsic Noise
% bsize = 5;
% YTvbins = 0:bsize:max(max(A1));
% Svbins = 0:bsize:max(max(B1));
% 
% fig(4) = figure(4);
% t1 = tiledlayout(1,5,'TileSpacing','Compact','Padding','Compact');
% for k = dis_kvals
%     nexttile
%     N = histcounts2(A1(:,k), B1(:,k), YTvbins, Svbins);
%     imagesc(YTvbins, Svbins, N)
%     set(gca, 'XLim', YTvbins([1 end]), 'YLim', Svbins([1 end]), 'YDir', 'normal');
%     title('kYTup0 = '+ string(kvals(k)))
% end
% xlabel(t1, '[YT_u_p]')
% ylabel(t1, '[S]')
% set(gcf, 'Position', [100 50 1750 350])
% colormap jet;
% cb = colorbar;
% % caxis([0 max(max(N))])
% caxis([0 15])
% cb.Label.String = 'Cell Count';
% cb. Label.FontSize = 12;

% 
% YTvbins = 0:bsize:max(max(A2));
% Svbins = 0:bsize:max(max(B2));
% 
% fig(5) = figure(5);
% t1 = tiledlayout(1,5,'TileSpacing','Compact','Padding','Compact');
% for k = dis_kvals
%     nexttile
%     N = histcounts2(A2(:,k), B2(:,k), YTvbins, Svbins);
%     imagesc(YTvbins, Svbins, N)
%     set(gca, 'XLim', YTvbins([1 end]), 'YLim', Svbins([1 end]), 'YDir', 'normal');
%     title('kYTup0 = '+ string(kvals(k)))
% end
% xlabel(t1, '[YT_u_p]')
% ylabel(t1, '[S]')
% set(gcf, 'Position', [100 50 1750 350])
% colormap jet;
% cb = colorbar;
% % caxis([0 max(max(N))])
% caxis([0 15])
% cb.Label.String = 'Cell Count';
% cb. Label.FontSize = 12;
% 
% 
% 
% YTvbins = 0:bsize:max(max(A3));
% Svbins = 0:bsize:max(max(B3));
% 
% fig(6) = figure(6);
% t1 = tiledlayout(1,5,'TileSpacing','Compact','Padding','Compact');
% for k = dis_kvals
%     nexttile
%     N = histcounts2(A3(:,k), B3(:,k), YTvbins, Svbins);
%     imagesc(YTvbins, Svbins, N)
%     set(gca, 'XLim', YTvbins([1 end]), 'YLim', Svbins([1 end]), 'YDir', 'normal');
%     title('kYTup0 = '+ string(kvals(k)))
% end
% xlabel(t1, '[YT_u_p]')
% ylabel(t1, '[S]')
% set(gcf, 'Position', [100 50 1750 350])
% colormap jet;
% cb = colorbar;
% % caxis([0 max(max(N))])
% caxis([0 15])
% cb.Label.String = 'Cell Count';
% cb. Label.FontSize = 12;
% 

%% Heatmap for YTup vs N
% bsize = 5;
% YTvbins = 0:bsize:max(max(A1));
% Nvbins = 0:bsize:max(max(C1));
% 
% fig(7) = figure(7);
% t1 = tiledlayout(1,5,'TileSpacing','Compact','Padding','Compact');
% for k = dis_kvals
%     nexttile
%     N = histcounts2(A1(:,k), C1(:,k), YTvbins, Nvbins);
%     imagesc(YTvbins, Nvbins, N)
%     set(gca, 'XLim', YTvbins([1 end]), 'YLim', Nvbins([1 end]), 'YDir', 'normal');
%     title('kYTup0 = '+ string(kvals(k)))
% end
% xlabel(t1, '[YT_u_p]')
% ylabel(t1, '[N]')
% set(gcf, 'Position', [100 50 1750 350])
% colormap jet;
% cb = colorbar;
% % caxis([0 max(max(N))])
% caxis([0 15])
% cb.Label.String = 'Cell Count';
% cb. Label.FontSize = 12;
% 
% 
% YTvbins = 0:bsize:max(max(A2));
% Nvbins = 0:bsize:max(max(C2));
% 
% fig(8) = figure(8);
% t1 = tiledlayout(1,5,'TileSpacing','Compact','Padding','Compact');
% for k = dis_kvals
%     nexttile
%     N = histcounts2(A2(:,k), C2(:,k), YTvbins, Nvbins);
%     imagesc(YTvbins, Nvbins, N)
%     set(gca, 'XLim', YTvbins([1 end]), 'YLim', Nvbins([1 end]), 'YDir', 'normal');
%     title('kYTup0 = '+ string(kvals(k)))
% end
% xlabel(t1, '[YT_u_p]')
% ylabel(t1, '[N]')
% set(gcf, 'Position', [100 50 1750 350])
% colormap jet;
% cb = colorbar;
% % caxis([0 max(max(N))])
% caxis([0 15])
% cb.Label.String = 'Cell Count';
% cb. Label.FontSize = 12;
% 
% 
% 
% YTvbins = 0:bsize:max(max(A3));
% Nvbins = 0:bsize:max(max(C3));
% 
% fig(9) = figure(9);
% t1 = tiledlayout(1,5,'TileSpacing','Compact','Padding','Compact');
% for k = dis_kvals
%     nexttile
%     N = histcounts2(A3(:,k), C3(:,k), YTvbins, Nvbins);
%     imagesc(YTvbins, Nvbins, N)
%     set(gca, 'XLim', YTvbins([1 end]), 'YLim', Nvbins([1 end]), 'YDir', 'normal');
%     title('kYTup0 = '+ string(kvals(k)))
% end
% xlabel(t1, '[YT_u_p]')
% ylabel(t1, '[N]')
% set(gcf, 'Position', [100 50 1750 350])
% colormap jet;
% cb = colorbar;
% caxis([0 max(max(N))])
% % caxis([0 15])
% cb.Label.String = 'Cell Count';
% cb. Label.FontSize = 12;

%% Save Files
cd ..\FinalizedFigures
saveas(fig(1), 'SS_YTupdist_.05bothN_Fig5B2.png')

cd  SVG_files
saveas(fig(1), 'SS_YTupdist_.05bothN_Fig5B2.svg')

cd ..\..\Figure5