% This code generates the 1-parameter bifurcation diagram as
% observed in Fig 2A in the manuscript. 

% The script requires the 1-parameter bifurcation data exported from 
% Oscill8 and where kYTup0 was the bifurcation parameter. This data 
% has been placed in the folder "NFL_bifurcationdata". 

%% Import data for bifurcation diagram
clear;clc;close all
cd NFL_bifurcationdata
orig = importdata('bifanalysis_1.txt');
%% Get x and y coordinates to plot bifurcation diagram
cd ..
pts =findchange(orig);  %% Find saddle nodes
% Get x and y data to plot bifurcation diagram
x1 = orig(:,4); % 
y1 = orig(:,5);

%% Plot bifurcation diagram
[n, m] = size(pts); 
% Find points where each branch begins and ends
for j = 1:m
    xvals(j) = find(x1 == pts(1,j));
end

fig1 = figure();
d1 = plot(x1(1:xvals(1)),y1(1:xvals(1)),'b','LineWidth',1.5);hold on;
plot(x1(xvals(1)+1:xvals(2)),y1(xvals(1)+1:xvals(2)),'k--','LineWidth',1.5);
h1 = plot(x1(xvals(2)+1:xvals(3)),y1(xvals(2)+1:xvals(3)),'g','LineWidth',1.5);
plot(x1(xvals(3)+1:xvals(4)),y1(xvals(3)+1:xvals(4)),'k--','LineWidth',1.5);
t1 = plot(x1(xvals(4)+1:end),y1(xvals(4)+1:end),'r','LineWidth',1.5);

%% Plot each of the saddle nodes
scatter(pts(1,:),pts(2,:),'filled','k');
SN_Names = ['SN2';'SN1';'SN3';'SN4'];
dx = .00019;
text(pts(1,:)+dx,pts(2,:), SN_Names);

xlim([0 .02])
ylim([0 2.25])

xlabel('kYTup0')
ylabel('[YT_u_p]')

%% Color monostable and bistable ranges of kYTup0 with different colors
ry = [0 2.25 2.25 0 ];
range = pts(1,4)-pts(1,1);
kYTup0_1 = pts(1,1)+range/2;

% Set ranges for each monostable and bistable region
rx1 = [0,0, pts(1,2),pts(1,2)];
rx2 = [pts(1,2), pts(1,2), pts(1,1), pts(1,1)];
rx3 = [pts(1,1), pts(1,1), pts(1,4), pts(1,4)];
rx4 = [pts(1,4), pts(1,4), pts(1,3),pts(1,3)];
rx5 = [pts(1,3),pts(1,3),.02, .02];

% Color each range
f1 = fill(rx1, ry, 'b',rx2, ry, 'c',rx3, ry, 'g');
alpha(f1,.3);
f2 = fill(rx4, ry, 'yellow',rx5, ry, 'r');
alpha(f2, .3);

legend([d1, h1, t1],'Degeneration', 'Homeostasis','Tumorigenesis','Location','best')
title('Figure 2A')
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