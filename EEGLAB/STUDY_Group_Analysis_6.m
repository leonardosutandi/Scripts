%% B) Group

% allC =  {'participant_1', 'participant_4','participant_5', 'participant_6', 'participant_8', ...
%          'participant_12', 'participant_13', 'participant_14', 'participant_15', 'participant_16'};
% allMA = {'participant_7', 'participant_9', 'participant_11'};
% allMO = {'participant_2', 'participant_3', 'participant_10','participant_17'};


allC =  {'participant_14', 'participant_15'};
% allMA = {'participant_9', 'participant_11'};
% allMO = {'participant_10','participant_17'};

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
% leftOccWrong = {'P2','P4','P6'};
rightOcc = {'PO8','PO4','O2'};
% rightOccWrong = {'POz','Pz','CPz'};

leftPar = {'TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9'};
% leftParWrong = {'Cz','C2','c4','C6','T8','TP8','CP6','CP4','CP2'};
rightPar = {'TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10'};
% rightParWrong = {'P3','P5','P7','P9','PO7','PO3','O1','Iz','Oz'};

% 'Iz','Oz','POz','Pz','CPz'


%% E) Title

titleList = {'Left Parietal', ...
             'Right Parietal', ...
             'Left Occipital', ...
             'Right Occipital'};

%% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Selection >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% Select which group, participant group, condition and channels to compute.
% No need for A) and B) for this script.

% % A) Choose: C / MA / MO
% grp = 'C'; 
% % B) Group
% allGrp = wrongC;
% C) Conditions
condType = condList{1};
% D) Channel Group
chans = rightOcc;

% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

%% Load Dataset

% This chunk saves all participants from every group in 1 STUDY (but ONLY 1 condition and 1 channel group)

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for i = 1:length(allC)
    [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', condType ,'commands',{ ...
        {'index',i,'load',['C:\\MATLAB\\exp_1\\results\\EEG\\C\\' allC{i} '\\' condType '_' allC{i} '.set']}, ...
        {'index',i,'subject',allC{i}, 'group', 'C'}}, ...
        'updatedat','on','rmclust','on' );
end

% for j = 1:length(allMA)
%     [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', condType ,'commands',{ ...
%         {'index',[j + length(allC)],'load',['C:\\MATLAB\\exp_1\\results\\EEG\\MA\\' allMA{j} '\\' condType '_' allMA{j} '.set']}, ...
%         {'index',[j + length(allC)],'subject',allMA{j}, 'group', 'MA'}}, ...
%         'updatedat','on','rmclust','on' );
% end
% 
% for k = 1:length(allMO)
%     [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', condType ,'commands',{ ...
%         {'index',[k + length(allC) + length(allMA)],'load',['C:\\MATLAB\\exp_1\\results\\EEG\\MO\\' allMO{k} '\\' condType '_' allMO{k} '.set']}, ...
%         {'index',[k + length(allC) + length(allMA)],'subject',allMO{k}, 'group', 'MO'}}, ...
%         'updatedat','on','rmclust','on' );
% end

%% Export for R

% Pre-Compute
[STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on', ...
                                                'rmicacomps','on', ...
                                                'interp','on', ...
                                                'recompute','on', ...
                                                'erp','on','erpparams',{'rmbase',[-1000 -200] }, ...
                                                'spec','on', 'specparams',{'specmode','fft','logtrials','off'}, ...
                                                'ersp','on','erspparams',{'freqs', [8 13], ... % new
                                                                          'rmerp', 'on', ...
                                                                          'cycles',[3 0.8] , ...
                                                                          'baseline',[-1000 -200], ...
                                                                          'basenorm', 'off', ...
                                                                          'plotphase', 'off', ...
                                                                          'padratio', 2, ...
                                                                          'freqscale', 'linear' ...
                                                                          'winsize', 512, ...
                                                                          'nfreqs', 100, ... %faster computation
                                                                          'ntimesout', 200}, ... %faster computation
                                                'itc','on');

%% Set parameter
STUDY = pop_erspparams(STUDY, 'freqrange',[8 13], ...
                              'ersplim', [-5.4 5.4], ...
                              'subbaseline', 'on', ...
                              'averagemode', 'ave', ...
                              'averagechan','on');


% % generate ERSP outputs
% for i = 1:length:(condList)
%     [STUDY erspdata ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
%                                                                             'channels',chans, ...
%                                                                             'plotsubjects', 'on', ...
%                                                                             'design', 1, ...
%                                                                             'noplot', 'on');
% end

% % Selection-dependent function (TF-plot - output only)
% if isequal(condType, condList{1})
%     [STUDY erspdata_NG_Left ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
%                                                                             'channels',chans, ...
%                                                                             'plotsubjects', 'on', ...
%                                                                             'noplot', 'off', ...
%                                                                             'design', 1);
%     M = squeeze([erspdata_NG_Left{1,1}]);
% 
% elseif isequal(condType, condList{2})
%     [STUDY erspdata_NG_Right ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
%                                                                             'channels',chans, ...
%                                                                             'plotsubjects', 'on', ...
%                                                                             'noplot', 'on', ...
%                                                                             'design', 1);
%     M = squeeze([erspdata_NG_Right]);
% 
% elseif isequal(condType, condList{3})
%     [STUDY erspdata_NG_Neutral ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
%                                                                             'channels',chans, ...
%                                                                             'plotsubjects', 'on', ...
%                                                                             'noplot', 'on', ...
%                                                                             'design', 1);
%     M = squeeze([erspdata_NG_Neutral]);
% 
% elseif isequal(condType, condList{4})
%     [STUDY erspdata_G_Left ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
%                                                                             'channels',chans, ...
%                                                                             'plotsubjects', 'on', ...
%                                                                             'noplot', 'on', ...
%                                                                             'design', 1);
%     M = squeeze([erspdata_G_Left]);
% 
% elseif isequal(condType, condList{5})
%     [STUDY erspdata_G_Right ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
%                                                                             'channels',chans, ...
%                                                                             'plotsubjects', 'on', ...
%                                                                             'noplot', 'on', ...
%                                                                             'design', 1);
%     M = squeeze([erspdata_G_Right]);
% 
% elseif isequal(condType, condList{6})
%     [STUDY erspdata_G_Neutral ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
%                                                                             'channels',chans, ...
%                                                                             'plotsubjects', 'on', ...
%                                                                             'noplot', 'on', ...
%                                                                             'design', 1);
%     M = squeeze([erspdata_G_Neutral]);
% end
% 
% %% Write csv
% filename = 'C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\twoPerGroupx.csv';
% writecell(M, filename)


pop_savestudy(STUDY, EEG, 'filename', 'twoPerGroup', ...
                          'filepath', 'C:\\MATLAB\\exp_1\\results\\EEG\\');











































