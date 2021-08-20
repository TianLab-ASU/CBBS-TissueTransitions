%% Import data for 1-p bifurcation diagram where JN was decreased by 15%
clear;clc;close all
cd rawdata_1p_parsent
orig = importdata('JN_-.txt');
cd ..
%% Get x and y coordinates to plot bifurcation diagram
pts =findchange(orig);
x1 = orig(:,4);
y1 = orig(:,5);

%% Plot bifurcation diagram
[n, m] = size(pts); 
% Find points where each branch begins and ends
for j = 1:m
xvals(j) = find(x1 == pts(1,j));
end

fig1 = figure(1);
d1 = plot(x1(1:xvals(1)),y1(1:xvals(1)),'b','LineWidth',1.5);hold on;
plot(x1(xvals(1)+1:xvals(2)),y1(xvals(1)+1:xvals(2)),'k--','LineWidth',1.5);
h1 = plot(x1(xvals(2)+1:xvals(3)),y1(xvals(2)+1:xvals(3)),'g','LineWidth',1.5);
plot(x1(xvals(3)+1:xvals(4)),y1(xvals(3)+1:xvals(4)),'k--','LineWidth',1.5);
t1 = plot(x1(xvals(4)+1:end),y1(xvals(4)+1:end),'r','LineWidth',1.5);

xticks([-.006:.003:.02])
%% Plot each of the saddle nodes
scatter(pts(1,:),pts(2,:),'filled','k');
SN_Names = ['SN2';'SN1';'SN3';'SN4'];
dx = .00019;
text(pts(1,:)+dx,pts(2,:), SN_Names);

xlim([-.005 .02])
ylim([0 2.5])

xlabel('kYTup0')
ylabel('[YT_u_p]')

ry = [0 2.25 2.25 0 ];
xline(0)

range = pts(1,4)-pts(1,1);
kYTup0_1 = pts(1,1)+range/2;

legend([d1, h1, t1],'Degeneration', 'Homeostasis','Tumorigenesis','Location','best')
%% Save Figure
cd ..\FinalizedFigures
saveas(fig1, strcat("SN4-JN-Irreversibility_SI-Figure1",".png"));

cd SVG_files
saveas(fig1, strcat("SN4-JN-Irreversibility_SI-Figure1",".svg"));

cd ..\..\Figure5
%% Functions
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