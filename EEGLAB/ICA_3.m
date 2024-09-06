%% participant info

% group = 'x';
% participantNum = 'x';

%% load and prepare Seperate ICA dataset
EEGica = pop_loadset('filename',['SepICA1_participant_' participantNum '.set'], ...
                  'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

% % line noise
% EEGica = pop_cleanline(EEGica, 'bandwidth',2,'chanlist',[1:70] ,'computepower',1,'linefreqs',[50 100], ...
%                          'newversion',0,'normSpectrum',0,'p',0.01,'pad',2,'plotfigures',0, ...
%                          'scanforlines',0,'sigtype','Channels','taperbandwidth',2,'tau',100, ...
%                          'verb',1,'winsize',4,'winstep',1);

% % Through scroll, remove bad portions espec. before block starts
% EEGica = pop_eegplot(EEGica, 1, 1, 1);
% 
% % remove same channels in ICA dataset as removed in rbc (including EXGs)
% EEGica = pop_select(EEGica);

%% ICA

% EEGica = pop_resample( EEGica, 200); 
% Run ICA decomposition
EEGica = pop_runica(EEGica, 'icatype', 'runica', 'extended',1,'rndreset','yes','interrupt','on');

%% Compute and pop ICLabel components
pop_iclabel(EEGica, 'default'); 
pop_viewprops(EEGica, 0);

EEGica = pop_saveset(EEGica, 'filename',['ICAWeight_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);


%% load main (RBC) dataset
EEG = pop_loadset('filename',['RBC_participant_' participantNum '.set'], ...
                  'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% Apply ICA to original dataset

% Tranfer ICA related components to main dataset
EEG.icaact = EEGica.icaact;
EEG.icawinv = EEGica.icawinv;
EEG.icaweights = EEGica.icaweights;
EEG.icasphere = EEGica.icasphere;
EEG.icachansind = EEGica.icachansind;

% Remove components
EEG = pop_subcomp(EEG);

%% Save dataset
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Data ICA Removed','gui','off'); 
EEG = pop_saveset(EEG, 'filename',['ICA_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

eeglab redraw;

