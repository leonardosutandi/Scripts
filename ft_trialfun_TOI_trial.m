function [trl, event] = ft_trialfun_TOI_trial(cfg)

% FT_TRIALFUN_TOI_TRIAL is a trial function searching for events
% of type "STATUS" and specifically for a trigger with value 1/2 (trialType),
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
% trig_loc = [6, 7, 8, 9, 10, 11, 12, 13]; % loc1:loc6

% read the header information and the events from the data
hdr   = ft_read_header(cfg.dataset);
event = ft_read_event(cfg.dataset);

% search for "STATUS" events
value  = [event(find(strcmp('STATUS', {event.type}))).value]';
sample = [event(find(strcmp('STATUS', {event.type}))).sample]';

% determine the number of samples before and after the trigger
prestim  = -round(cfg.trialdef.prestim  * hdr.Fs);
poststim =  round(cfg.trialdef.poststim * hdr.Fs);

% look for the combination of a trigger "1/2" followed by cuePos "3/4/5"
% for each trigger except the last one
% trl = [];
% for j = 1:(length(value)-1)
%   trig1 = value(j);
%   trig2 = value(j+1);
%   if ismember(trig1, trig_trialType) && ismember(trig2, trig_cuePos)
%     trlbegin = sample(j) + prestim;
%     trlend   = sample(j) + poststim;
%     offset   = prestim;
%     newtrl   = [trlbegin trlend offset];
%     trl      = [trl; newtrl];
%   end
% end

% trl = [];
% for j = 2:(length(value)-1)
%   event1 = value(j);
%   event2 = value(j-1);
%   if ismember(event1, trig_cuePos) && ismember(event2, trig_trialType)
%     trlbegin = sample(j) + prestim;
%     trlend   = sample(j) + poststim;
%     offset   = prestim;
%     newtrl   = [trlbegin trlend offset];
%     trl      = [trl; newtrl];
%   end
% end

trl = [];
for j = 2:(length(value)-1)
  event1 = value(j);
  event2 = value(j-1);
  if ismember(event1, trig_cuePos(1)) && ismember(event2, trig_trialType(1))
    trlbegin = sample(j) + prestim;
    trlend   = sample(j) + poststim;
    offset   = prestim;
    newtrl   = [trlbegin trlend offset];
    cond     = 13;
    trl      = [trl; newtrl cond];
  elseif ismember(event1, trig_cuePos(2)) && ismember(event2, trig_trialType(1))
    trlbegin = sample(j) + prestim;
    trlend   = sample(j) + poststim;
    offset   = prestim;
    newtrl   = [trlbegin trlend offset];
    cond     = 14;
    trl      = [trl; newtrl cond];
  elseif ismember(event1, trig_cuePos(3)) && ismember(event2, trig_trialType(1))
    trlbegin = sample(j) + prestim;
    trlend   = sample(j) + poststim;
    offset   = prestim;
    newtrl   = [trlbegin trlend offset];
    cond     = 15;
    trl      = [trl; newtrl cond];
  elseif ismember(event1, trig_cuePos(1)) && ismember(event2, trig_trialType(2))
    trlbegin = sample(j) + prestim;
    trlend   = sample(j) + poststim;
    offset   = prestim;
    newtrl   = [trlbegin trlend offset];
    cond     = 23;
    trl      = [trl; newtrl cond];
  elseif ismember(event1, trig_cuePos(2)) && ismember(event2, trig_trialType(2))
    trlbegin = sample(j) + prestim;
    trlend   = sample(j) + poststim;
    offset   = prestim;
    newtrl   = [trlbegin trlend offset];
    cond     = 24;
    trl      = [trl; newtrl cond];
  elseif ismember(event1, trig_cuePos(3)) && ismember(event2, trig_trialType(2))
    trlbegin = sample(j) + prestim;
    trlend   = sample(j) + poststim;
    offset   = prestim;
    newtrl   = [trlbegin trlend offset];
    cond     = 25;
    trl      = [trl; newtrl cond];
  end
end