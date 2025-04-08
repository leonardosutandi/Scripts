function [trl, event] = ft_trialfun_G_trial(cfg)

% FT_TRIALFUN_G_TRIAL is a trial function searching for events
% of type "STATUS" and specifically for a trigger with value 1 (gratings condition),
% followed by a spatial cue onset/trigger with value 3/4/5.

% Use this function by calling
%   [cfg] = ft_definetrial(cfg)
% where the configuration structure should contain
%   cfg.dataset           = string with the filename
%   cfg.trialfun          = 'ft_trialfun_NG_trial'
%   cfg.trialdef.prestim  = number, in seconds
%   cfg.trialdef.poststim = number, in seconds
%
% modifed from ft_trialfun_example1 to fit this preprocessing; 
% Copyright (C) 2005-2024, Robert Oostenveld 

trig_trialType = [1, 2]; % NG vs G
trig_cuePos = [3, 4, 5]; % LC vs RC vs NC
trig_loc = [6, 7, 8, 9, 10, 11, 12, 13]; % loc1:loc6
% trig_detResp = [14]; % detResp
% trig_detAcc = [15, 16]; % detCor vs detIncor
% trig_locResp = [17, 18, 19, 20, 21, 22, 23, 24]; % acc1Resp:acc6Resp
% trig_loccAcc = [25, 26]; % accCor vs accIncor

% read the header information and the events from the data
hdr   = ft_read_header(cfg.dataset);
event = ft_read_event(cfg.dataset);

% search for "STATUS" events
value  = [event(find(strcmp('STATUS', {event.type}))).value]';
sample = [event(find(strcmp('STATUS', {event.type}))).sample]';

% determine the number of samples before and after the trigger
prestim  = -round(cfg.trialdef.prestim  * hdr.Fs);
poststim =  round(cfg.trialdef.poststim * hdr.Fs);

% look for the combination of a trigger "1" followed by trigger "3/4/5" and
% trigger "6/7/8/9/10/11/12/13"
% for each trigger except the last one
trl = [];
for j = 1:(length(value)-2)
  trig1 = value(j);
  trig2 = value(j+1);
  trig3 = value(j+2);
  if trig1 == trig_trialType(2) && ismember(trig2, trig_cuePos) && ismember(trig3, trig_loc)
    trlbegin = sample(j) + prestim;
    trlend   = sample(j) + poststim;
    offset   = prestim;
    newtrl   = [trlbegin trlend offset];
    trl      = [trl; newtrl];
  end
end