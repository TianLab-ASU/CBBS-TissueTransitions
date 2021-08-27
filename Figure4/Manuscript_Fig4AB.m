
%% Get coordinates of saddle nodes as in Fig 2A
clear;clc
run ..\Figure2\Manuscript_Fig2A
close
%% Import data for each bifurcation diagram obtained from varying parameters
cd rawdata_1p_parsent
myfolder = dir('*.txt');

[q,idx]=sort([myfolder.datenum]);
myfolder =  myfolder(idx);

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

%Outputs Q as matrix containing x-value of SNs
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