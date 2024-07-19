%% Participant Information Input

group = 'C';
participantNum = 'p1';

%% Import raw dataset

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_biosig(['C:\MATLAB\exp_1\results\EEG\' group '\participant_' ...
                participantNum '\participant_' participantNum '.bdf']);

%% Set channel location

EEG=pop_chanedit(EEG, {'lookup', ...
    'C:\\MATLAB\\toolboxes\\eeglab2024.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'});

%% Remove unused channels

EEG = pop_select( EEG, 'rmchannel',{'GSR1','GSR2','Erg1','Erg2','Resp','Plet','Temp'});

%% Re-reference (Mastoids)
% 65 = EXG1; 66 = EXG2; ...
EEG = pop_reref(EEG, [65 66]);
% , 'exclude', [67 68 69 70 71 72]
%% Relabel events (triggers)

% Trial condition
EEG = pop_selectevent( EEG, 'type',{'condition 1'},'renametype','NoGrat','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 2'},'renametype','Grat','deleteevents','off');
% Cue location
EEG = pop_selectevent( EEG, 'type',{'condition 3'},'renametype','cueLeft','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 4'},'renametype','cueRight','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 5'},'renametype','cueNeutral','deleteevents','off');
% Gap location
EEG = pop_selectevent( EEG, 'type',{'condition 6'},'renametype','loc1','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 7'},'renametype','loc2','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 8'},'renametype','loc3','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 9'},'renametype','loc4','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 10'},'renametype','loc5','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 11'},'renametype','loc6','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 12'},'renametype','loc7','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 13'},'renametype','loc8','deleteevents','off');
% Detection responce
EEG = pop_selectevent( EEG, 'type',{'condition 14'},'renametype','detResp','deleteevents','off');
% detection correctness
EEG = pop_selectevent( EEG, 'type',{'condition 15'},'renametype','detCor','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 16'},'renametype','detIncor','deleteevents','off');
% Gap location accuracy response
EEG = pop_selectevent( EEG, 'type',{'condition 17'},'renametype','loc1Acc','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 18'},'renametype','loc2Acc','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 19'},'renametype','loc3Acc','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 20'},'renametype','loc4Acc','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 21'},'renametype','loc5Acc','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 22'},'renametype','loc6Acc','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 23'},'renametype','loc7Acc','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 24'},'renametype','loc8Acc','deleteevents','off');
% Accuracy Correctness
EEG = pop_selectevent( EEG, 'type',{'condition 25'},'renametype','accCor','deleteevents','off');
EEG = pop_selectevent( EEG, 'type',{'condition 26'},'renametype','accIncor','deleteevents','off');

%% Downsample to 512 Hz (min. 2.5x highest foi)

EEG = pop_resample( EEG, 512); 

%% Bandpass filter

EEG = pop_eegfiltnew(EEG,'locutoff',0.5, ...
                         'hicutoff', 40); 


%% Notch filter

% line noise
EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:70] ,'computepower',1,'linefreqs',[50 100], ...
                         'newversion',0,'normSpectrum',0,'p',0.01,'pad',2,'plotfigures',0, ...
                         'scanforlines',0,'sigtype','Channels','taperbandwidth',2,'tau',100, ...
                         'verb',1,'winsize',4,'winstep',1);
% harmonics
% EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:70] ,'computepower',1,'linefreqs',100, ...
%                          'newversion',0,'normSpectrum',0,'p',0.01,'pad',2,'plotfigures',0, ...
%                          'scanforlines',0,'sigtype','Channels','taperbandwidth',2,'tau',100, ...
%                          'verb',1,'winsize',4,'winstep',1);

%% Save Processed data

[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Data Pre-Processed','gui','off'); 

EEG = pop_saveset(EEG, 'filename',['PP_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);
eeglab redraw;

%% Saving current dataset

% % Save to GUI: use after each step
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','BDF file bc rm','gui','off');
% % Save to file: use at the end of the script
% EEG = pop_saveset(EEG, 'filename',['PP_participant_' participantNum '.set'],'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);
















