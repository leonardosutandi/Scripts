%% Load Data Sets

% Choose group to compute
group = 'M';

% Load

filepath_out = ['C:\MATLAB\exp_1\results\EEG\conditions\' group '\']; % C for local, F for pav_SSD, D for Zbook_SSD

% Data sets containing averages
load([filepath_out 'ng_left\ng_left_avg.mat']);
load([filepath_out 'ng_right\ng_right_avg.mat']);
load([filepath_out 'ng_neutral\neutral_avg.mat']);
load([filepath_out 'g_left\g_left_avg.mat']);
load([filepath_out 'g_right\g_right_avg.mat']);
load([filepath_out 'g_neutral\g_neutral_avg.mat']);

% % Data sets containing participants (most likely not needed)
% load([filepath_out 'indiv\ng_left.mat']);
% load([filepath_out 'indiv\ng_right.mat']);
% load([filepath_out 'indiv\ng_neutral.mat']);
% load([filepath_out 'indiv\g_left.mat']);
% load([filepath_out 'indiv\g_right.mat']);
% load([filepath_out 'indiv\g_neutral.mat']);

% Conditions

condition_list = {ng_left_avg, ng_right_avg, ng_neutral_avg, g_left_avg, g_right_avg, g_neutral_avg};
cond_str = {'ng_left', 'ng_right', 'ng_neutral', 'g_left', 'g_right', 'g_neutral'};

%% -----------------------------------------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Set Parameters >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TFR Params
conIdx = 4;
san = 'yes'; % Spatial against neutral contrast
baseline = [-1 -0.2]; % 'no' if san = 'yes'
baselineType = 'absolute';
scale = [-250 50]; % 'maxmin'
data = condition_list{conIdx};
cond = cond_str{conIdx};
san_cond = cond_str{conIdx};
tfr_time = [-1 1.5];
tfr_freq = [5 30];

% Topoplot params
ami = 'no'; % AMI (if yes, topo nly)
conAMI = 'G';
colours = {'y', 'g', 'c', 'm'};
symbol = {'.', '.', '.', '.'};
markSize = {25, 25, 25, 25};
topo_scale = scale;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Additional Params

% Different filepath if spatial against neutral contrast
if isequal(san, 'yes')
    fp2 = '\san\';
elseif isequal(san, 'no')
    fp2 = '\';
end

if isequal(ami, 'yes')
    topo_scale = [-0.07 0.07];
end

% Channel OI
left_occ = {'P5', 'P3', 'P1', 'PO7', 'PO3', 'O1'};
right_occ = {'P6', 'P4', 'P2', 'PO8', 'PO4', 'O2'};
left_par = {'C5', 'C3', 'C1', 'CP5', 'CP3', 'CP1'};
right_par = {'C6', 'C4', 'C2', 'CP6', 'CP4', 'CP2'};
allCOI = {left_occ, right_occ, left_par, right_par};

% TFR plotting titles
title = {"Left Occipital", "Right Occipital", "Left Parietal", "Right Parietal"};

% Topo plotting title
if isequal(cond, cond_str{1})
    topo_title = "NG Left";
elseif isequal(cond, cond_str{2})
    topo_title = "NG Right";
elseif isequal(cond, cond_str{3})
    topo_title = "NG Neutral";
elseif isequal(cond, cond_str{4})
    topo_title = "G Left";
elseif isequal(cond, cond_str{5})
    topo_title = "G Right";
elseif isequal(cond, cond_str{6})
    topo_title = "G Neutral";
end

%% Spatial Against Neutral - TFR

if isequal(san, 'yes')

    baseline = 'no';

    data_san = data;
    data_san.powspctrm = [];
    data_san.trialinfo = [];
    data_san.cumtapcnt = [];
    data_san.cfg = [];

    if isequal(san_cond, 'ng_left')
        % data_san.powspctrm = mean(ng_left_avg.powspctrm, 1) - mean(ng_neutral_avg.powspctrm, 1);
        data_san.powspctrm = ng_left_avg.powspctrm - ng_neutral_avg.powspctrm;
    elseif isequal(san_cond, 'ng_right')
        % data_san.powspctrm = mean(ng_right_avg.powspctrm, 1) - mean(ng_neutral_avg.powspctrm, 1);
        data_san.powspctrm = ng_right_avg.powspctrm - ng_neutral_avg.powspctrm;
    elseif isequal(san_cond, 'g_left')
        % data_san.powspctrm = mean(g_left_avg.powspctrm, 1) - mean(g_neutral_avg.powspctrm, 1);
        data_san.powspctrm = g_left_avg.powspctrm - g_neutral_avg.powspctrm;
    elseif isequal(san_cond, 'g_right')
        % data_san.powspctrm = mean(g_right_avg.powspctrm, 1) - mean(g_neutral_avg.powspctrm, 1);
        data_san.powspctrm = g_right_avg.powspctrm - g_neutral_avg.powspctrm;
    end
    
    data = data_san;

end

%% Find indexes

% Create empty data output for indexing/plotting purposes
index = data; % any works, since it will be emptied below
index.powspctrm = [];
index.trialinfo = [];
index.cumtapcnt = [];
index.cfg = [];

% Plotting purposes (ROI)
% Find foi index
freqIdx = find(index.freq >= 8 & index.freq <= 14);
minFreq = freqIdx(1,1);
maxFreq = freqIdx(1,end);
% Find toi index
timeIdx = find(index.time >= 0.2 & index.time <= 1.5);
minTime = timeIdx(1,1);
maxTime = timeIdx(1,end);

%% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% SingleTFRs Plotting Parameters (Averaged) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

if isequal(ami, 'no')

    cfg = [];
    
    % cfg.layout = 'biosemi64.lay';
    
    cfg.baseline = baseline;
    cfg.baselinetype = baselineType;
    
    cfg.colormap = '*RdBu';
    cfg.colorbar = 'yes';
    
    cfg.zlim = scale;
    cfg.xlim = tfr_time;
    cfg.ylim = tfr_freq;
    
    % TFR Plotting
    
    for i = 1:length(allCOI)
    
        cfg.channel = allCOI{i};
        cfg.title = title{i};
    
        figure;
        ft_singleplotTFR(cfg, data); 
    
        hold on
        % Plot y axis line (t = 0)
        plot([[index.time(1)-index.time(1)] [index.time(1)-index.time(1)]], [[index.freq(13)] [index.freq(end)]], ':', 'linewidth', 1.2, 'color', 'k');
        
        % Match colour to COI
        if isequal(allCOI{i}, left_occ)
            col = 'y';
        elseif isequal(allCOI{i}, right_occ)
            col = 'g';
        elseif isequal(allCOI{i}, left_par)
            col = 'c';
        elseif isequal(allCOI{i}, right_par)
            col = 'm';
        end
    
        % Plot ROI
        plot([index.time(minTime) index.time(maxTime)], [index.freq(minFreq) index.freq(minFreq)], '--', 'linewidth', 2, 'color', col); % bottom
        plot([index.time(minTime) index.time(maxTime)], [index.freq(maxFreq) index.freq(maxFreq)], '--', 'linewidth', 2, 'color', col); % top
        plot([index.time(minTime) index.time(minTime)], [index.freq(minFreq) index.freq(maxFreq)], '--', 'linewidth', 2, 'color', col); % left
        plot([index.time(maxTime) index.time(maxTime)], [index.freq(minFreq) index.freq(maxFreq)], '--', 'linewidth', 2, 'color', col); % right
        hold off
    
        % Save Plots
        % NG Left
        if isequal(cond, 'ng_left')
        
            if isequal(allCOI{i}, left_occ)
                saveas(gca, fullfile(filepath_out, ['ng_left' fp2 'ng_left_avg_left_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_occ)
                saveas(gca, fullfile(filepath_out, ['ng_left' fp2 'ng_left_avg_right_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, left_par)
                saveas(gca, fullfile(filepath_out, ['ng_left' fp2 'ng_left_avg_left_par.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_par)
                saveas(gca, fullfile(filepath_out, ['ng_left' fp2 'ng_left_avg_right_par.jpg']), 'jpg');
            end
        
        end
        
        % NG Right
        if isequal(cond, 'ng_right')
        
            if isequal(allCOI{i}, left_occ)
                saveas(gca, fullfile(filepath_out, ['ng_right' fp2 'ng_right_avg_left_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_occ)
                saveas(gca, fullfile(filepath_out, ['ng_right' fp2 'ng_right_avg_right_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, left_par)
                saveas(gca, fullfile(filepath_out, ['ng_right' fp2 'ng_right_avg_left_par.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_par)
                saveas(gca, fullfile(filepath_out, ['ng_right' fp2 'ng_right_avg_right_par.jpg']), 'jpg');
            end
        
        end
        
        % NG Neutral
        if isequal(cond, 'ng_neutral')
        
            if isequal(allCOI{i}, left_occ)
                saveas(gca, fullfile(filepath_out, ['ng_neutral' fp2 'ng_neutral_avg_left_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_occ)
                saveas(gca, fullfile(filepath_out, ['ng_neutral' fp2 'ng_neutral_avg_right_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, left_par)
                saveas(gca, fullfile(filepath_out, ['ng_neutral' fp2 'ng_neutral_avg_left_par.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_par)
                saveas(gca, fullfile(filepath_out, ['ng_neutral' fp2 'ng_neutral_avg_right_par.jpg']), 'jpg');
            end
        
        end
        
        % G Left
        if isequal(cond, 'g_left')
        
            if isequal(allCOI{i}, left_occ)
                saveas(gca, fullfile(filepath_out, ['g_left' fp2 'g_left_avg_left_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_occ)
                saveas(gca, fullfile(filepath_out, ['g_left' fp2 'g_left_avg_right_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, left_par)
                saveas(gca, fullfile(filepath_out, ['g_left' fp2 'g_left_avg_left_par.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_par)
                saveas(gca, fullfile(filepath_out, ['g_left' fp2 'g_left_avg_right_par.jpg']), 'jpg');
            end
        
        end
        
        % G Right
        if isequal(cond, 'g_right')
        
            if isequal(allCOI{i}, left_occ)
                saveas(gca, fullfile(filepath_out, ['g_right' fp2 'g_right_avg_left_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_occ)
                saveas(gca, fullfile(filepath_out, ['g_right' fp2 'g_right_avg_right_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, left_par)
                saveas(gca, fullfile(filepath_out, ['g_right' fp2 'g_right_avg_left_par.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_par)
                saveas(gca, fullfile(filepath_out, ['g_right' fp2 'g_right_avg_right_par.jpg']), 'jpg');
            end
        
        end
        
        % G Neutral
        if isequal(cond, 'g_neutral')
        
            if isequal(allCOI{i}, left_occ)
                saveas(gca, fullfile(filepath_out, ['g_neutral' fp2 'g_neutral_avg_left_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_occ)
                saveas(gca, fullfile(filepath_out, ['g_neutral' fp2 'g_neutral_avg_right_occ.jpg']), 'jpg');
            elseif isequal(allCOI{i}, left_par)
                saveas(gca, fullfile(filepath_out, ['g_neutral' fp2 'g_neutral_avg_left_par.jpg']), 'jpg');
            elseif isequal(allCOI{i}, right_par)
                saveas(gca, fullfile(filepath_out, ['g_neutral' fp2 'g_neutral_avg_right_par.jpg']), 'jpg');
            end
        
        end
    
    end
end

%% AMI - Topoplot >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

if isequal(ami, 'yes')

    baseline = 'no';

    topo_title = 'AMI';

    data_ami = data;
    data_ami.powspctrm = [];
    data_ami.trialinfo = [];
    data_ami.cumtapcnt = [];
    data_ami.cfg = [];
    
    if isequal(conAMI, 'NG')
        data_ami.powspctrm = (mean(ng_left_avg.powspctrm, 1) - mean(ng_right_avg.powspctrm, 1)) ./ (mean(ng_left_avg.powspctrm, 1) + mean(ng_right_avg.powspctrm, 1));
    elseif isequal(conAMI, 'G')
        data_ami.powspctrm = (mean(g_left_avg.powspctrm, 1) - mean(g_right_avg.powspctrm, 1)) ./ (mean(g_left_avg.powspctrm, 1) + mean(g_right_avg.powspctrm, 1));
    end
    
    data = data_ami;

end

%% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% Topoplot Plotting >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

cfg = [];

cfg.layout = 'biosemi64.lay';
cfg.marker = 'on';

cfg.baseline = baseline;
cfg.baselinetype = 'absolute';

cfg.colormap = '*RdBu';
cfg.colorbar = 'yes';
cfg.zlim = topo_scale;
cfg.xlim = [index.time(minTime) index.time(maxTime)];
cfg.ylim = [index.freq(minFreq) index.freq(maxFreq)];

cfg.highlight = 'on';
cfg.highlightchannel = allCOI;
cfg.highlightcolor = colours;
cfg.highlightsymbol = symbol;
cfg.highlightsize = markSize;

cfg.title = topo_title;

ft_topoplotTFR(cfg, data);

% save figure
if strcmp(ami, 'no')
    if isequal(cond, cond_str{1})
        saveas(gca, fullfile(filepath_out, ['ng_left' fp2 'ng_left_avg_topo.jpg']), 'jpg');
    elseif isequal(cond, cond_str{2})
        saveas(gca, fullfile(filepath_out, ['ng_right' fp2 'ng_right_avg_topo.jpg']), 'jpg');
    elseif isequal(cond, cond_str{3})
        saveas(gca, fullfile(filepath_out, ['ng_neutral' fp2 'ng_neutral_avg_topo.jpg']), 'jpg');
    elseif isequal(cond, cond_str{4})
        saveas(gca, fullfile(filepath_out, ['g_left' fp2 'g_left_avg_topo.jpg']), 'jpg');
    elseif isequal(cond, cond_str{5})
        saveas(gca, fullfile(filepath_out, ['g_right' fp2 'g_right_avg_topo.jpg']), 'jpg');
    elseif isequal(cond, cond_str{6})
        saveas(gca, fullfile(filepath_out, ['g_neutral' fp2 'g_neutral_avg_topo.jpg']), 'jpg');
    end
end

if strcmp (ami, 'yes') & isequal(conAMI, 'NG')
    saveas(gca, fullfile(filepath_out, 'ami\ng_ami.jpg'), 'jpg');
elseif strcmp (ami, 'yes') & isequal(conAMI, 'G')
    saveas(gca, fullfile(filepath_out, 'ami\g_ami.jpg'), 'jpg');
end
















