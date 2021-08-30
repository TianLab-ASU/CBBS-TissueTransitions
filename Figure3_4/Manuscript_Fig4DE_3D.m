% This script generates Figures 4D, 4E, and 3D in the manuscript. The
% 2-parameter bifurcation diagram for SN2 and SN4 plotted in Fig 3D has 
% kYTup0 as the 1st bifurcation parameter and kYTup3 as the 2nd bifurcation
% parameter. Figs 4D and 4E have kS2 and kN2 as their 2nd bifurcation
% parameter, respectively, and both have kYTup0 as their first bifurcation
% parameter. 

% This script requires the coordinates of the saddle nodes, thus the script for
% Fig 2A was run. It requires the 2-parameter bifurcation data for saddle 
% nodes(SNs) 1 and 3 exported from Oscill8. The Excel tables imported
% contains the indices used to plot specific sections of the 2-parameter
% bifurcation diagrams.
%% Code for 2-parameter bifurcation analyses of SN1 and SN3
% Run following script to get coordinates of saddle nodes in Fig 2A
clear;clc
run ..\Figure2\Manuscript_Fig2A
clc;clearvars -except pts;close all;
pts1 = [pts(1,2),1;pts(1,3),1];

% Load parameter values
Para2
% Load indices of 2p bifurcation diagram to plot certain sections 
index_2p = readtable('index_2p_SN23.xlsx','Sheet', 'Indices');
% Convert table to array
ix2p = table2array(index_2p(:,1:4));
%% Read data obtained from 2-p bifurcation on SN1
% SN was originally SN2 but later changed to SN1
% Folder is thus named after SN2 rather than SN1

mainpar= "kYTup0";
cd rawdata_2p_SN2
SN1_data = dir('*.txt');

idx =[8, 3, 9, 4, 7, 2, 6, 1, 10, 5];
% [q,idx]=sort([SN1_data.datenum]);
SN1_data =  SN1_data(idx);

SN1 = readcontents(SN1_data);
cd ..
%% Read data obtained from 2-p bifurcation on SN3
cd rawdata_2p_SN3
SN3_data = dir('*.txt');

idx =[8, 3, 9, 4, 7, 2, 6, 1, 10, 5];
% [q,idx]=sort([SN3_data.datenum]);
SN3_data =  SN3_data(idx);

SN3 = readcontents(SN3_data);
cd ..
%% Plot SN1 and SN3 2-parameter bifurcation diagrams

% Specify parameters used for 2-parameter bifurcation
index = [5,6,7,8,16,17,20,21,9,10]; 

for i = [5, 7, 9]
    A =SN1{1,i};
    B =SN3{1,i};
    parameter = Para0(index(i));
    
    % Plot 2-parameter bifurcation diagram with normalized x-axis
    w(i) = figure(i);
    plot(A(ix2p(i,1):ix2p(i,2),5)/parameter,A(ix2p(i,1):ix2p(i,2),4),'Linewidth',1.5); hold on;
    plot(B(ix2p(i,3):ix2p(i,4),5)/parameter,B(ix2p(i,3):ix2p(i,4),4),'Linewidth',1.5); hold off;
    ylabel(mainpar)
    xlabel(SN1{2,i})
    legend('SN1', 'SN3')
 
    xlim([.85 1.15])
    ylim([0 .02])

end
figure(5);title('Figure 4D');
figure(7);title('Figure 4E');
figure(9);title('Figure 3D');
%% Functions
% Read contents of folder(data and file name)
function C = readcontents(folder)
    e = struct2cell(folder)';
    for k = 1:length(e)
        array = importdata(e{k,1}); 
        C{1,k} = array;
        C{2,k} = convertCharsToStrings(e{k,1});
        C{2,k} = erase(C{2,k},'.txt');

    end

end