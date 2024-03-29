% This script generates Figs 4A-B as seen in the manuscript. The figures
% plot the fold change in the saddle nodes after varying the parameters by 
% a 15% increase or decrease of their original values in the standard 
% parameter set. 

% The script requires the coordinates of the saddle nodes as seen in Fig
% 2A, thus the file to generate that figure is run first. It also requires
% the 1-parameter bifurcation data exported from Oscill8. This data is obtained by
% varying each of the parameters through a 15% increase and decrease of
% their original values in the standard parameter set. 
%% Get coordinates of saddle nodes as in Fig 2A
clear;clc
run ..\Figure2\Manuscript_Fig2A
close
%% Import data for each bifurcation diagram obtained from varying parameters
cd rawdata_1p_parsent
myfolder = dir('*.txt');

idx = [16, 15, 18, 17, 2, 1, 20, 19, 36, 35, ...
    8, 7, 38, 37, 10, 9, 40, 39, 12, 11, ...
    42, 41, 14, 13, 44, 43, 34, 33, 28, 27, ...
    30, 29, 6, 5, 32, 31, 22, 21, 24, 23, ...
    4, 3, 26, 25];

myfolder =  myfolder(idx);

%%
for k = 1:length(myfolder) % Iterates through each file in folder
    % Get file names
    e(k,1) = convertCharsToStrings(myfolder(k).name);
    % Import data according to file name
    C{k} = importdata(myfolder(k).name); 
     
    % Get coordinates of saddle nodes for bifurcation diagram
    % 1st row = x, 2nd row = y.
    D{k} = findchange(C{k}); 

end

%% Calculate fold change for saddle nodes
Q = zeros(length(C),length(pts));

%Outputs Q as matrix containing x-coordinate of SNs
for j = 1:length(C) 
  W = D{j};
  Q(j,1:length(W(1,:))) = W(1,:);
end

% Indexes used to separate saddle node x-coordinate according to parameter
% within each feedback loop
sepindex =[1,2,3,4,5,6,7,8,17,18,19,20,21,22,23,24,25,26,27,28,...
    29,30,31,32,33,34,35,36,9,10,11,12,37,38,39,40,41,42,43,44,13,14,15,16]; 
% Separate by indices defined above
Q = Q(sepindex,:);
% Calculate fold change by dividing by original x-coordinate of SNs
Q = Q./pts(1,:); 

% Separate Q matrix by whether parameter was decreased or increased
Qn = Q(1:2:end,:); % Contains fold changes of SNs caused by parameter decrease
Qp = Q(2:2:end,:); % Contains fold changes of SNs caused by parameter increase

%% Plot fold changes(SN3 vs SN2)
fig(2) = figure(2);
xline(1); hold on;
yline(1); hold on;
title('Figure 4A')
% Plot fold changes of SNs caused by parameter decrease
g1 = scatter(Qn(:,1),Qn(:,3),'o');hold on; 

% Plot fold changes of SNs caused by parameter increase
g2 = scatter(Qp(:,1),Qp(:,3),'^'); hold on;

% Plot fold change of SNs with no parameter increase or decrease
g3 = scatter(pts(1,1)/pts(1,1),pts(1,3)/pts(1,3),'d', 'filled');
legend([g1, g2, g3],'Parameter Decreasing','Parameter Increasing','Standard Parameter','Location', 'best')

ytickformat('%.001f');
xlabel('SN2'); 
ylabel('SN3');
box on;


%% Plot fold changes(SN4 vs SN1)
fig(3) = figure(3);
xline(1); hold on;
yline(1); hold on;
title('Figure 4B')
% Plot fold changes of SNs caused by parameter decrease
g4 = scatter(Qn(:,2),Qn(:,4),'o');hold on;

% Plot fold changes of SNs caused by parameter increase
g5 = scatter(Qp(:,2),Qp(:,4),'^');hold on;

% Plot fold change of SNs with no parameter increase or decrease
g6 = scatter(pts(1,2)/pts(1,2),pts(1,4)/pts(1,4),'d', 'filled');
legend([g4, g5, g6],'Parameter Decreasing','Parameter Increasing','Standard Parameter','Location', 'best')

xlabel('SN1'); 
ylabel('SN4');
box on;

cd ..
 
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