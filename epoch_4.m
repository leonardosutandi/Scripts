%% participant info
% 
% group = 'C';
% participantNum = 'p1';

%% load ICA dataset
EEG = pop_loadset('filename',['ICA_participant_' participantNum '.set'], ...
                  'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% Epoch
% epoch [trial > cue]
% EEG = pop_epoch( EEG, {'NoGrat'}, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
% EEG = pop_epoch( EEG, {'cueLeft'}, [-1 1.9], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');

EEG = pop_epoch( EEG, {'NoGrat'}, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
EEG = pop_epoch( EEG, {'cueRight'}, [-1 1.9], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');

% EEG = pop_epoch( EEG, {'NoGrat'}, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
% EEG = pop_epoch( EEG, {'cueNeutral'}, [-1 1.9], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
% 
% EEG = pop_epoch( EEG, {'Grat'}, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
% EEG = pop_epoch( EEG, {'cueLeft'}, [-1 1.9], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
% 
% EEG = pop_epoch( EEG, {'Grat'}, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
% EEG = pop_epoch( EEG, {'cueRight'}, [-1 1.9], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
% 
% EEG = pop_epoch( EEG, {'Grat'}, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
% EEG = pop_epoch( EEG, {'cueNeutral'}, [-1 1.9], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
% interpolate mising channel(s)
EEG = pop_interp(EEG);

eeglab redraw;

%% Save dataset

[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Data Epoch Interpolated','gui','off'); 
EEG = pop_saveset(EEG, 'filename',['epoch_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% Check channel freq plot

% figure; pop_newtimef( EEG, 1, 24, [-1000 1898], [3 0.8] , 'topovec', 60, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'PO4', 'baseline',[-1000 0], 'freqs', [2 40], 'plotphase', 'off', 'padratio', 4);
% figure; pop_newtimef( EEG, 1, 24, [-1000 1898], [3 0.8] , 'topovec', 60, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'PO4', 'baseline',[-1000 0], 'alpha',0.05, 'freqs', [2 40], 'mcorrect', 'fdr', 'plotphase', 'off', 'padratio', 4);
% 



















