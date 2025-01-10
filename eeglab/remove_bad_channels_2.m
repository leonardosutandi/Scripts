%% participant info

% group = 'X';
% participantNum = 'X';

%% load previous dataset

EEG = pop_loadset('filename',['PP_participant_' participantNum '.set'], ...
                  'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% plot power spectrum + spectoplot
pop_eegplot(EEG, 1, 1, 1);
% pop_spectopo(EEG);

% remove bad channel
EEG = pop_select(EEG);

%% reject same channels in Seperate ICA Dataset

% separate dataset for ICA decomposition. ICA weights to be transferred to
% actual dataset to be analysed

% for ICA (so EEG index = EEGica index)
EEGica = pop_loadset('filename',['SepICA_participant_' participantNum '.set'], ...
                  'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

% remove same channel AND poor segments in ICA
EEGica = pop_select(EEGica);

%% Save dataset

% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Data Bad Channels/Data Removed','gui','off'); 
EEG = pop_saveset(EEG, 'filename',['RBC_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

EEGica = pop_saveset(EEGica, 'filename',['SepICA1_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

eeglab redraw
