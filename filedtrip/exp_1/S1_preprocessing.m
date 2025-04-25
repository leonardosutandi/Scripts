%% Participant information

% group = 'C';
% participantNum = 'x';
% 
% filepath = ['C:\MATLAB\exp_1\results\EEG\' group '\participant_' participantNum '\']; % C for local, F for pav_SSD, D for Zbook_SSD
% rawData = [filepath 'participant_' participantNum '.bdf'];

%% Per group preprocess

allC =  {'participant_4', 'participant_8', ...
         'participant_12', 'participant_14', 'participant_15', ... 
         'participant_18', 'participant_19', 'participant_22', 'participant_25', ...
         'participant_29', 'participant_31', 'participant_36', 'participant_37', ...
         'participant_38', 'participant_40', 'participant_41'}; %17
allMA = {'participant_7', 'participant_9', ...
         'participant_11', 'participant_20', 'participant_21', ... 
         'participant_24', 'participant_27a', 'participant_27b', 'participant_30', ...
         'participant_33', 'participant_34', 'participant_35', 'participant_39'};
allMO = {'participant_2', 'participant_3', 'participant_10', 'participant_17', 'participant_32'};

group = 'MA';
allGrp = allMA;

for i = 1:length(allGrp)

filepath = ['C:\MATLAB\exp_1\results\EEG\' group '\' allGrp{i} '\']; % C for local, F for pav_SSD, D for Zbook_SSD
rawData = [filepath allGrp{i} '.bdf'];

%% Check Trigger/Events

% cfg = [];
% cfg.dataset = rawData;
% cfg.trialdef.eventtype = '?';
% events = ft_definetrial(cfg);

%% Triggers/Events Epoching Setup

cfg = [];
cfg.dataset = rawData;
cfg.trialfun = 'ft_trialfun_TOI_trial';
cfg.trialdef.eventtype = 'STATUS';
% cfg.trialdef.eventvalue = original_label([1:5]);
cfg.trialdef.prestim = 2;
cfg.trialdef.poststim = 2;
cfg.trialdef.overlap = 0; % make sure no overlap between snippets
cfg = ft_definetrial(cfg);

%% Configure Data Set

% Keep relevant channels
cfg.channel = [1:72];

% Rereference
cfg.reref = 'yes';
cfg.refchannel = {'EXG1', 'EXG2'};
cfg.demean = 'yes';

% % Filter data (Bandpass)
% cfg.bpfilter = 'yes';
% cfg.bpfilttype = 'but';
% cfg.bpfreq = [0.5 150];

% Filter data (HP - LP)
% high-pass
cfg.hpfilter = 'yes';
cfg.hpfilttype = 'but';
cfg.hpfreq = 0.5;
cfg.hpfiltord = 2;
% low-pass
cfg.lpfilter = 'yes';
cfg.lpfilttype = 'but';
cfg.lpfreq = 150;
% data = ft_preprocessing(cfg);

% Line noise (50Hz) and screen refresh rate (85Hz) removal
cfg.bsfilter = 'yes';
cfg.bsfilttype = 'but';
cfg.bsfreq = [48 52; 83 87];

% % Line noise (50Hz) and screen refresh rate (85Hz) removal
% cfg.dftfilter = 'yes';
% cfg.dftfreq = [50 85 100];

% Finalise / Preprocess Data
data = ft_preprocessing(cfg);

%% Correct Label Order

% Removing bad channnel before ICA and interpolating it later results in
% removed channel(s) reordered to the bottom of the list. We don't want
% this when averaging results from ft_freqanalysis() as each participant
% will have different channel order and number of channel removed. Recall 
% later before computing TFR.

ori_label = data.label(1:64);
save([filepath 'ori_label.mat'], 'ori_label', '-v7.3');

if srtcmp(allGrp{i}, 'participant_27a')
    save(['C:\MATLAB\exp_1\results\EEG\' group '\participant_27\ori_label.mat'], 'ori_label', '-v7.3');
end

%% Reorder data to the correct label

% Do this bit for participants with wrong connector.
% Instead of relabelling, reorder the data to fit the label.

flipped_connector = {'participant_2', 'participant_3', 'participant_4', 'participant_5', 'participant_6'};

if ismember(allGrp{i}, flipped_connector)
    reorder = [33:64, 1:32, 65:72];

    for j = 1:length(data.trial)
        data.trial{1,j} = data.trial{1,j}(reorder,:);
    end
end

% flipped_connector = {'2', '3', '4', '5', '6'};
% 
% if ismember(participantNum, flipped_connector)
%     reorder = [33:64, 1:32, 65:72];
% 
%     for i = 1:length(data.trial)
%         data.trial{1,i} = data.trial{1,i}(reorder,:);
%     end
% end

%% Remove ref channels

cfg = [];
cfg.channel = {'all', '-EXG1', '-EXG2'};
data = ft_preprocessing(cfg, data);

%% New filter for ICA

% increase high-pass filter for better ICA decomposition
% high-pass
cfg.hpfilter = 'yes';
cfg.hpfilttype = 'but';
cfg.hpfreq = 1;
cfg.hpfiltord = 2;

% on new seperate ICA data set instead of main data set
data_ica = ft_preprocessing(cfg, data);

% % Preserved trigger marks
% data_trigger = data_ica;
% save([filepath 'data_trigger.mat'], 'data_trigger', '-v7.3');

%% Downsample

cfg = [];
cfg.resamplefs = [512];
data = ft_resampledata(cfg, data);
data_ica = ft_resampledata(cfg, data_ica);

% NOTE: downsampling made trigger marks disappear

%% Save Dataset

save([filepath 's1_preprocessing_done.mat'], 'data', '-v7.3');
save([filepath 's1_preprocessing_ica_done.mat'], 'data_ica', '-v7.3');

end

%% Test power spectrum

% cfg = [];
% cfg.method = 'mtmfft';
% cfg.output = 'pow';
% cfg.foi = [40:150];
% cfg.taper = 'boxcar';
% cfg.tapsmofrq = [2];
% cfg.channel = 'CPz';
% 
% % cfg.trials = find(data.trialinfo(:,1) == 13);
% tes = ft_freqanalysis(cfg, data);
% 
% figure;
% hold on;
% plot(tes.freq, (tes.powspctrm), 'linewidth', 2)
% % legend('Button press left', 'Button press right')
% xlabel('Frequency (Hz)')
% ylabel('Power (\mu V^2)')

%% Test Triggers

% cfg = [];
% cfg.channel = {'eeg'};
% cfg.layout = 'biosemi64.lay';
% cfg.plotevents = 'yes';
% cfg.viewmode = 'vertical';
% cfg.ylim = [-30 30];
% cfg = ft_databrowser(cfg, data);


