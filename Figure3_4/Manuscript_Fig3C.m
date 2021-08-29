% This script is used to generate Fig 3C in the manuscript. The script 
% plots the 1-bifurcation diagrams for several values of kYTup3 to 
% determine its effect on the system and each of the tissue states. These
% bifurcation diagrams use kYTup0 as the bifurcation parameter.

% The script requires the 1-parameter bifurcation data exported from 
% Oscill8, where kYTup0 was the bifurcation parameter. 

%% Change directory to get bifurcation data
cd ..\Figure2\NFL_bifurcationdata
clear;clc;
%% Plot bifurcation diagram for varied values of kYTup3
kYTup3 = (.85:.05:1.15);
for i = 1:length(kYTup3)
    % Get name of file for specific value of kYTup3
    file = 'bifanalysis_'+string(kYTup3(i))+'.txt';
    % Import data into variable
    orig = importdata(file);
    % Get coordinates of saddle points
    pts =findchange(orig);
    % Get x and y data for bifurcation diagram
    x1 = orig(:,4); 
    y1 = orig(:,5);
    
    % Get endpoints to plot specific branches of bifurcation diagram
    [n, m] = size(pts);
    for j = 1:m
        xval = find(x1 == pts(1,j));
        xvals(j) = xval(1);
    end
    
    % Plot branches of bifurcation diagrams
    fig1 = figure(1);
    d1 = plot(x1(1:xvals(1)),y1(1:xvals(1)),'b','LineWidth',1.5);hold on;
    plot(x1(xvals(1)+1:xvals(2)),y1(xvals(1)+1:xvals(2)),'k--','LineWidth',1.5);
    h1 = plot(x1(xvals(2)+1:xvals(3)),y1(xvals(2)+1:xvals(3)),'g','LineWidth',1.5);
    plot(x1(xvals(3)+1:xvals(4)),y1(xvals(3)+1:xvals(4)),'k--','LineWidth',1.5);
    t1 = plot(x1(xvals(4)+1:end),y1(xvals(4)+1:end),'r','LineWidth',1.5);

    % Plot saddle nodes
    scatter(pts(1,:),pts(2,:),12,'filled','k');

    xlim([0 .02])
    ylim([0 2.25])

    xlabel('kYTup0')
    ylabel('[YT_u_p]')

    legend([d1, h1, t1],'Degeneration', 'Homeostasis','Tumorigenesis')
    legend('Location','best')
end
title('Figure 3C')
cd ../../Figure3_4

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