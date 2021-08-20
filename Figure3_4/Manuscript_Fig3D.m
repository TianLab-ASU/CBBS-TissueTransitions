% This script generates Figures 3E in the manuscript. This
% script requires the coordinates of the saddle nodes, thus the script for
% Fig 2A was run. In addition, this script requires the 2-parameter
% bifurcation data for saddle nodes(SNs) 2 and 4 exported from Oscill8. The
% 2-parameter bifurcation diagram plotted has the 2nd bifurcation parameter
% as kYTup3.
%% Code for 2-parameter bifurcation analyses of SN2 and SN4
% Run following script to get coordinates of saddle nodes in Fig 2A
run ..\Figure2\Manuscript_Fig2
clc;clearvars -except pts;close all;
pts1 = [pts(1,1),1;pts(1,4),1];

% Load parameter values
Para2  

% Load indices of 2p bifurcation diagram to plot certain sections
% SN was originally SN2 but later changed to SN1
index_2p = readtable('index_2p_SN14.xlsx'); 
% Convert table to array
ix2p = table2array(index_2p(:,1:4));
%% Read data obtained from 2-p bifurcation on SN2
% SN was originally SN1 but later changed to SN2
% folder is thus named after SN1 rather than SN2

mainpar= "kYTup0";
cd rawdata_2p_SN1
SN2_data = dir('*.txt');
[q,idx]=sort([SN2_data.datenum]);
SN2_data =  SN2_data(idx);

SN2 = readcontents(SN2_data);
cd ..
%% Read data obtained from 2-p bifurcation on SN4
cd rawdata_2p_SN4
SN4_data = dir('.\rawdata_2p_SN4');
SN4_data = dir('*.txt');

[q,idx]=sort([SN4_data.datenum]);
SN4_data =  SN4_data(idx);
SN4 = readcontents(SN4_data);
cd ..

%% Plot SN2 and SN4 2-parameter bifurcation diagrams

index =9; % Specify parameter kYTup3 used for 2-parameter bifurcation

A =SN2{1,1};
B =SN4{1,1};
parameter = Para0(index);
    
% Plot 2-parameter bifurcation diagram with normalized x-axis
w = figure(1);    
plot(A(ix2p(1,1):ix2p(1,2),5)/parameter,A(ix2p(1,1):ix2p(1,2),4),'Linewidth',1.5); hold on;
plot(B(ix2p(1,3):ix2p(1,4),5)/parameter,B(ix2p(1,3):ix2p(1,4),4),'Linewidth',1.5); hold off;

ylabel(mainpar)
xlabel(SN2{2,1})
legend('SN2', 'SN4')
 
xlim([.85 1.15])
ylim([0 .02])
%% Save Figures
cd ..\FinalizedFigures
saveas(w, strcat(mainpar,"vs", SN2{2,1},"_Fig3D",".png")); %y vs x.png

cd SVG_files
saveas(w, strcat(mainpar,"vs", SN2{2,1},"_Fig3D",".svg")); %y vs x.png
cd ..\..\Figure3_4
%% Functions
% Read contents of folder(data and file name)
function C = readcontents(folder)
    e = struct2cell(folder)';
    k = 1;

    array = importdata(e{k,1}); 
    C{1,k} = array;
    %Use filename to get parameter used for 2-parameter bifurcation 
    C{2,k} = convertCharsToStrings(e{k,1}); 
    C{2,k} = erase(C{2,k},'.txt');


end