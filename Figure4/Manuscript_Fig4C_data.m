% This script produces the files required to run the R script, which
% generates Fig 4C. The files contain the percentage change in the
% saddle nodes after varying each of the parameters through a 15% increase 
% and decrease of their original values in the standard parameter set.

% This script requires the coordinates of the saddle nodes in Fig 2A, which 
% is why the file is used to generate it is run in this script. It also requires
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
    40, 29, 6, 5, 32, 31, 22, 21, 24, 23, ...
    4, 3, 26, 25];

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

%% Get data from each file in folder
Q = zeros(length(C),length(pts));

%Outputs Q as matrix containing x-value of SNs
for j = 1:length(C)
  W = D{j};
  Q(j,1:length(W(1,:))) = W(1,:);
end

% Indexes used to separate saddle node x-coordinate according to parameter
% within each feedback loop
sepindex =[1,2,3,4,5,6,7,8,17,18,19,20,21,22,23,24,25,26,27,28,...
    29,30,31,32,33,34,35,36,9,10,11,12,37,38,39,40,41,42,43,44,13,14,15,16]; %separate by FBL

% Separate by indices defined above
Q = Q(sepindex,:); %separate by FBL

%% Calculate percentage change for saddle nodes

% Calculate percentage change by dividing by original x-coordinate of SNs
Percentages = (Q-pts(1,:))./pts(1,:); % Multiply by 100 to get actual percentage

Pern = Percentages(1:2:end,:); % Get percentage changes of saddle nodes when parameter was decreased
Perp = Percentages(2:2:end,:); % Get percentage changes of saddle nodes when parameter was increased

%Create table for +15%
[SN1, SN2, SN3, SN4] = deal(Perp(:,1),Perp(:,2),Perp(:,3), Perp(:,4));
chgpos1 = table(SN1, SN2, SN3, SN4);

%Create table for -15%
[SN1, SN2, SN3, SN4] = deal(Pern(:,1),Pern(:,2),Pern(:,3),Pern(:,4));
chgneg1 = table(SN1, SN2, SN3, SN4);
%% Save data to plot using R 
cd ..
writetable(chgpos1,'chgpos1.txt','Delimiter',' ')  
writetable(chgneg1,'chgneg1.txt','Delimiter',' ')  


%% Functions
% Function below finds the saddle nodes of the bifurcation diagrams
function Coord = findchange(file)
pos = file(:,1);
x = file(:,4);
y = file(:,5);

A = diff(sign(diff(x)));
B = diff(sign(diff(pos)));

q1 = find(abs(A)==2);
q2 = find(abs(B)==2);
x1 = x(q2)';
y1 = y(q2)';
Coord = [x1; y1];

end