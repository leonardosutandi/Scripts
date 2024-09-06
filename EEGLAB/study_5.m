% EEGLAB history file generated on the 30-Aug-2024
% ------------------------------------------------
% [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% EEG = pop_loadset('filename','G_Left_participant_11.set','filepath','C:\\MATLAB\\exp_1\\results\\EEG\\MA\\participant_11\\');
% [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
% figure; pop_newtimef( EEG, 1, 61, [-1000  1498], [3         0.8] , 'topovec', 61, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'PO4', 'baseline',[-1000 -200], 'plotphase', 'off', 'padratio', 1, 'basenorm', 'on', 'winsize', 512);
% pop_saveh( ALLCOM, 'study_5.m', 'C:\MATLAB\exp_1\script\eeglab\');
% [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name','NG_Left_Cue','commands',{{'index',1,'load','C:\\MATLAB\\exp_1\\results\\EEG\\MA\\participant_11\\NG_Left_participant_11.set'},{'index',2,'load','C:\\MATLAB\\exp_1\\results\\EEG\\MA\\participant_9\\NG_Left_participant_9.set'},{'index',3,'load','C:\\MATLAB\\exp_1\\results\\EEG\\MO\\participant_10\\NG_Left_participant_10.set'},{'index',4,'load','C:\\MATLAB\\exp_1\\results\\EEG\\C\\participant_8\\NG_Left_participant_8.set'},{'index',5,'load','C:\\MATLAB\\exp_1\\results\\EEG\\C\\participant_12\\NG_Left_participant_12.set'},{'index',6,'load','C:\\MATLAB\\exp_1\\results\\EEG\\C\\participant_13\\NG_Left_participant_13.set'},{'index',1,'subject','p11'},{'index',2,'subject','p9'},{'index',3,'subject','p10'},{'index',4,'subject','p8'},{'index',5,'subject','p12'},{'index',6,'subject','p13'}},'updatedat','on','rmclust','on' );
% [STUDY ALLEEG] = std_checkset(STUDY, ALLEEG);
% CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
% [STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on','interp','on','spec','on','specparams',{'specmode','fft','logtrials','off'},'ersp','on','erspparams',{'cycles',[3 0.8] ,'nfreqs',100,'ntimesout',200},'itc','on');
% 
% STUDY = std_erspplot(STUDY,ALLEEG,'channels',{'TP7','CP5','CP1','P1','P3','P5','P7','P9','PO7','PO3','O1','Iz','Oz','POz','Pz','CPz','TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10','PO8','PO4','O2','CP3'}, 'plotsubjects', 'on', 'design', 1 );
% STUDY = pop_erspparams(STUDY, 'averagechan','on');
% STUDY = std_erspplot(STUDY,ALLEEG,'channels',{'TP7','CP5','CP1','P1','P3','P5','P7','P9','PO7','PO3','O1','Iz','Oz','POz','Pz','CPz','TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10','PO8','PO4','O2','CP3'}, 'plotsubjects', 'on', 'design', 1 );
% STUDY = pop_erspparams(STUDY, 'freqrange',[2 40] );
% [STUDY erspdata ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
%     'channels',{'TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9','PO7','PO3','O1', ...
%                 'Iz','Oz','POz','Pz','CPz', ...
%                 'TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10','PO8','PO4','O2'}, ...
%                 'plotsubjects', 'on', 'design', 1 );
% 
% STUDY = std_erspplot(STUDY,ALLEEG,'channels',{'Fp1'}, 'plotsubjects', 'on', 'design', 1 );
% STUDY = std_specplot(STUDY,ALLEEG,'channels',{'Fp1'}, 'plotsubjects', 'on', 'design', 1 );
% STUDY = pop_specparams(STUDY, 'freqrange',[2 40] ,'averagechan','on');
% STUDY = std_specplot(STUDY,ALLEEG,'channels',{'Fp1'}, 'plotsubjects', 'on', 'design', 1 );
% eeglab redraw;


%Load
% [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name','NG_Left_Cue','commands',{ ...
    % {'index',1,'load','C:\\MATLAB\\exp_1\\results\\EEG\\MA\\participant_11\\NG_Left_participant_11.set'}, ...
    % {'index',1,'subject','p11'}, ...
    % {'index',2,'load','C:\\MATLAB\\exp_1\\results\\EEG\\MA\\participant_9\\NG_Left_participant_9.set'}, ...
    % {'index',2,'subject','p9'}, ...
    % {'index',3,'load','C:\\MATLAB\\exp_1\\results\\EEG\\MO\\participant_10\\NG_Left_participant_10.set'}, ...
    % {'index',3,'subject','p10'}, ...
    % {'index',4,'load','C:\\MATLAB\\exp_1\\results\\EEG\\C\\participant_8\\NG_Left_participant_8.set'}, ...
    % {'index',4,'subject','p8'}, ...
    % {'index',5,'load','C:\\MATLAB\\exp_1\\results\\EEG\\C\\participant_12\\NG_Left_participant_12.set'}, ...
    % {'index',5,'subject','p12'}, ...
    % {'index',6,'load','C:\\MATLAB\\exp_1\\results\\EEG\\C\\participant_13\\NG_Left_participant_13.set'}, ...
    % {'index',6,'subject','p13'}}, ...
    % 'updatedat','on','rmclust','on' );

%% Channels
leftChans = {'TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9','PO7','PO3','O1'};
rightChans = {'TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10','PO8','PO4','O2'};

leftOcc = {'PO7','PO3','O1'};
rightOcc = {'PO8','PO4','O2'};

leftPar = {'TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9'};
rightPar = {'TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10'};

% 'Iz','Oz','POz','Pz','CPz'

%% Participants

allC =  {'participant_1', 'participant_4','participant_5', 'participant_6', 'participant_8', ...
         'participant_12', 'participant_13'};
allMA = {'participant_7', 'participant_9', 'participant_11'};
allMO = {'participant_2', 'participant_3', 'participant_10'};

%% Condition
condsList = {'NG_Left', ... % 1
             'NG_Right', ... % 2
             'NG_Neutral', ... % 3
             'G_Left', ... % 4
             'G_Right', ... % 5
             'G_Neutral'}; % 6

%% Selections

grp = 'C';
allGrp = allC;
condType = condsList{1};
chans = rightOcc;

%% Load Dataset

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for i = 1:length(allGrp)
    [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', conds ,'commands',{ ...
        {'index',i,'load',['C:\\MATLAB\\exp_1\\results\\EEG\\' grp '\\' allGrp{i} '\\' condType '_' allGrp{i} '.set']}, ...
        {'index',i,'subject',allGrp{i}}}, ...
        'updatedat','on','rmclust','on' );
end

%% Pre-Compute
% [STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on','interp','on','spec','on','specparams',{'specmode','fft','logtrials','off'},'ersp','on','erspparams',{'cycles',[3 0.8] ,'nfreqs',100,'ntimesout',200},'itc','on');
[STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on', ...
                                                'rmicacomps','on', ...
                                                'interp','on', ...
                                                'recompute','on', ...
                                                'erp','on','erpparams',{'rmbase',[-1000 -200] }, ...
                                                'spec','on', ...
                                                'specparams',{'specmode','fft','logtrials','off'}, ...
                                                'ersp','on','erspparams',{'cycles',[3 0.8] , ...
                                                                          'baseline',[-1000 -200], ...
                                                                          'basenorm', 'on', ...
                                                                          'plotphase', 'off', ...
                                                                          'padratio', 2, ...
                                                                          'freqscale', 'linear', ...
                                                                          'alpha',0.05, ...
                                                                          'mcorrect', 'fdr'}, ...
                                                'itc','on');

% nfreqs, ntimesout

% Plot
% Set parameter
STUDY = pop_erspparams(STUDY, 'freqrange',[2 40], 'ersplim', [1 1], 'subbaseline', 'on', 'averagemode', 'ave', 'averagechan','on');
[STUDY erspdata ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                        'channels',chans, ...
                                                                        'plotsubjects', 'on', ...
                                                                        'design', 1);
% see pop_specparams for additional parameters

eeglab redraw;




















































