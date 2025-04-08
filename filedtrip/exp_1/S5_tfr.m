%% Participant information

% 'participant_x'
allC =  {'participant_4', 'participant_8', 'participant_12', 'participant_14', ...
         'participant_15', 'participant_19', 'participant_22', ...
         'participant_25', ...
         'participant_29', 'participant_31', 'participant_36', 'participant_37', ...
         'participant_38', 'participant_40', 'participant_41'};
allMA = {};
allMO = {};
allC =  {'participant_19'};
% Choose group to compute
group = 'C';
allGrp = allC;
conditions = [13, 14, 15, 23, 24, 25]; % 1 = No gratings, 2 = gratings; 3 = left cue, 4 = right cue, 5 = neutral cue

filepath_in = ['C:\MATLAB\exp_1\results\EEG\' group '\']; % C for local, F for pav_SSD, D for Zbook_SSD
filepath_out = ['C:\MATLAB\exp_1\results\EEG\conditions\' group '\']; % C for local, F for pav_SSD, D for Zbook_SSD

% Computing purposes > fed to ft_freqanalysis()
compute_alpha = [2 30];
compute_gamma = [25 100];
compute_time = [-2:0.01:2];

% Choose freq to compute
compute_foi = compute_alpha;

%% Compute TFRs (allChans)

% This TFR chunk computes all channel, accomodating single and topo plots. 
% Main for-loop: participants; Secondary for-loop: conditions. This allows 
% loading participant data set only once, i.e. once a participant's
% 4 conditions are computed, jump to next participant.

% Set TFR parameters
cfg = [];
cfg.method = 'wavelet';
cfg.width = 5;
cfg.foilim = compute_foi;
cfg.toi = compute_time;
cfg.output = 'pow';
cfg.keeptrials = 'yes';
cfg.channel = 'all';

for i = 1:length(allGrp)
    
    load([filepath_in allGrp{i} '\s4_epoch_done.mat']);

    for j = 1:length(conditions)

        % load([filepath allGrp{j}]);
        
        cfg.trials = find(data.trialinfo(:,1) == conditions(j));
    
        % Loop over conditions, then participants
        % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        % NG Left >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        if j == 1 && i == 1
            ng_left{1} = ft_freqanalysis(cfg, data);
        elseif j == 1 && i~= 1
            ng_left{i} = ft_freqanalysis(cfg, data);
        end

        % NG Right
        if j == 2 && i == 1
            ng_right{1} = ft_freqanalysis(cfg, data);
        elseif j == 2 && i~= 1
            ng_right{i} = ft_freqanalysis(cfg, data);
        end

        % NG Neutral
        if j == 3 && i == 1
            ng_neutral{1} = ft_freqanalysis(cfg, data);
        elseif j == 3 && i~= 1
            ng_neutral{i} = ft_freqanalysis(cfg, data);
        end

        % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        % G Left >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        if j == 4 && i == 1
            g_left{1} = ft_freqanalysis(cfg, data);
        elseif j == 4 && i~= 1
            g_left{i} = ft_freqanalysis(cfg, data);
        end

        % G Right
        if j == 5 && i == 1
            g_right{1} = ft_freqanalysis(cfg, data);
        elseif j == 5 && i~= 1
            g_right{i} = ft_freqanalysis(cfg, data);
        end

        % G Neutral
        if j == 6 && i == 1
            g_neutral{1} = ft_freqanalysis(cfg, data);
        elseif j == 6 && i~= 1
            g_neutral{i} = ft_freqanalysis(cfg, data);
        end
        
    end
end

% Save individual freqanalysis (per condition) outputs
save([filepath_out 'indiv\ng_left.mat'], 'ng_left', '-v7.3');
save([filepath_out 'indiv\ng_right.mat'], 'ng_right', '-v7.3');
save([filepath_out 'indiv\ng_neutral.mat'], 'ng_neutral', '-v7.3');
save([filepath_out 'indiv\g_left.mat'], 'g_left', '-v7.3');
save([filepath_out 'indiv\g_right.mat'], 'g_right', '-v7.3');
save([filepath_out 'indiv\g_neutral.mat'], 'g_neutral', '-v7.3');

%% Reload (if needed)

% load([filepath_out 'indiv\ng_left.mat']);
% load([filepath_out 'indiv\ng_right.mat']);
% load([filepath_out 'indiv\ng_neutral.mat']);
% load([filepath_out 'indiv\g_left.mat']);
% load([filepath_out 'indiv\g_right.mat']);
% load([filepath_out 'indiv\g_neutral.mat']);

%% Extract individual ROI average

cond_eeg = {ng_left, ng_right, ng_neutral, g_left, g_right, g_neutral};

% Channel of Interest
left_occ = {'P5', 'P3', 'P1', 'PO7', 'PO3', 'O1'};
right_occ = {'P6', 'P4', 'P2', 'PO8', 'PO4', 'O2'};
left_par = {'C5', 'C3', 'C1', 'CP5', 'CP3', 'CP1'};
right_par = {'C6', 'C4', 'C2', 'CP6', 'CP4', 'CP2'};

% Create empty data output for indexing/plotting purposes
idx = ng_left{1,1}; % any works, since only coi, foi and toi are extracted

% Find FOI index
freqIdx = find(idx.freq >= 8 & idx.freq <= 14);
minFreq = freqIdx(1,1);
maxFreq = freqIdx(1,end);
% Find TOI index
timeIdx = find(idx.time >= 0.2 & idx.time <= 1.5);
minTime = timeIdx(1,1);
maxTime = timeIdx(1,end);
% Find COI index
[LIA loIdx] = ismember(left_occ, idx.label);
[LIA roIdx] = ismember(right_occ, idx.label);
[LIA lpIdx] = ismember(left_par, idx.label);
[LIA rpIdx] = ismember(right_par, idx.label);

eegIdx = {loIdx roIdx lpIdx rpIdx};
  
for i = 1:length(cond_eeg)

    for j = 1:length(allGrp)

        for k = 1:length(eegIdx)

        cond = cond_eeg{1,i}{1,j}.powspctrm(:, eegIdx{k}, minFreq:maxFreq, minTime:maxTime);        

            % NG Left
            if i == 1 && k == 1
                tt_ng_left_left_occ{j} = mean(cond, 2:4); % trial-to-trial eeg data averaged across COI
                avg_ng_left_left_occ{j} = mean(tt_ng_left_left_occ{j}, 1); % eeg data averaged across epochs and COI
            elseif i == 1 && k == 2
                tt_ng_left_right_occ{j} = mean(cond, 2:4);
                avg_ng_left_right_occ{j} = mean(tt_ng_left_right_occ{j}, 1);
            elseif i == 1 && k == 3
                tt_ng_left_left_par{j} = mean(cond, 2:4);
                avg_ng_left_left_par{j} = mean(tt_ng_left_left_par{j}, 1);
            elseif i == 1 && k == 4
                tt_ng_left_right_par{j} = mean(cond, 2:4);
                avg_ng_left_right_par{j} = mean(tt_ng_left_right_par{j}, 1);
            end

            % NG Right
            if i == 2 && k == 1
                tt_ng_right_left_occ{j} = mean(cond, 2:4);
                avg_ng_right_left_occ{j} = mean(tt_ng_right_left_occ{j}, 1);
            elseif i == 2 && k == 2
                tt_ng_right_right_occ{j} = mean(cond, 2:4);
                avg_ng_right_right_occ{j} = mean(tt_ng_right_right_occ{j}, 1);
            elseif i == 2 && k == 3
                tt_ng_right_left_par{j} = mean(cond, 2:4);
                avg_ng_right_left_par{j} = mean(tt_ng_right_left_par{j}, 1);
            elseif i == 2 && k == 4
                tt_ng_right_right_par{j} = mean(cond, 2:4);
                avg_ng_right_right_par{j} = mean(tt_ng_right_right_par{j}, 1);
            end

            % NG Neutral
            if i == 3 && k == 1
                tt_ng_neutral_left_occ{j} = mean(cond, 2:4);
                avg_ng_neutral_left_occ{j} = mean(tt_ng_neutral_left_occ{j}, 1);
            elseif i == 3 && k == 2
                tt_ng_neutral_right_occ{j} = mean(cond, 2:4);
                avg_ng_neutral_right_occ{j} = mean(tt_ng_neutral_right_occ{j}, 1);
            elseif i == 3 && k == 3
                tt_ng_neutral_left_par{j} = mean(cond, 2:4);
                avg_ng_neutral_left_par{j} = mean(tt_ng_neutral_left_par{j}, 1);
            elseif i == 3 && k == 4
                tt_ng_neutral_right_par{j} = mean(cond, 2:4);
                avg_ng_neutral_right_par{j} = mean(tt_ng_neutral_right_par{j}, 1);
            end

            % G Left
            if i == 4 && k == 1
                tt_g_left_left_occ{j} = mean(cond, 2:4); % trial-to-trial eeg data averaged across COI
                avg_g_left_left_occ{j} = mean(tt_g_left_left_occ{j}, 1); % eeg data averaged across epochs and COI
            elseif i == 4 && k == 2
                tt_g_left_right_occ{j} = mean(cond, 2:4);
                avg_g_left_right_occ{j} = mean(tt_g_left_right_occ{j}, 1);
            elseif i == 4 && k == 3
                tt_g_left_left_par{j} = mean(cond, 2:4);
                avg_g_left_left_par{j} = mean(tt_g_left_left_par{j}, 1);
            elseif i == 4 && k == 4
                tt_g_left_right_par{j} = mean(cond, 2:4);
                avg_g_left_right_par{j} = mean(tt_g_left_right_par{j}, 1);
            end

            % G Right
            if i == 5 && k == 1
                tt_g_right_left_occ{j} = mean(cond, 2:4);
                avg_g_right_left_occ{j} = mean(tt_g_right_left_occ{j}, 1);
            elseif i == 5 && k == 2
                tt_g_right_right_occ{j} = mean(cond, 2:4);
                avg_g_right_right_occ{j} = mean(tt_g_right_right_occ{j}, 1);
            elseif i == 5 && k == 3
                tt_g_right_left_par{j} = mean(cond, 2:4);
                avg_g_right_left_par{j} = mean(tt_g_right_left_par{j}, 1);
            elseif i == 5 && k == 4
                tt_g_right_right_par{j} = mean(cond, 2:4);
                avg_g_right_right_par{j} = mean(tt_g_right_right_par{j}, 1);
            end

            % G Neutral
            if i == 6 && k == 1
                tt_g_neutral_left_occ{j} = mean(cond, 2:4);
                avg_g_neutral_left_occ{j} = mean(tt_g_neutral_left_occ{j}, 1);
            elseif i == 6 && k == 2
                tt_g_neutral_right_occ{j} = mean(cond, 2:4);
                avg_g_neutral_right_occ{j} = mean(tt_g_neutral_right_occ{j}, 1);
            elseif i == 6 && k == 3
                tt_g_neutral_left_par{j} = mean(cond, 2:4);
                avg_g_neutral_left_par{j} = mean(tt_g_neutral_left_par{j}, 1);
            elseif i == 6 && k == 4
                tt_g_neutral_right_par{j} = mean(cond, 2:4);
                avg_g_neutral_right_par{j} = mean(tt_g_neutral_right_par{j}, 1);
            end
            
        end
    end
end

%% Write to CSV - ROI Average

% Put label and responses to a matrix
dataEEG(1:length(allGrp), :) = [avg_ng_left_left_occ',    avg_ng_left_right_occ',    avg_ng_left_left_par',    avg_ng_left_right_par', ...
                                avg_ng_right_left_occ',   avg_ng_right_right_occ',   avg_ng_right_left_par',   avg_ng_right_right_par', ...
                                avg_ng_neutral_left_occ', avg_ng_neutral_right_occ', avg_ng_neutral_left_par', avg_ng_neutral_right_par', ...
                                avg_g_left_left_occ',     avg_g_left_right_occ',     avg_g_left_left_par',     avg_g_left_right_par', ...
                                avg_g_right_left_occ',    avg_g_right_right_occ',    avg_g_right_left_par',    avg_g_right_right_par', ...
                                avg_g_neutral_left_occ',  avg_g_neutral_right_occ',  avg_g_neutral_left_par',  avg_g_neutral_right_par'];
% Label the columns    
labels = {'avg_ng_left_left_occ',    'avg_ng_left_right_occ',    'avg_ng_left_left_par',    'avg_ng_left_right_par', ...
          'avg_ng_right_left_occ',   'avg_ng_right_right_occ',   'avg_ng_right_left_par',   'avg_ng_right_right_par', ...
          'avg_ng_neutral_left_occ', 'avg_ng_neutral_right_occ', 'avg_ng_neutral_left_par', 'avg_ng_neutral_right_par', ...
          'avg_g_left_left_occ',     'avg_g_left_right_occ',     'avg_g_left_left_par',     'avg_g_left_right_par', ...
          'avg_g_right_left_occ',    'avg_g_right_right_occ',    'avg_g_right_left_par',    'avg_g_right_right_par', ...
          'avg_g_neutral_left_occ',  'avg_g_neutral_right_occ',  'avg_g_neutral_left_par',  'avg_g_neutral_right_par'};

avg_out = array2table(dataEEG, 'VariableNames', labels);
writetable(avg_out, [filepath_out 'dataEEG_' group '.csv']);

%% Write to CSV - Trial-to-Trial Based Average
% % Put label and responses to a matrix
% dataEEG(trial, :) = [tt_ng_left_left_occ, tt_ng_left_right_occ, tt_ng_left_left_par, tt_ng_left_right_par, ...
%                      tt_ng_right_left_occ, tt_ng_right_right_occ, tt_ng_right_left_par, tt_ng_right_right_par, ...
%                      tt_ng_neutral_left_occ, tt_ng_neutral_right_occ, tt_ng_neutral_left_par, tt_ng_neutral_right_par, ...
%                      tt_g_left_left_occ, tt_g_left_right_occ, tt_g_left_left_par, tt_g_left_right_par, ...
%                      tt_g_right_left_occ, tt_g_right_right_occ, tt_g_right_left_par, tt_g_right_right_par, ...
%                      tt_g_neutral_left_occ, tt_g_neutral_right_occ, tt_g_neutral_left_par, tt_g_neutral_right_par, ...
%                      avg_ng_left_left_occ, avg_ng_left_right_occ, avg_ng_left_left_par, avg_ng_left_right_par, ...
%                      avg_ng_right_left_occ, avg_ng_right_right_occ, avg_ng_right_left_par, avg_ng_right_right_par, ...
%                      avg_ng_neutral_left_occ, avg_ng_neutral_right_occ, avg_ng_neutral_left_par, avg_ng_neutral_right_par, ...
%                      avg_g_left_left_occ, avg_g_left_right_occ, avg_g_left_left_par, avg_g_left_right_par, ...
%                      avg_g_right_left_occ, avg_g_right_right_occ, avg_g_right_left_par, avg_g_right_right_par, ...
%                      avg_g_neutral_left_occ, avg_g_neutral_right_occ, avg_g_neutral_left_par, avg_g_neutral_right_par];
% % Label the columns    
% labels = {'tt_ng_left_left_occ', 'tt_ng_left_right_occ', 'tt_ng_left_left_par', 'tt_ng_left_right_par', ...
%           'tt_ng_right_left_occ', 'tt_ng_right_right_occ', 'tt_ng_right_left_par', 'tt_ng_right_right_par', ...
%           'tt_ng_neutral_left_occ', 'tt_ng_neutral_right_occ', 'tt_ng_neutral_left_par', 'tt_ng_neutral_right_par', ...
%           'tt_g_left_left_occ', 'tt_g_left_right_occ', 'tt_g_left_left_par', 'tt_g_left_right_par', ...
%           'tt_g_right_left_occ', 'tt_g_right_right_occ', 'tt_g_right_left_par', 'tt_g_right_right_par', ...
%           'tt_g_neutral_left_occ', 'tt_g_neutral_right_occ', 'tt_g_neutral_left_par', 'tt_g_neutral_right_par', ...
%           'avg_ng_left_left_occ', 'avg_ng_left_right_occ', 'avg_ng_left_left_par', 'avg_ng_left_right_par', ...
%           'avg_ng_right_left_occ', 'avg_ng_right_right_occ', 'avg_ng_right_left_par', 'avg_ng_right_right_par', ...
%           'avg_ng_neutral_left_occ', 'avg_ng_neutral_right_occ', 'avg_ng_neutral_left_par', 'avg_ng_neutral_right_par', ...
%           'avg_g_left_left_occ', 'avg_g_left_right_occ', 'avg_g_left_left_par', 'avg_g_left_right_par', ...
%           'avg_g_right_left_occ', 'avg_g_right_right_occ', 'avg_g_right_left_par', 'avg_g_right_right_par', ...
%           'avg_g_neutral_left_occ', 'avg_g_neutral_right_occ', 'avg_g_neutral_left_par', 'avg_g_neutral_right_par'};
% 
% csv_out = array2table(dataEEG, 'VariableNames', labels);
% writetable(csv_out, [filepath_out 'dataEEG' group '.csv']);

%% Average Manually

% We probably still want this instead of ft_freqgrandaverage() if we want
% to check trial-to-trial analysis using LMM. ft_freqgrandaverage() only
% works on ft_freqanalysis() with cfg.keeptrials = 'yes';

% This chunck will combine every participants powspctrm data (trial x
% channel x freq x time) into a single ft_freqanalysis() output. e.g.
% becomes 2000 x 64 x 113 x 501. Let ft_singleplotTFR() average the data
% itself, instead of manually using mean. DATA.powspctrm have 1xn 
% cells each (trial x channel x freq x time). cat(1, DATA.powspctrm{1,:}) 
% compress data by trial, where : means all cells.

% Create empty ft_freqnalysis() output (also works for indexing/plotting
% purposes)
data_avg = ng_left{1,1}; % any works, since it will be emptied below
data_avg.powspctrm = [];
data_avg.trialinfo = [];
data_avg.cumtapcnt = [];
data_avg.cfg = [];

% % Plotting purposes (ROI)
% % Find foi index
% freqIdx = find(data_avg.freq >= 8 & data_avg.freq <= 14);
% minFreq = freqIdx(1,1);
% maxFreq = freqIdx(1,end);
% % Find toi index
% timeIdx = find(data_avg.time >= 0.2 & data_avg.time <= 1.5);
% minTime = timeIdx(1,1);
% maxTime = timeIdx(1,end);

% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% NG Left >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ng_left_avg = data_avg;
for i = 1:length(ng_left)
    ng_left_avg.powspctrm{i} = mean((ng_left{1,i}.powspctrm), 1);
    ng_left_avg.trialinfo{i} = ng_left{1,i}.trialinfo;
    ng_left_avg.cumtapcnt{i} = ng_left{1,i}.cumtapcnt;
    if i == length(ng_left)
        ng_left_avg.powspctrm = cat(1, ng_left_avg.powspctrm{1,:});
        ng_left_avg.trialinfo = cat(1, ng_left_avg.trialinfo{1,:});
        ng_left_avg.cumtapcnt = cat(1, ng_left_avg.cumtapcnt{1,:});
    end
end

% NG Right
ng_right_avg = data_avg;
for i = 1:length(ng_right)
    ng_right_avg.powspctrm{i} = mean((ng_right{1,i}.powspctrm), 1);
    ng_right_avg.trialinfo{i} = ng_right{1,i}.trialinfo;
    ng_right_avg.cumtapcnt{i} = ng_right{1,i}.cumtapcnt;
    if i == length(ng_right)
        ng_right_avg.powspctrm = cat(1, ng_right_avg.powspctrm{1,:});
        ng_right_avg.trialinfo = cat(1, ng_right_avg.trialinfo{1,:});
        ng_right_avg.cumtapcnt = cat(1, ng_right_avg.cumtapcnt{1,:});
    end
end

% NG Neutral
ng_neutral_avg = data_avg;
for i = 1:length(ng_neutral)
    ng_neutral_avg.powspctrm{i} = mean((ng_neutral{1,i}.powspctrm), 1);
    ng_neutral_avg.trialinfo{i} = ng_neutral{1,i}.trialinfo;
    ng_neutral_avg.cumtapcnt{i} = ng_neutral{1,i}.cumtapcnt;
    if i == length(ng_neutral)
        ng_neutral_avg.powspctrm = cat(1, ng_neutral_avg.powspctrm{1,:});
        ng_neutral_avg.trialinfo = cat(1, ng_neutral_avg.trialinfo{1,:});
        ng_neutral_avg.cumtapcnt = cat(1, ng_neutral_avg.cumtapcnt{1,:});
    end
end

% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% G Left >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
g_left_avg = data_avg;
for i = 1:length(g_left)
    g_left_avg.powspctrm{i} = mean((g_left{1,i}.powspctrm), 1);
    g_left_avg.trialinfo{i} = g_left{1,i}.trialinfo;
    g_left_avg.cumtapcnt{i} = g_left{1,i}.cumtapcnt;
    if i == length(g_left)
        g_left_avg.powspctrm = cat(1, g_left_avg.powspctrm{1,:});
        g_left_avg.trialinfo = cat(1, g_left_avg.trialinfo{1,:});
        g_left_avg.cumtapcnt = cat(1, g_left_avg.cumtapcnt{1,:});
    end
end

% NG Right
g_right_avg = data_avg;
for i = 1:length(g_right)
    g_right_avg.powspctrm{i} = mean((g_right{1,i}.powspctrm), 1);
    g_right_avg.trialinfo{i} = g_right{1,i}.trialinfo;
    g_right_avg.cumtapcnt{i} = g_right{1,i}.cumtapcnt;
    if i == length(g_right)
        g_right_avg.powspctrm = cat(1, g_right_avg.powspctrm{1,:});
        g_right_avg.trialinfo = cat(1, g_right_avg.trialinfo{1,:});
        g_right_avg.cumtapcnt = cat(1, g_right_avg.cumtapcnt{1,:});
    end
end

% NG Neutral
g_neutral_avg = data_avg;
for i = 1:length(g_neutral)
    g_neutral_avg.powspctrm{i} = mean((g_neutral{1,i}.powspctrm), 1);
    g_neutral_avg.trialinfo{i} = g_neutral{1,i}.trialinfo;
    g_neutral_avg.cumtapcnt{i} = g_neutral{1,i}.cumtapcnt;
    if i == length(g_neutral)
        g_neutral_avg.powspctrm = cat(1, g_neutral_avg.powspctrm{1,:});
        g_neutral_avg.trialinfo = cat(1, g_neutral_avg.trialinfo{1,:});
        g_neutral_avg.cumtapcnt = cat(1, g_neutral_avg.cumtapcnt{1,:});
    end
end

% Save averaged
save([filepath_out 'ng_left\ng_left_avg.mat'], 'ng_left_avg', '-v7.3');
save([filepath_out 'ng_right\ng_right_avg.mat'], 'ng_right_avg', '-v7.3');
save([filepath_out 'ng_neutral\neutral_avg.mat'], 'ng_neutral_avg', '-v7.3');
save([filepath_out 'g_left\g_left_avg.mat'], 'g_left_avg', '-v7.3');
save([filepath_out 'g_right\g_right_avg.mat'], 'g_right_avg', '-v7.3');
save([filepath_out 'g_neutral\g_neutral_avg.mat'], 'g_neutral_avg', '-v7.3');

%% Load

% load([filepath_out 'ng_left\ng_left_avg.mat']);
% load([filepath_out 'ng_right\ng_right_avg.mat']);
% load([filepath_out 'ng_neutral\neutral_avg.mat']);
% load([filepath_out 'g_left\g_left_avg.mat']);
% load([filepath_out 'g_right\g_right_avg.mat']);
% load([filepath_out 'g_neutral\g_neutral_avg.mat']);

%%
% %% Average Using ft_freqgrandaverage()
% 
% cfg = [];
% cfg.keepindividual = 'no';
% cfg.foilim = 'all';
% cfg.toilim = 'all';
% cfg.channel = 'all';
% cfg.parameter = 'powspctrm';
% 
% ng_left_avg = ft_freqgrandaverage(cfg, ng_left{1,1:end});
% ng_right_avg = ft_freqgrandaverage(cfg, ng_right{1,1:end});
% ng_neutral_avg = ft_freqgrandaverage(cfg, ng_neutral{1,1:end});
% 
% g_left_avg = ft_freqgrandaverage(cfg, g_left{1,1:end});
% g_right_avg = ft_freqgrandaverage(cfg, g_right{1,1:end});
% g_neutral_avg = ft_freqgrandaverage(cfg, g_neutral{1,1:end});
% 
% % Save averaged
% 
% save([filepath_out 'ng_left\ng_left_avg.mat'], 'ng_left_avg', '-v7.3');
% save([filepath_out 'ng_right\ng_right_avg.mat'], 'ng_right_avg', '-v7.3');
% save([filepath_out 'ng_neutral\neutral_avg.mat'], 'ng_neutral_avg', '-v7.3');
% save([filepath_out 'g_left\g_left_avg.mat'], 'g_left_avg', '-v7.3');
% save([filepath_out 'g_right\g_right_avg.mat'], 'g_right_avg', '-v7.3');
% save([filepath_out 'g_neutral\g_neutral_avg.mat'], 'g_neutral_avg', '-v7.3');


%% Test plot

% Channel OI
left_occ = {'P5', 'P3', 'P1', 'PO7', 'PO3', 'O1'};
right_occ = {'P6', 'P4', 'P2', 'PO8', 'PO4', 'O2'};
left_par = {'C5', 'C3', 'C1', 'CP5', 'CP3', 'CP1'};
right_par = {'C6', 'C4', 'C2', 'CP6', 'CP4', 'CP2'};
allCOI = {left_occ, right_occ, left_par, right_par};

cfg = [];

% cfg.layout = 'biosemi64.lay';

cfg.baseline = [-1 -0.2];
cfg.baselinetype = 'absolute';

cfg.colormap = '*RdBu';
cfg.colorbar = 'yes';

cfg.zlim = [-500 500];
cfg.xlim = [-1 1.5];
cfg.ylim = [5 30];

% TFR Plotting

for i = 1:length(allCOI)

    cfg.channel = allCOI{i};

    figure;
    ft_singleplotTFR(cfg, ng_left_avg); 

end




% cfg = [];
% cfg.method = 'mtmfft';
% cfg.output = 'pow';
% cfg.foi = [5:30];
% cfg.taper = 'boxcar';
% cfg.tapsmofrq = [2];
% cfg.channel = 'O2';
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
















