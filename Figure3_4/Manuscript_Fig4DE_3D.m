% This script generates Figures 4D, 4E, and 3D in the manuscript. This
% script requires the coordinates of the saddle nodes, thus the script for
% Fig 2A was run. In addition, this script requires the 2-parameter
% bifurcation data for saddle nodes(SNs) 1 and 3 exported from Oscill8. This
% script also generates 2-parameter bifurcation diagrams for SNs1 and 2 for
% every parameter chosen as 2nd bifurcation parameter
%% Code for 2-parameter bifurcation analyses of SN2 and SN4
% Run following script to get coordinates of saddle nodes in Fig 2A
clear;clc
run ..\Figure2\Manuscript_Fig2
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
% folder is thus named after SN2 rather than SN1

mainpar= "kYTup0";
cd rawdata_2p_SN2
SN1_data = dir('*.txt');

[q,idx]=sort([SN1_data.datenum]);
SN1_data =  SN1_data(idx);
SN1 = readcontents(SN1_data);
cd ..
%% Read data obtained from 2-p bifurcation on SN3
cd rawdata_2p_SN3
SN3_data = dir('*.txt');

[q,idx]=sort([SN3_data.datenum]);
SN3_data =  SN3_data(idx);
SN3 = readcontents(SN3_data);
cd ..
%%
cd ..\FinalizedFigures\2p_bifurcation
filetype = ".png";

% Specify parameters used for 2-parameter bifurcation
index = [5,6,7,8,16,17,20,21,9,10]; 

for i = 1:length(SN1)
    A =SN1{1,i};
    B =SN3{1,i};
    parameter = Para0(index(i));
    
    % Plot 2-parameter bifurcation diagram with normalized x-axis
    w(i) = figure(i);
    plot(A(ix2p(i,1):ix2p(i,2),5)/parameter,A(ix2p(i,1):ix2p(i,2),4),'Linewidth',1.5); hold on;
    plot(B(ix2p(i,3):ix2p(i,4),5)/parameter,B(ix2p(i,3):ix2p(i,4),4),'Linewidth',1.5); hold off;
    ylabel(mainpar)
    xlabel(SN1{2,i})
    legend('SN2', 'SN3')
 
    xlim([.85 1.15])
    ylim([0 .02])
    
    % Uncomment following line to save each figure
%     saveas(w(i), strcat(mainpar,"vs", SN1{2,i},filetype)); %y vs x.png
end
%% Save Figures
% Uncomment following lines in code to save specific figures
% cd ..
% saveas(w(5), strcat("kYTup0vskS2_Fig4D",".png"));
% saveas(w(7), strcat("kYTup0vskN2_Fig4E",".png"));
% 
% saveas(w(9), strcat("kYTup0vskYTup3_Fig3D",".png"));
% 
% cd SVG_files
% saveas(w(5), strcat("kYTup0vskS2_Fig4D",".svg"));
% saveas(w(7), strcat("kYTup0vskN2_Fig4E",".svg"));
% 
% saveas(w(9), strcat("kYTup0vskYTup3_Fig3D",".svg"));
% 
% cd ..\Figure3_4

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