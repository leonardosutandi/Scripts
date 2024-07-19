%% participant info

group = 'C';
participantNum = 'p1';

%% load previous dataset
EEG = pop_loadset('filename',['PP_participant_' participantNum '.set'], ...
                  'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% plot power spectrum + spectoplot
pop_eegplot(EEG, 1, 1, 1);
pop_spectopo(EEG);

% remove bad channel
% EEG = pop_select( EEG, 'rmchannel',{'FC3'});
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','BDF file bc rm','gui','off'); 

%% plot data scroll
% pop_eegplot( EEG, 1, 1, 1);

% reject here
% EEG = eeg_eegrej( EEG, [998 1382] );

%% save new set
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname','BDF file bdata rm','gui','off'); 

% MANUALLY SAVE DATASET AFTER REJECTION

[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Data Bad Channels/Data Removed','gui','off'); 
eeglab redraw;
