%% participant info

% group = 'C';
% participantNum = 'p1';

%% load RBC dataset
EEG = pop_loadset('filename',['RBC_participant_' participantNum '.set'], ...
                  'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% ICA
% EEGLAB history file generated on the 12-Jul-2024
% ------------------------------------------------

EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'rndreset','yes','interrupt','on');
EEG = pop_iclabel(EEG, 'default');
% % Remove these components
EEG = pop_subcomp(EEG);
 
%% Save dataset
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Data ICA Removed','gui','off'); 
EEG = pop_saveset(EEG, 'filename',['ICA_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

% [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% [EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,1);
% EEG = pop_iclabel(EEG, 'default');
% [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
% EEG = pop_subcomp( EEG, [2   4   6  19  22  29  32  34  42  57  66], 0);
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Data pruned with ICA','gui','off'); 


eeglab redraw;
