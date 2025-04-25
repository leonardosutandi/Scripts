%% Participant information
clear; clc;
% _______________________________________________________________________________________
% _______________________________________________________________________________________
group = 'MA';
participantNum = '';
% _______________________________________________________________________________________
% _______________________________________________________________________________________

filepath = ['C:\MATLAB\exp_1\results\EEG\' group '\participant_' participantNum '\']; % C for local, F for pav_SSD, D for Zbook_SSD

% Load Data Set
load([filepath 's3_ica_done.mat']);

% Channels OI
left_occ = {'P5', 'P3', 'P1', 'PO7', 'PO3', 'O1'};
right_occ = {'P6', 'P4', 'P2', 'PO8', 'PO4', 'O2'};
left_par = {'C5', 'C3', 'C1', 'CP5', 'CP3', 'CP1'};
right_par = {'C6', 'C4', 'C2', 'CP6', 'CP4', 'CP2'};

allCOI = [left_occ, right_occ, left_par, right_par];

% Exclude non-EEG Channels
cfg = [];
cfg.channel = {'all', '-EXG1', '-EXG2', '-EXG3', '-EXG4', '-EXG5', '-EXG6', '-EXG7', '-EXG8'};
data = ft_preprocessing(cfg, data);

%% Look for bad epoch(s)

% Check & manually tag any poor epoch to exclude via ft_databrowser()
cfg = [];
cfg.channel = allCOI; % Just view/need clean COIs
cfg.ylim = [-30 30];
ft_databrowser(cfg, data);

%% Tag bad epoch(s)
% (-) out ow TW; (~) negligible in TW
% Tag bad epochs (i.e. still not clean OR with zeros)
eeg_out = [274 311 347 399 475]; % have bad, - and ~ (use this removes EVERY zero)
save([filepath 'eeg_out_allbad.mat'], 'eeg_out', '-v7.3');
eeg_out = [274 347 399 475]; % have bad and ~ (use this removes only bad and ~, - left alone)
save([filepath 'eeg_out_bad-neg.mat'], 'eeg_out', '-v7.3');
eeg_out = [274 399 475]; % have only bad (use this removes only bad epochs, - ~ left alone)
save([filepath 'eeg_out.mat'], 'eeg_out', '-v7.3');

%% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< STOP >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% Actual removal of bad epochs here

% NOTE: make sure BEH1 in R is done for this participant before running this chunk!

% Before removing epoch, make sure tagged epoch (via behavioural data
% exclusion) is also removed in this chunck. 

load([filepath 'eeg_out.mat']); % Load bad epochs via eeg preprocessing (i.e. chunk above)
load([filepath 'beh_out.mat']); beh_out = beh_out';% load r_out; bad epochs via beh processing (i.e. from r)

bad_epochs = union(eeg_out, beh_out);
all_trials = [1:1:size(data.trial, 2)];

keep_trials = all_trials(~ismember(all_trials, bad_epochs));

cfg = [];
cfg.trials = keep_trials; % trials out here
data = ft_preprocessing(cfg, data);

% Check how many epochs left
num_ng_left = size(find(data.trialinfo(:,1) == 13), 1);
num_ng_right = size(find(data.trialinfo(:,1) == 14), 1);
num_ng_neutral = size(find(data.trialinfo(:,1) == 15), 1);

num_g_left = size(find(data.trialinfo(:,1) == 23), 1);
num_g_right = size(find(data.trialinfo(:,1) == 24), 1);
num_g_neutral = size(find(data.trialinfo(:,1) == 25), 1);

%% Interpolate missing channel(s)

% Reload (if needed)
load([filepath 'bad_channels.mat']);

% Prepare neighbours
cfg = [];
cfg.method = 'triangulation';
cfg.layout = 'biosemi64.lay';
neighbours = ft_prepare_neighbours(cfg);

% Repair/interpolate bad channel(s) on the spot
cfg = [];
cfg.method = 'average'; % 'weighted', 'spline', 'slap' or 'nan'
cfg.missingchannel = bad_channels;
cfg.neighbours = neighbours;
cfg.trials = 'all';

data = ft_channelrepair(cfg, data);

%% Reorder channel order after interpolation

% This chunk makes sure interpolarted channels(s), i.e. channel label(s) 
% in data.label and it's corresponding data in data.trial, which falls to 
% the bottom of the list returns to it's original position. This allows all 
% participants with or without interpolated channels to have the same 
% location of channels in the matrix - Important for averaging.

% Load original label order
load([filepath 'ori_label.mat']);

% Get mismatched order
[LIA ori_order] = ismember(ori_label, data.label);

% reorder data.trial
for i = 1:length(data.trial)
    data.trial{1,i} = data.trial{1,i}(ori_order,:);
end

% reorder data.label
data.label = data.label(ori_order);

%% Save Data Set
save([filepath 's4_epoch_done.mat'], 'data', '-v7.3');

clear; clc;
disp("Step 4 Remove Bad Epoch: DONE")































