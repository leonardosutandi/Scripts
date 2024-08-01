%% participant info

% group = 'x';
% participantNum = 'x';

%% load ICA dataset
EEG = pop_loadset('filename',['ICA_participant_' participantNum '.set'], ...
                  'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% Remove unused channels

EEG = pop_select( EEG, 'rmchannel',{'EXG3','EXG4','EXG5','EXG6','EXG7','EXG8'});

%% Epoch

% Trial condition

% <<<<<<<<<< NoGrat >>>>>>>>>>
trialType = {'NoGrat'};
% Left
cueType = {'cueLeft'};
epoch = 'NG_Left';
% % Right
% cueType = {'cueRight'};
% epoch = 'NG_Right';
% % Neutral
% cueType = {'cueNeutral'};
% epoch = 'NG_Neutral';

% <<<<<<<<<<< Grat >>>>>>>>>>>
% trialType = {'Grat'};
% % Left
% cueType = {'cueLeft'};
% epoch = 'G_Left';
% % Right
% cueType = {'cueRight'};
% epoch = 'G_Right';
% % Neutral
% cueType = {'cueNeutral'};
% epoch = 'G_Neutral';

% epoch [trial > cue]
EEG = pop_epoch( EEG, trialType, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
EEG = pop_epoch( EEG, cueType, [-1 1.5], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');

% interpolate mising channel(s)
EEG = pop_interp(EEG);


% trialTypes = {'NoGrat', 'Grat'};
% ttTimeWindow = [0 4];
% cueTypes = {'cueLeft', 'cueRight', 'cueNeutral'};
% ctTimeWindow = [-1 1.5];
% epoch = ['NG_left', 'NG_right', 'NG_neutral','G_left','G_right', 'G_neutral']; 
% 
% for i = 1:length(trialTypes)
% 
%     % for each element
%     trialType = trialTypes{i};
% 
%     % Epoch based on trial type first
%     EEG = pop_epoch( EEG, {trialType}, ttTimeWindow, 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
% 
%     % for each trial type, these cues:
%     for j = 1:length(cueTypes)
%         cueType = cueTypes{j};
%         % Cue Type
%         EEG = pop_epoch( EEG, cueType, ctTimeWindow, 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
%         % Save each cue type
%         EEG = pop_saveset(EEG, 'filename',['_participant_x.set'], ...
%                        'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_x\\']);
%         end
% 
% end
%% Save dataset

[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Data Epoch Interpolated','gui','off'); 
EEG = pop_saveset(EEG, 'filename',[epoch '_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% Check channel freq plot

% figure; pop_newtimef( EEG, 1, 24, [-1000 1498], [3 0.8] , 'topovec', 60, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'PO7', 'baseline',[-1000 0], 'freqs', [], 'plotphase', 'off', 'padratio', 1);
% figure; pop_newtimef( EEG, 1, 60, [-1000 1498], [3 0.8] , 'topovec', 60, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'PO8', 'baseline',[-1000 0], 'alpha',0.05, 'freqs', [], 'mcorrect', 'fdr', 'plotphase', 'off', 'padratio', 1);

eeglab redraw;


















