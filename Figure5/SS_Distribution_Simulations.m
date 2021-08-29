% This file can be ran several times in order to include different types of
% noise
% Certain sections or lines were commented out. These can be used to get
% stochastic simulations when time values don't need to be saved

% This script requires the coordinates of the saddle nodes in Fig 2A, which
% is why the script is ran in the first section. The coordinates are then
% used to calculate the value of kYTup0 used as the initial condition for
% the simulations. 
%% Get position of saddle nodes
clc; close all;
global oval
global tim

run ..\Figure2\Manuscript_Fig2A  % Run this file to obtain variable with position of saddle nodes
clearvars -except pts
close all

% Get parameter values
Para2
options = odeset('RelTol',1e-4);

%% Define variables when running file to plot SI-Figure 2
kYTup0_vals = [0.004, .005, .007, 0.012, 0.014];
Conc = {};

%% Define variables when running file to get data for all kYTup0 values
% Use for stochastic simulations where time values don't need saving.
% Section above should be commented out if this section is uncommented.
% Conc(1,:) = {"L","YTup","YTp","S","N"}; 
% kYTup0_vals = [0:0.001:0.015];

%% Get initial conditions for stochastic simulations
kYTup0 =(pts(1,4)-pts(1,1))/2+pts(1,1);
init = [0 0 0 0 0];
sol=ode15s(@(t,y) Hippo_ODE(t,y,kYTup0),[0 1000],init,options);
y0=sol.y(:,end)';

%% 
for j = 1:length(kYTup0_vals)
    kYTup0 = kYTup0_vals(j);
    
    oval = 100;
    tim = 2500;
    
    % Define timeframe and number of timesteps
    tspan=[0 30*24];
    TimeNum =tim;
    time1 = linspace(tspan(1),tspan(2),TimeNum);
    
    cellnum=1000;
   
    
    % Use following line when needing to save time values from stochastic simulations 
    vals = {}; 

    global Omega
    Omega=oval;
    
%   simulations with extrinsic noise
%     NoiseAmpli=0.15;
%     NoisePara=lhsdesign(cellnum,paranum);

    ssimtimestart = tic;
    for i=1:cellnum
        
        j; i;
        tic
        %Uncomment following 13 lines to include extrinsic noise through parameter variation
%         Para1=Para0.*(1-NoiseAmpli+2*NoiseAmpli*NoisePara(i,:));
%         
%         kL1=Para1(1); kL2=Para1(2); JL=Para1(3); kL3=Para1(4);
%         
%         kYTup1=Para1(5); JYTup1=Para1(6); kYTup2=Para1(7); JYTup2=Para1(8);
%         
%         kYTup3=Para1(9);  JYTup3=Para1(10);  kYTup4=Para1(11);
%         
%         JYTup4=Para1(12);  kYTup5=Para1(13);  kYTp1=Para1(14);  kS1=Para1(15);   kS2=Para1(16);
%         
%         JS=Para1(17);   kS3=Para1(18);   kN1=Para1(19);    kN2=Para1(20);
%         
%         JN=Para1(21);  kN3=Para1(22);
        
         [ttau,ytau] = TauLeapWendy_Hippo(@(t,y) Hippo_SDE(t,y,kYTup0),tspan,ceil(y0*Omega), .01, []);
        
        toc 
        
         % Use next line when needing to save time values, otherwise
         % comment it out. 
          vals(i,:) = {ytau, ttau}; 

    end
    sstotaltime =toc(ssimtimestart);
%         Use next line when time values don't need to be saved
%         Conc(j,:) = {L, YTup, YTp, S, N}; 
    % Use next line when time values need to be saved. Otherwise, comment
    % it out. 
    Conc{j, 1}=vals; 
    

end
%% Save data
% Use next line when time values are being saved
save('SI_fulldata_Fig2.mat', 'Conc')
% Use next line when time values are not being saved
% save('intr_100_2500_1000cells_r_allcorrect.mat', 'Conc')