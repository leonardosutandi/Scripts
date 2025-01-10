%% Participant Information Input

group = 'MA';
participantNum = '24';

%% Import raw dataset

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_biosig(['C:\MATLAB\exp_1\results\EEG\' group '\participant_' ...
                participantNum '\participant_' participantNum '.bdf']);

%% Set channel location

EEG = pop_chanedit(EEG, {'lookup', ...
    'C:\\MATLAB\\toolboxes\\eeglab2024.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'});

%% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< ONLY WRONG ONES >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% % do this for participant 1-6 (wrong A/B connector). Channel function above
% % assign data to the correct location (not label, as a result, wrong label layout).
% % This section relabel the wrong layout to the already correct data.
% 
% % Correct label (in-order)
% relabel = {'Fpz'; 'Fp2'; 'AF8'; 'AF4'; 'AFz'; 'Fz'; 'F2'; 'F4'; 'F6'; 'F8'; 'FT8'; 'FC6'; 'FC4'; 'FC2'; 'FCz'; 'Cz'; 'C2'; 'C4'; 'C6'; 'T8'; 'TP8'; 'CP6'; 'CP4'; 'CP2'; 'P2'; 'P4'; 'P6'; 'P8'; 'P10'; 'PO8'; 'PO4'; 'O2'; ...
%            'Fp1'; 'AF7'; 'AF3'; 'F1'; 'F3'; 'F5'; 'F7'; 'FT7'; 'FC5'; 'FC3'; 'FC1'; 'C1'; 'C3'; 'C5'; 'T7'; 'TP7'; 'CP5'; 'CP3'; 'CP1'; 'P1'; 'P3'; 'P5'; 'P7'; 'P9'; 'PO7'; 'PO3'; 'O1'; 'Iz'; 'Oz'; 'POz'; 'Pz'; 'CPz';...
%            'EXG1'; 'EXG2'; 'EXG3'; 'EXG4'; 'EXG5'; 'EXG6'; 'EXG7'; 'EXG8'; 'GSR1'; 'GSR2'; 'Erg1'; 'Erg2'; 'Resp'; 'Plet'; 'Temp'};
% 
% % re-label
% for i = 1:length(relabel)
%     EEG = pop_chanedit(EEG, 'changefield',{i,'labels',relabel{i}});
% end
% 
% % Correct indecies (in-order)
% relabel2 = {33; 34; 35; 36; 37; 38; 39; 40; 41; 42; 43; 44; 45; 46; 47; 48; 49; 50; 51; 52; 53; 54; 55; 56; 57; 58; 59; 60; 61; 62; 63; 64; ...
%             1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; 32;...
%             65; 66; 67; 68; 69; 70; 71; 72; 73; 74; 75; 76; 77; 78; 79};
% 
% % re-label
% for i = 1:length(relabel2)
%     EEG = pop_chanedit(EEG, 'changefield',{i,'urchan',relabel2{i}});
% end

%% Remove unused channels

EEG = pop_select(EEG, 'rmchannel',{'GSR1','GSR2','Erg1','Erg2','Resp','Plet','Temp'});

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

EEG = pop_resample(EEG, 512);

%% Bandpass filter

% for main dataset
EEG = pop_eegfiltnew(EEG,'locutoff',0.5, ...
                         'hicutoff', 40); 

% for ICA
EEGica = pop_eegfiltnew(EEG,'locutoff',1, ...
                         'hicutoff', 40); 

%% Notch filter

% % line noise
% EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:70] ,'computepower',1,'linefreqs',[50 100], ...
%                          'newversion',0,'normSpectrum',0,'p',0.01,'pad',2,'plotfigures',0, ...
%                          'scanforlines',0,'sigtype','Channels','taperbandwidth',2,'tau',100, ...
%                          'verb',1,'winsize',4,'winstep',1);

%% Save datasets

% Primary dataset
EEG = pop_saveset(EEG, 'filename',['PP_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);
% ICA dataset
EEGica = pop_saveset(EEGica, 'filename',['SepICA_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

eeglab redraw;




