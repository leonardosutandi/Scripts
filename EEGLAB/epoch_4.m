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
% epoch [trial > cue]
EEG1 = pop_epoch( EEG, trialType, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
EEG1 = pop_epoch( EEG1, cueType, [-1 1.502], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
% interpolate mising channel(s)
EEG1 = pop_interp(EEG1);
% Check each epoch
pop_eegplot(EEG1, 1, 1, 1);
EEG1 = pop_select(EEG1);
% EEG1 = pop_rejepoch(EEG1);
% save
EEG1 = pop_saveset(EEG1, 'filename',[epoch '_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

% Right
cueType = {'cueRight'};
epoch = 'NG_Right';
% epoch [trial > cue]
EEG2 = pop_epoch( EEG, trialType, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
EEG2 = pop_epoch( EEG2, cueType, [-1 1.502], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
% interpolate mising channel(s)
EEG2 = pop_interp(EEG2);
% Check each epoch
pop_eegplot(EEG2, 1, 1, 1);
EEG2 = pop_select(EEG2);
% save
EEG2 = pop_saveset(EEG2, 'filename',[epoch '_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);


% Neutral
cueType = {'cueNeutral'};
epoch = 'NG_Neutral';
% epoch [trial > cue]
EEG3 = pop_epoch( EEG, trialType, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
EEG3 = pop_epoch( EEG3, cueType, [-1 1.502], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
% interpolate mising channel(s)
EEG3 = pop_interp(EEG3);
% Check each epoch
pop_eegplot(EEG3, 1, 1, 1);
EEG3 = pop_select(EEG3);
% save
EEG3 = pop_saveset(EEG3, 'filename',[epoch '_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);


% <<<<<<<<<<< Grat >>>>>>>>>>>
trialType = {'Grat'};

% Left
cueType = {'cueLeft'};
epoch = 'G_Left';
% epoch [trial > cue]
EEG4 = pop_epoch( EEG, trialType, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
EEG4 = pop_epoch( EEG4, cueType, [-1 1.502], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
% interpolate mising channel(s)
EEG4 = pop_interp(EEG4);
% Check each epoch
pop_eegplot(EEG4, 1, 1, 1);
EEG4 = pop_select(EEG4);
% save
EEG4 = pop_saveset(EEG4, 'filename',[epoch '_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

% Right
cueType = {'cueRight'};
epoch = 'G_Right';
% epoch [trial > cue]
EEG5 = pop_epoch( EEG, trialType, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
EEG5 = pop_epoch( EEG5, cueType, [-1 1.502], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
% interpolate mising channel(s)
EEG5 = pop_interp(EEG5);
% Check each epoch
pop_eegplot(EEG5, 1, 1, 1);
EEG5 = pop_select(EEG5);
% save
EEG5 = pop_saveset(EEG5, 'filename',[epoch '_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

% Neutral
cueType = {'cueNeutral'};
epoch = 'G_Neutral';
% epoch [trial > cue]
EEG6 = pop_epoch( EEG, trialType, [0 4], 'newname', 'Data Trial Cond. Epoched', 'epochinfo', 'yes');
EEG6 = pop_epoch( EEG6, cueType, [-1 1.502], 'newname', 'Data Cue Epoched', 'epochinfo', 'yes');
% interpolate mising channel(s)
EEG6 = pop_interp(EEG6);
% Check each epoch
pop_eegplot(EEG6, 1, 1, 1);
EEG6 = pop_select(EEG6);
% save
EEG6 = pop_saveset(EEG6, 'filename',[epoch '_participant_' participantNum '.set'], ...
                       'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% Save dataset

% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Data Epoch Interpolated','gui','off'); 
% EEG = pop_saveset(EEG, 'filename',[epoch '_participant_' participantNum '.set'], ...
%                        'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' group '\\participant_' participantNum '\\']);

%% Check channel freq plot

% figure; pop_newtimef( EEG, 1, 24, [-1000 1498], [3 0.8] , 'topovec', 60, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'PO7', 'baseline',[-1000 0], 'freqs', [], 'plotphase', 'off', 'padratio', 1);
% figure; 
% 
% [ersp itc powbase times frequencies]=pop_newtimef( EEG, 1, 60, [-1000 1498], [3 0.8] , 'topovec', 60, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'PO8', 'baseline',[-1000 0], 'alpha',0.05, 'freqs', [], 'mcorrect', 'fdr', 'plotphase', 'off', 'padratio', 1);
%size(ersp)
%cond1=squeeze(ersp(1,1,:,:))
%figure; imagesc(cond1)
%permute(ersp,[3,2,1,4]);
eeglab redraw;


%% For loop?
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














