%% participant info

% group = 'x';
% participantNum = 'x';

%% load and prepare Seperate ICA dataset
EEGica = pop_loadset('filename',['SepICA_participant_' participantNum '.set'], ...
                  'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

% Through scroll, remove bad portions espec. before block starts
pop_eegplot(EEGica, 1, 1, 1);
% remove same channels in ICA as removed in rbc
EEGica = pop_select(EEGica);

%% ICA
% Run ICA decomposition
EEGica = pop_runica(EEGica, 'icatype', 'runica', 'extended',1,'rndreset','yes','interrupt','on');

% Compute and pop ICLabel components
pop_iclabel(EEGica, 'default');
pop_viewprops(EEGica, 0);

%% load main (RBC) dataset
EEG = pop_loadset('filename',['RBC_participant_' participantNum '.set'], ...
                  'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% Apply ICA to original dataset
% 
% EEG = pop_editset(EEG, 'icaweights', ['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum ...
%                                       '\\SepICA2_participant_' participantNum '.set']);
% EEG = pop_editset(EEG, 'icaweights', 'ALLEEG(1).icaweights', 'icasphere', 'ALLEEG(1).icasphere', 'icachansind', 'ALLEEG(1).icachansind');

% EEG = pop_mergeset(ALLEEG, [2], 1);

% Tranfer ICA related components to main dataset
EEG.icawinv = EEGica.icawinv;
EEG.icaweights = EEGica.icaweights;
EEG.icasphere = EEGica.icasphere;
EEG.icachansind = EEGica.icachansind;

% Remove components
EEG = pop_subcomp(EEG);

%% Save dataset
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Data ICA Removed','gui','off'); 
EEG = pop_saveset(EEG, 'filename',['ICA_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

eeglab redraw;

