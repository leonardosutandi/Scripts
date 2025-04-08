%% S1_preprocessing

% triggers
original_label = [1:1:26];
relabel_list = {'NG', 'G', ... % 1, 2
                'cueLeft', 'cueRight', 'cueNuetral', ... % 3, 4, 5
                'loc1', 'loc2', 'loc3', 'loc4', 'loc5', 'loc6', 'loc7', 'loc8', ... % 6, 7, 8, 9, 10, 11, 12, 13
                'detResp', 'detCor', 'detIncor', ... % 14, 15, 16
                'loc1Acc', 'loc2Acc', 'loc3Acc', 'loc4Acc', 'loc5Acc', 'loc6Acc', 'loc7Acc', 'loc8Acc', ... % 17, 18, 19, 20, 21, 22, 23, 24
                'accCor', 'accIncor'}; % 25, 26

% trig_trialType = {'NG', 'G'};
% trig_cuePos = {'cueLeft', 'cueRight', 'cueNuetral'};
% trig_loc = {'loc1', 'loc2', 'loc3', 'loc4', 'loc5', 'loc6', 'loc7', 'loc8'};
% trig_detResp = {'detResp'};
% trig_detAcc = { 'detCor', 'detIncor'};
% trig_locResp = {'loc1Acc', 'loc2Acc', 'loc3Acc', 'loc4Acc', 'loc5Acc', 'loc6Acc', 'loc7Acc', 'loc8Acc'};
% trig_loccAcc = {'accCor', 'accIncor'};

trig_trialType = [1, 2]; % NG vs G
trig_cuePos = [3, 4, 5]; % LC vs RC vs NC
trig_loc = [6, 7, 8, 9, 10, 11, 12, 13]; % loc1:loc6
trig_detResp = [14]; % detResp
trig_detAcc = [15, 16]; % detCor vs detIncor
trig_locResp = [17, 18, 19, 20, 21, 22, 23, 24]; % acc1Resp:acc6Resp
trig_loccAcc = [25, 26]; % accCor vs accIncor

trigCat = {trig_trialType, trig_cuePos, trig_loc, trig_detResp, trig_detAcc, trig_locResp, trig_loccAcc};

% NG = trig_trialType(1);
% G = trig_trialType(2);

%% Triggers Setup

cfg = [];
cfg.dataset = filename;
cfg.trialdef.eventtype = 'STATUS';
cfg.trialdef.eventvalue = original_label;
cfg.trialdef.prestim = 5;
cfg.trialdef.poststim = 5;
cfg.trialdef.overlap = 0; % no overlap between snippets
cfg = ft_definetrial(cfg);

trl = cfg.trl;

% cfg = [];
% cfg.dataset = filename;
% cfg.trialfun = 'ft_trialfun_gui';
% cfg = ft_definetrial(cfg);

% cfg = [];
% cfg.headerfile = filename;
% cfg.datafile = filename;
% cfg.trialdef.eventtype = 'STATUS';
% cfg.trialdef.eventvalue = original_label;
% cfg = ft_definetrial(cfg);

%% Channel Location

cfg = [];
cfg.layout = 'biosemi64.lay';
cfg = ft_layoutplot(cfg);

cfg = [];
cfg.layout = 'shuffled_biosemi64.lay';
cfg = ft_layoutplot(cfg);

% probably can be later?

%% EOG
% NO NEED FOR BIOSEMI

% Horizontal
cfg = [];
% cfg.dataset = filename;
cfg.channel = {'EXG5', 'EXG6'};
cfg.reref = 'yes';
cfg.refchannel = 'EXG5';

eogH = ft_preprocessing(cfg);

eogH_label{2} = 'eogH'; %relabel

cfg = [];
cfg.channel = 'eogH';
eogH = ft_preprocessing(cfg, eogH); %just select


% Vertical Left
cfg = [];
% cfg.dataset = filename;
cfg.channel = {'EXG4', 'EXG8'};
cfg.reref = 'yes';
cfg.refchannel = 'EXG4';

eogVL = ft_preprocessing(cfg);

eogVL_label{2} = 'eogVL'; %relabel

cfg = [];
cfg.channel = 'eogVL';
eogVL = ft_preprocessing(cfg, eogVL); %just select


% Vertical Left
cfg = [];
% cfg.dataset = filename;
cfg.channel = {'EXG3', 'EXG7'};
cfg.reref = 'yes';
cfg.refchannel = 'EXG3';

eogVR = ft_preprocessing(cfg);

eogVR_label{2} = 'eogVR'; %relabel

cfg = [];
cfg.channel = 'eogVR';
eogVR = ft_preprocessing(cfg, eogVR); %just select

%% Combine 64, eogH, eogVL, eogVR

cfg = [];
data = ft_appenddata(cfg, data, eogH, eogVL, eogVR);
data_ica = ft_appenddata(cfg, data_ica, eogH, eogVL, eogVR);

%%
cfg = [];
cfg.dataset = filename;
cfg.trialdef.eventtype = '?';
dummy = ft_definetrial(cfg);

%% Andrew's filter
data_hp = data;
[filtA, filtB] = butter(3, [0.1]/(data_hp.fsample/2), 'high');
data_hp.trial{1} = filtfilt(filtA,filtB, data_hp.trial{1}')';


%% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% S5_tfr >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% Computing TFRs (1st Attempt)

% % Set TFR parameters
% cfg = [];
% 
% cfg.method = 'wavelet';
% cfg.width = 5;
% 
% cfg.foilim = compute_alpha;
% cfg.toi = compute_time;
% 
% cfg.output = 'pow';
% 
% cfg.keeptrials = 'yes';
% 
% % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% 
% % NG Left
% % Left Parietal
% cfg.channel = left_par;
% cfg.trials = find(data.trialinfo(:,1) == 13);
% ng_left_left_par = ft_freqanalysis(cfg, data);
% 
% % Right Parietal
% cfg.channel = right_par;
% cfg.trials = find(data.trialinfo(:,1) == 13);
% ng_left_right_par = ft_freqanalysis(cfg, data);
% 
% % Left Occipital
% cfg.channel = left_occ;
% cfg.trials = find(data.trialinfo(:,1) == 13);
% ng_left_left_occ = ft_freqanalysis(cfg, data);
% 
% % Right Occipital
% cfg.channel = rigth_occ;
% cfg.trials = find(data.trialinfo(:,1) == 13);
% ng_left_right_occ = ft_freqanalysis(cfg, data);
% 
% ng_left = [ng_left_left_par, ng_left_right_par, ng_left_left_occ, ng_left_right_occ];
% save([filepath 'ng_left.mat'], 'ng_left', '-v7.3');
% 
% % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% 
% % NG Right
% % Left Parietal
% cfg.channel = left_par;
% cfg.trials = find(data.trialinfo(:,1) == 14);
% ng_right_left_par = ft_freqanalysis(cfg, data);
% 
% % Right Parietal
% cfg.channel = right_par;
% cfg.trials = find(data.trialinfo(:,1) == 14);
% ng_right_right_par = ft_freqanalysis(cfg, data);
% 
% % Left Occipital
% cfg.channel = left_occ;
% cfg.trials = find(data.trialinfo(:,1) == 14);
% ng_right_left_occ = ft_freqanalysis(cfg, data);
% 
% % Right Occipital
% cfg.channel = right_occ;
% cfg.trials = find(data.trialinfo(:,1) == 14);
% ng_right_right_occ = ft_freqanalysis(cfg, data);
% 
% ng_right = [ng_right_left_par, ng_right_right_par, ng_right_left_occ, ng_right_right_occ];
% save([filepath 'ng_right.mat'], 'ng_right', '-v7.3');
% 
% % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% 
% % NG Neutral
% % Left Parietal
% cfg.channel = left_par;
% cfg.trials = find(data.trialinfo(:,1) == 15);
% ng_neutral_left_par = ft_freqanalysis(cfg, data);
% 
% % Right Parietal
% cfg.channel = right_par;
% cfg.trials = find(data.trialinfo(:,1) == 15);
% ng_neutral_right_par = ft_freqanalysis(cfg, data);
% 
% % Left Occipital
% cfg.channel = left_occ;
% cfg.trials = find(data.trialinfo(:,1) == 15);
% ng_neutral_left_occ = ft_freqanalysis(cfg, data);
% 
% % Right Occipital
% cfg.channel = right_occ;
% cfg.trials = find(data.trialinfo(:,1) == 15);
% ng_neutral_right_occ = ft_freqanalysis(cfg, data);
% 
% ng_neutral = [ng_neutral_left_par, ng_neutral_right_par, ng_neutral_left_occ, ng_neutral_right_occ];
% save([filepath 'ng_neutral.mat'], 'ng_neutral', '-v7.3');
% 
% % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% 
% % G Left
% % Left Parietal
% cfg.channel = left_par;
% cfg.trials = find(data.trialinfo(:,1) == 23);
% g_left_left_par = ft_freqanalysis(cfg, data);
% 
% % Right Parietal
% cfg.channel = right_par;
% cfg.trials = find(data.trialinfo(:,1) == 23);
% g_left_right_par = ft_freqanalysis(cfg, data);
% 
% % Left Occipital
% cfg.channel = left_occ;
% cfg.trials = find(data.trialinfo(:,1) == 23);
% g_left_left_occ = ft_freqanalysis(cfg, data);
% 
% % Right Occipital
% cfg.channel = right_occ;
% cfg.trials = find(data.trialinfo(:,1) == 23);
% g_left_right_occ = ft_freqanalysis(cfg, data);
% 
% g_left = [g_left_left_par, g_left_right_par, g_left_left_occ, g_left_right_occ];
% save([filepath 'g_left.mat'], 'g_left', '-v7.3');
% 
% % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% 
% % G Right
% % Left Parietal
% cfg.channel = left_par;
% cfg.trials = find(data.trialinfo(:,1) == 24);
% g_right_left_par = ft_freqanalysis(cfg, data);
% 
% % Right Parietal
% cfg.channel = right_par;
% cfg.trials = find(data.trialinfo(:,1) == 24);
% g_right_right_par = ft_freqanalysis(cfg, data);
% 
% % Left Occipital
% cfg.channel = left_occ;
% cfg.trials = find(data.trialinfo(:,1) == 24);
% g_right_left_occ = ft_freqanalysis(cfg, data);
% 
% % Right Occipital
% cfg.channel = right_occ;
% cfg.trials = find(data.trialinfo(:,1) == 24);
% g_right_right_occ = ft_freqanalysis(cfg, data);
% 
% g_right = [g_right_left_par, g_right_right_par, g_right_left_occ, g_right_right_occ];
% save([filepath 'g_right.mat'], 'g_right', '-v7.3');
% 
% % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% 
% % G Neutral
% % Left Parietal
% cfg.channel = left_par;
% cfg.trials = find(data.trialinfo(:,1) == 25);
% g_neutral_left_par = ft_freqanalysis(cfg, data);
% 
% % Right Parietal
% cfg.channel = right_par;
% cfg.trials = find(data.trialinfo(:,1) == 25);
% g_neutral_right_par = ft_freqanalysis(cfg, data);
% 
% % Left Occipital
% cfg.channel = left_occ;
% cfg.trials = find(data.trialinfo(:,1) == 25);
% g_neutral_left_occ = ft_freqanalysis(cfg, data);
% 
% % Right Occipital
% cfg.channel = right_occ;
% cfg.trials = find(data.trialinfo(:,1) == 25);
% g_neutral_right_occ = ft_freqanalysis(cfg, data);
% 
% g_neutral = [g_neutral_left_par, g_neutral_right_par, g_neutral_left_occ, g_neutral_right_occ];
% save([filepath 'g_neutral.mat'], 'g_neutral', '-v7.3');

%% Average
% % Unlike the one used in S5_tfr
% ng_left_avg = ng_left{1,1};
% ng_left_avg.powspctrm = [];
% % calculate mean
% for i = 1:length(ng_left)
%     avg{1,i} = mean((ng_left{1,i}.powspctrm),1); %= average by trial
%     if i == length(ng_left)
%         for j = 1:length(avg)
%             % ng_left_avg.powspctrm = mean((avg{j}.powspctrm),1);
%             ng_left_avg.powspctrm{j} = avg{j}.powspctrm;
%         end
%         ng_left_avg.powspctrm = cat(1, ng_left_avg.powspctrm{1,:});
%     end
% end

%% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% S5_tfr >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% AVERAGING SHOULD HAVE USED THIS INSTEAD (cfg.keeptrials = 'no'):

cfg = [];
cfg.keepindividual = 'no';
cfg.foilim = 'all';
cfg.toilim = 'all';
cfg.channel = 'all';
cfg.parameter = 'powspctrm';

ng_left_AVG = ft_freqgrandaverage(cfg, ng_left{1,1:numel(ng_left)});

% IF NOT (cfg.keeptrials = 'yes'):

% Average Manually

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

% Plotting purposes (ROI)
% Find foi index
freqIdx = find(data_avg.freq >= 8 & data_avg.freq <= 14);
minFreq = freqIdx(1,1);
maxFreq = freqIdx(1,end);
% Find toi index
timeIdx = find(data_avg.time >= 0.2 & data_avg.time <= 1.5);
minTime = timeIdx(1,1);
maxTime = timeIdx(1,end);

% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% NG Left >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ng_left_avg = data_avg;
for i = 1:length(ng_left)
    ng_left_avg.powspctrm{i} = ng_left{1,i}.powspctrm;
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
    ng_right_avg.powspctrm{i} = ng_right{1,i}.powspctrm;
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
    ng_neutral_avg.powspctrm{i} = ng_neutral{1,i}.powspctrm;
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
    g_left_avg.powspctrm{i} = g_left{1,i}.powspctrm;
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
    g_right_avg.powspctrm{i} = g_right{1,i}.powspctrm;
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
    g_neutral_avg.powspctrm{i} = g_neutral{1,i}.powspctrm;
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











