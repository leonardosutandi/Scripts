%% Message

% This script only produces individual TF-plot for the selected options: 
% group, condition, and channel group. Each plot for each group of participant
% (C/MA/MO) must be manually selected for each condition and channel group
% in "Selection" section. This is in part because the "Load Dataset" section
% function is constructed in a way that it opens a selected group file 
% individually and not all 3 group files. Use script #6 to extract ersp 
% data to be statistically computed.

%% B) Group

% allC =  {'participant_1', 'participant_4','participant_5', 'participant_6', 'participant_8', ...
%          'participant_12', 'participant_13', 'participant_14', 'participant_15', 'participant_16'};
allC =  {'participant_8', 'participant_12', 'participant_13', 'participant_14'};
allMA = {'participant_7', 'participant_9', 'participant_11'};
% allMO = {'participant_2', 'participant_3', 'participant_10','participant_17'};
allMO = {'participant_10'};

tes = {'participant_14'};
wrongC = {'participant_4'};

%% C) Conditions

condList = {'NG_Left', ... % 1
             'NG_Right', ... % 2
             'NG_Neutral', ... % 3
             'G_Left', ... % 4
             'G_Right', ... % 5
             'G_Neutral'}; % 6

%% D) Channel Group

allChans = {'Fp1','AF7','AF3','F1','F3','F5','F7','FT7','FC5','FC3','FC1','C1','C3','C5', ...
            'T7','TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9','PO7','PO3','O1', ...
            'Iz','Oz','POz','Pz','CPz','Fpz','Fp2','AF8','AF4','AFz','Fz','F2','F4','F6','F8','FT8', ...
            'FC6','FC4','FC2','FCz','Cz','C2','C4','C6','T8','TP8','CP6','CP4','CP2', ...
            'P2','P4','P6','P8','P10','PO8','PO4','O2'};

leftChans = {'TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9','PO7','PO3','O1'};
rightChans = {'TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10','PO8','PO4','O2'};

leftOcc = {'PO7','PO3','O1'};
rightOcc = {'PO8','PO4','O2'};

leftPar = {'TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9'};
rightPar = {'TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10'};

% 'Iz','Oz','POz','Pz','CPz'

xrightPar = {'P3','P5','P7','P9','PO7','PO3','P5','Iz','Oz'};

%% E) Title

titleList = {'Left Parietal', ...
             'Right Parietal', ...
             'Left Occipital', ...
             'Right Occipital'};

%% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Selection >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% Select which group, participant group, condition and channels to compute

% A) Choose: C / MA / MO
grp = 'C'; 
% B) Group
allGrp = allC;
% C) Conditions
condType = condList{3};
% D) Channel Group
chans = leftOcc;

%% Dependents

% for plot title
if isequal(chans, leftPar)
    title = titleList(1);
    titleSave = 'leftPar';
elseif isequal(chans, rightPar)
    title = titleList(2);
    titleSave = 'rightPar';
elseif isequal(chans, leftOcc)
    title = titleList(3);
    titleSave = 'leftOcc';
elseif isequal(chans, rightOcc)
    title = titleList(4);
    titleSave = 'rightOcc';
end


% % for ersp output (AMI) for each condition
% if isequal(condType, condList{1})
%     erspdataAMI = {'erspdataAMI_' condList{1}};
%     ersptimesAMI = {'ersptimesAMI_' condList{1}};
%     erspfreqsAMI = {'erspfreqsAMI_' condList{1}};
% elseif isequal(condType, condList{2})
%     erspdataAMI = {'erspdataAMI_' condList{2}};
%     ersptimesAMI = {'ersptimesAMI_' condList{2}};
%     erspfreqsAMI = {'erspfreqsAMI_' condList{2}};
% elseif isequal(condType, condList{3})
%     erspdataAMI = {'erspdataAMI_' condList{3}};
%     ersptimesAMI = {'ersptimesAMI_' condList{3}};
%     erspfreqsAMI = {'erspfreqsAMI_' condList{3}};
% elseif isequal(condType, condList{4})
%     erspdataAMI = {'erspdataAMI_' condList{4}};
%     ersptimesAMI = {'ersptimesAMI_' condList{4}};
%     erspfreqsAMI = {'erspfreqsAMI_' condList{4}};
% elseif isequal(condType, condList{5})
%     erspdataAMI = {'erspdataAMI_' condList{5}};
%     ersptimesAMI = {'ersptimesAMI_' condList{5}};
%     erspfreqsAMI = {'erspfreqsAMI_' condList{5}};
% elseif isequal(condType, condList{6})
%     erspdataAMI = {'erspdataAMI_' condList{6}};
%     ersptimesAMI = {'ersptimesAMI_' condList{6}};
%     erspfreqsAMI = {'erspfreqsAMI_' condList{6}};
% end

%% Load Dataset

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for i = 1:length(allGrp)
    [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', condType ,'commands',{ ...
        {'index',i,'load',['C:\\MATLAB\\exp_1\\results\\EEG\\' grp '\\' allGrp{i} '\\' condType '_' allGrp{i} '.set']}, ...
        {'index',i,'subject',allGrp{i}, 'group', grp}}, ...
        'updatedat','on','rmclust','on' );
end

%% Pre-Compute
% [STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on','interp','on','spec','on','specparams',{'specmode','fft','logtrials','off'},'ersp','on','erspparams',{'cycles',[3 0.8] ,'nfreqs',100,'ntimesout',200},'itc','on');
[STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on', ...
                                                'rmicacomps','on', ...
                                                'interp','on', ...
                                                'recompute','on', ...
                                                'erp','on','erpparams',{'rmbase',[-1000 -200] }, ...
                                                'spec','on', 'specparams',{'specmode','fft','logtrials','off'}, ...
                                                'ersp','on','erspparams',{'cycles',[3 0.8] , ...
                                                                          'baseline',[-1000 -200], ...
                                                                          'basenorm', 'off', ...
                                                                          'plotphase', 'off', ...
                                                                          'padratio', 2, ...
                                                                          'freqscale', 'linear' ...
                                                                          'winsize', 512}, ...
                                                'itc','on');
% 
% % , ...
% %                                                                           'alpha',0.05, ...
% %                                                                           'mcorrect', 'fdr'
% 
% % nfreqs 100, ntimesout 200
%                                                                           % 'basenorm', 'on', ...
%                                                                           % 'nfreqs', 100, ...
%                                                                           % 'ntimesout', 200, ...
% save precompute
% [STUDY EEG] = pop_savestudy( STUDY, EEG, 'filename',[condType '_' titleSave '.study'], ...
%                                          'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' grp 'STUDY\\'], ...
%                                          'resavedatasets','on');

%% Load

% [STUDY ALLEEG] = pop_loadstudy('filename', 'x.study', ...
%                                'filepath', 'C:\MATLAB\exp_1\results\EEG');

%% TF-Plot (Output Only)
% Set parameter
STUDY = pop_erspparams(STUDY, 'freqrange',[2 40], 'ersplim', [-5.4 5.4], 'subbaseline', 'on', 'averagemode', 'ave', 'averagechan','on');
% [STUDY erspdata ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
%                                                                         'channels',chans, ...
%                                                                         'plotsubjects', 'on', ...
%                                                                         'design', 1);

% Selection-dependent function (TF-plot - output only)
if isequal(condType, condList{1})
    [STUDY erspdata_NG_Left ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                            'channels',chans, ...
                                                                            'plotsubjects', 'on', ...
                                                                            'noplot', 'on', ...
                                                                            'design', 1);
elseif isequal(condType, condList{2})
    [STUDY erspdata_NG_Right ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                            'channels',chans, ...
                                                                            'plotsubjects', 'on', ...
                                                                            'noplot', 'on', ...
                                                                            'design', 1);
elseif isequal(condType, condList{3})
    [STUDY erspdata_NG_Neutral ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                            'channels',chans, ...
                                                                            'plotsubjects', 'on', ...
                                                                            'noplot', 'on', ...
                                                                            'design', 1);
elseif isequal(condType, condList{4})
    [STUDY erspdata_G_Left ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                            'channels',chans, ...
                                                                            'plotsubjects', 'on', ...
                                                                            'noplot', 'on', ...
                                                                            'design', 1);
elseif isequal(condType, condList{5})
    [STUDY erspdata_G_Right ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                            'channels',chans, ...
                                                                            'plotsubjects', 'on', ...
                                                                            'noplot', 'on', ...
                                                                            'design', 1);
elseif isequal(condType, condList{6})
    [STUDY erspdata_G_Neutral ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                            'channels',chans, ...
                                                                            'plotsubjects', 'on', ...
                                                                            'noplot', 'on', ...
                                                                            'design', 1);
end

% see pop_specparams for additional parameters
% imagesc(erspdata{1,1})

% Use this to regenerate plot (e.g. AMI):
% std_plottf( ersptimes, erspfreqs, erspdata, 'titles', title,'caxis', [-5.4 5.4])

%% Plot spatial against neutral

% Spatial against Neutral (SaN) formula
erspdataSaN = {(erspdata_NG_Left{1,1} - erspdata_NG_Neutral{1,1})};

% Replot
std_plottf(ersptimes, erspfreqs, erspdataSaN, 'titles', title,'caxis', [-5.4 5.4]);

%% topoplot
% 
% % Set parameters for AMI topoplot
% STUDY = pop_erspparams(STUDY, 'averagemode','ave','topotime',[0 800] ,'topofreq',[0 40] );
% 
% % % Generate output for AMI replotting
% % [STUDY erspdataAMI ersptimesAMI erspfreqsAMI pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG,...
% %                                                                                  'channels',allChans, ...
% %                                                                                  'design', 1, ...
% %                                                                                  'noplot', 'on');
% 
% % Selection-dependent function (AMI - output only)
% if isequal(condType, condList{1})
%     [STUDY erspdataAMI_NG_Left ersptimesAMI erspfreqsAMI pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG,...
%                                                                                  'channels',allChans, ...
%                                                                                  'design', 1, ...
%                                                                                  'noplot', 'on');
% elseif isequal(condType, condList{2})
%     [STUDY erspdataAMI_NG_Right ersptimesAMI erspfreqsAMI pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG,...
%                                                                              'channels',allChans, ...
%                                                                              'design', 1, ...
%                                                                              'noplot', 'on');
% elseif isequal(condType, condList{3})    
%     [STUDY erspdataAMI_NG_Neutral ersptimesAMI erspfreqsAMI pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG,...
%                                                                              'channels',allChans, ...
%                                                                              'design', 1, ...
%                                                                              'noplot', 'on');
% elseif isequal(condType, condList{4})
%     [STUDY erspdataAMI_G_Left ersptimesAMI erspfreqsAMI pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG,...
%                                                                              'channels',allChans, ...
%                                                                              'design', 1, ...
%                                                                              'noplot', 'on');
% elseif isequal(condType, condList{5})
%     [STUDY erspdataAMI_G_Right ersptimesAMI erspfreqsAMI pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG,...
%                                                                              'channels',allChans, ...
%                                                                              'design', 1, ...
%                                                                              'noplot', 'on');
% elseif isequal(condType, condList{6})    
%     [STUDY erspdataAMI_G_Neutral ersptimesAMI erspfreqsAMI pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG,...
%                                                                              'channels',allChans, ...
%                                                                              'design', 1, ...
%                                                                              'noplot', 'on');
% end

%% PLot AMI

% % AMI formula (NG)
% a = {(erspdataAMI_NG_Left{1,1} - erspdataAMI_NG_Right{1,1})};
% b = {(erspdataAMI_NG_Left{1,1} + erspdataAMI_NG_Right{1,1})};
% erspdataAMI2 = {a{1,:} ./ b{1,:}};
% erspdataAMI2 = {(erspdataAMI_NG_Left{1,1} - erspdataAMI_NG_Right{1,1}) ./ (erspdataAMI_NG_Left{1,1} + erspdataAMI_NG_Right{1,1})};
% ersptimesAMI2 = (ersptimesAMI_NG_Left - ersptimesAMI_NG_Right)/(ersptimesAMI_NG_Left + ersptimesAMI_NG_Right);
% erspfreqsAMI2 = (erspfreqsAMI_NG_Left - erspfreqsAMI_NG_Right)/(erspfreqsAMI_NG_Left + erspfreqsAMI_NG_Right);
% Replot AMI
% std_plottf(ersptimesAMI, erspfreqsAMI, erspdataAMI_NG_Right, 'titles', {'Attentional Modulation Index'});
%
% % AMI formula (G)
% erspdataAMI2 = [(erspdataAMI_G_Left - erspdataAMI_G_Right)/(erspdataAMI_G_Left + erspdataAMI_G_Right)];
% ersptimesAMI2 = [(ersptimesAMI_G_Left - ersptimesAMI_G_Right)/(ersptimesAMI_NG_Left + ersptimesAMI_G_Right)];
% erspfreqsAMI2 = [(erspfreqsAMI_G_Left - erspfreqsAMI_G_Right)/(erspfreqsAMI_NG_Left + erspfreqsAMI_G_Right)];
% % Replot AMI
% std_plottf(ersptimesAMI2, erspfreqsAMI2, erspdataAMI2, 'titles', 'Attentional Modulation Index');

%%
eeglab redraw;




















































