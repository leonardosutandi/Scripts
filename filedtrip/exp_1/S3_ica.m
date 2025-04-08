%% Participant information

group = 'C';
participantNum = '19';

filepath = ['C:\MATLAB\exp_1\results\EEG\' group '\participant_' participantNum '\']; % C for local, F for pav_SSD, D for Zbook_SSD

% Load Data Sets

load([filepath 's2_rbd_done.mat']);
load([filepath 's2_rbd_ica_done.mat']);

%% ICA Decomp

cfg = [];
cfg.channel = {'all'};
cfg.method = 'runica';
comp = ft_componentanalysis(cfg, data_ica);

save([filepath 'comp.mat'], 'comp', '-v7.3');

%% Load ICA (if needed)

load([filepath 'comp.mat']);

%% Comp Power plot
 
cfg = [];
cfg.layout = 'biosemi64.lay';
cfg.powscale = 'lin';
cfg.colormap = 'jet';
ft_icabrowser(cfg, comp);

%% Identifying artifactual components (FROM POWPLOT)

potBad = [2 4 14 16 18 19 22 25 27 28 33 34 37 48 49 50 62];

%%
cfg = [];
cfg.component = potBad;
cfg.marker = 'off';
cfg.layout = 'biosemi64.lay';
cfg.comment = 'no';
cfg.colormap = 'jet';
figure(1); ft_topoplotIC(cfg, comp);

cfg = [];
cfg.layout = 'biosemi64.lay';
cfg.viewmode = 'component';
cfg.continuous = 'yes';
cfg.blocksize = [10];
cfg.channel = potBad;
cfg.ylim = [-5 5];
cfg.colormap = 'jet';
ft_databrowser(cfg, comp);

%% Identifying artifactual components (CHECK UNTAGGED ONLY)

icBatch = {[1:20], [21:40], [41:60], [61:size(comp.label,1)]};
batch = icBatch{4};

batch = batch(~ismember(batch, potBad));

% cfg = [];
% cfg.component = batch;
% cfg.marker = 'off';
% cfg.layout = 'biosemi64.lay';
% cfg.comment = 'no';
% cfg.colormap = 'jet';
% figure(1); ft_topoplotIC(cfg, comp);

cfg = [];
cfg.layout = 'biosemi64.lay';
cfg.viewmode = 'component';
cfg.continuous = 'yes';
cfg.blocksize = [10];
cfg.channel = batch;
cfg.ylim = [-5 5];
cfg.colormap = 'jet';
ft_databrowser(cfg, comp);

%% Identifying artifactual components (FULL BATCH)

% % Potential bad ic comps
% icBatch = {[1:20], [21:40], [41:60], [61:size(comp.label,1)]};
% batch = icBatch{1};
% 
% cfg = [];
% cfg.component = batch;
% cfg.marker = 'off';
% cfg.layout = 'biosemi64.lay';
% cfg.comment = 'no';
% cfg.colormap = 'jet';
% figure(1); ft_topoplotIC(cfg, comp);
% 
% cfg = [];
% cfg.layout = 'biosemi64.lay';
% cfg.viewmode = 'component';
% cfg.continuous = 'yes';
% cfg.blocksize = [10];
% cfg.channel = batch;
% cfg.ylim = [-5 5];
% cfg.colormap = 'jet';
% figure(2); ft_databrowser(cfg, comp);

%% Tag bad components

% To be removed IC components
ic_comp = potBad;
% Save
save([filepath 'ic_comp.mat'], 'ic_comp', '-v7.3');

%% Load Bad Components (if needed)

load([filepath 'ic_comp.mat']);

%% Remove Bad Components from Main Data Set

cfg = [];
cfg.component = ic_comp;
data = ft_rejectcomponent(cfg, comp, data);

%% Save Data Set
save([filepath 's3_ica_done.mat'], 'data', '-v7.3');

clear; clc


























