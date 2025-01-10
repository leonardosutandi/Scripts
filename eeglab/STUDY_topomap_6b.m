%% Load ersptimes erspfreqs

fpath = 'C:\MATLAB\exp_1\results\EEG\STUDY\SaN\';

ersptimes = readmatrix([fpath 'ersptimes.csv']);
erspfreqs = readmatrix([fpath 'erspfreqs.csv']);

minFreq = readmatrix([fpath 'minFreq.csv']);
maxFreq = readmatrix([fpath 'maxFreq.csv']);

minTime = readmatrix([fpath 'minTime.csv']);
maxTime = readmatrix([fpath 'maxTime.csv']);


%% B) Group

% allC =  {'participant_4','participant_5', 'participant_6', 'participant_8', 'participant_12', ...
%          'participant_13', 'participant_14', 'participant_15', 'participant_16', 'participant_18', ...
%          'participant_19', 'participant_22'};
% allMA = {'participant_7', 'participant_9', 'participant_11', 'participant_20', 'participant_21'};
% allMO = {'participant_2', 'participant_3', 'participant_10','participant_17'};

tes =  {'participant_8', 'participant_12'};
allC =  {'participant_8', 'participant_12', 'participant_13', 'participant_14'};
allMA = {'participant_7', 'participant_9', 'participant_11', 'participant_20'};
allMO = {'participant_2', 'participant_3', 'participant_10','participant_17'};

%% C) Conditions

condList = {'NG_Left', ... % 1
             'NG_Right', ... % 2
             'NG_Neutral', ... % 3
             'G_Left', ... % 4
             'G_Right', ... % 5
             'G_Neutral'}; % 6

%% D) Channel Group

allChans = {'Fp1','AF7','AF3','F1','F3','F5','F7','FT7','FC5','FC3','FC1','C1','C3','C5', ...
            'T7','TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9','PO7','PO3','O1', ...
            'Iz','Oz','POz','Pz','CPz','Fpz','Fp2','AF8','AF4','AFz','Fz','F2','F4','F6','F8','FT8', ...
            'FC6','FC4','FC2','FCz','Cz','C2','C4','C6','T8','TP8','CP6','CP4','CP2', ...
            'P2','P4','P6','P8','P10','PO8','PO4','O2'};

leftChans = {'TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9','PO7','PO3','O1'};
rightChans = {'TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10','PO8','PO4','O2'};

leftOcc = {'PO7','PO3','O1'};
% leftOccWrong = {'P2','P4','P6'};
rightOcc = {'PO8','PO4','O2'};
% rightOccWrong = {'POz','Pz','CPz'};

leftPar = {'TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9'};
% leftParWrong = {'Cz','C2','c4','C6','T8','TP8','CP6','CP4','CP2'};
rightPar = {'TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10'};
% rightParWrong = {'P3','P5','P7','P9','PO7','PO3','O1','Iz','Oz'};

% 'Iz','Oz','POz','Pz','CPz'


%% E) Title

chanList = {'Left Parietal', ...
             'Right Parietal', ...
             'Left Occipital', ...
             'Right Occipital'};

%% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Selection >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% Select which group, participant group, condition and channels to compute.
% No need for A) and B) for this script.

% A) Choose: C / MA / MO
grp = 'C'; 
% B) Group
allGrp = tes;
% C) Conditions
condType = condList{1};
% D) Channel Group
chans = rightOcc;

% order:
% C > condList 123456 > leftOcc   CHECK = 
% C > condList 123456 > rightOcc  CHECK = 
% C > condList 123456 > leftPar   CHECK = 
% C > condList 123456 > rightPar  CHECK = 
%
% MO > condList 123456 > leftOcc  CHECK = 
% MO > condList 123456 > rightOcc CHECK = 
% MO > condList 123456 > leftPar  CHECK = 
% MO > condList 123456 > rightPar CHECK = 
%
% MA > condList 123456 > leftOcc  CHECK = 
% MA > condList 123456 > rightOcc CHECK = 
% MA > condList 123456 > leftPar  CHECK = 
% MA > condList 123456 > rightPar CHECK = 

% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% Dependents for title
if isequal(chans, leftPar)
    titleChan = chanList(1);
    chanTitle = 'left_Par';
elseif isequal(chans, rightPar)
    titleChan = chanList(2);
    chanTitle = 'right_Par';
elseif isequal(chans, leftOcc)
    titleChan = chanList(3);
    chanTitle = 'left_Occ';
elseif isequal(chans, rightOcc)
    titleChan = chanList(4);
    chanTitle = 'right_Occ';
end

if isequal(condType, condList{1})
    condTitle = 'NG_Left';
elseif isequal(condType, condList{2})
    condTitle = 'NG_Right';
elseif isequal(condType, condList{3})
    condTitle = 'NG_Neutral';
elseif isequal(condType, condList{4})
    condTitle = 'G_Left';
elseif isequal(condType, condList{5})
    condTitle = 'G_Right';
elseif isequal(condType, condList{6})
    condTitle = 'G_Neutral';
end

condChan = [condTitle '_' chanTitle];

%% Load Dataset
% NOT IN USE
% [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% 
% for i = 1:length(allC)
%     [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', condType ,'commands',{ ...
%         {'index',i,'load',['C:\\MATLAB\\exp_1\\results\\EEG\\C\\' allC{i} '\\' condType '_' allC{i} '.set']}, ...
%         {'index',i,'subject',allC{i}, 'group', 'C'}}, ...
%         'updatedat','on','rmclust','on' );
% end
% 
% for j = 1:length(allMA)
%     [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', condType ,'commands',{ ...
%         {'index',[j + length(allC)],'load',['C:\\MATLAB\\exp_1\\results\\EEG\\MA\\' allMA{j} '\\' condType '_' allMA{j} '.set']}, ...
%         {'index',[j + length(allC)],'subject',allMA{j}, 'group', 'MA'}}, ...
%         'updatedat','on','rmclust','on' );
% end
% 
% for k = 1:length(allMO)
%     [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', condType ,'commands',{ ...
%         {'index',[k + length(allC) + length(allMA)],'load',['C:\\MATLAB\\exp_1\\results\\EEG\\MO\\' allMO{k} '\\' condType '_' allMO{k} '.set']}, ...
%         {'index',[k + length(allC) + length(allMA)],'subject',allMO{k}, 'group', 'MO'}}, ...
%         'updatedat','on','rmclust','on' );
% end
% 
% %save
% pop_savestudy( STUDY, EEG, 'filename',[condType '_' titleSave '.study'], ...
%                            'filepath',['C:\\MATLAB\\exp_1\\results\\EEG\\' grp 'STUDY\\'],'resavedatasets','on');

%% Export for R

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for i = 1:length(allGrp)    

    % Load participant
    [STUDY ALLEEG] = std_editset(STUDY, ALLEEG, 'name', condType ,'commands',{ ...
        {'index',i,'load',['C:\\MATLAB\\exp_1\\results\\EEG\\' grp '\\' allGrp{i} '\\' condType '_' allGrp{i} '.set']}, ...
        {'index',i,'subject',allGrp{i}, 'group', grp}}, ...
        'updatedat','on','rmclust','on' );

    % Pre-Compute
    [STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on', ...
                                                    'rmicacomps','on', ...
                                                    'interp','on', ...
                                                    'recompute','on', ...
                                                    'erp','on','erpparams',{'rmbase',[-1000 -200] }, ...
                                                    'spec','on', 'specparams',{'specmode','fft','logtrials','off'}, ...
                                                    'ersp','on','erspparams',{'rmerp', 'off', ...
                                                                              'tlimits', [-1000 1500], ...
                                                                              'freqs', [5 30], ... 
                                                                              'cycles',[5 0.8] , ...
                                                                              'baseline',[-1000 -200], ...
                                                                              'basenorm', 'off', ...
                                                                              'plotphase', 'off', ...
                                                                              'padratio', 2, ...
                                                                              'freqscale', 'linear' ...
                                                                              'winsize', 512 ...
                                                                              }, ... 
                                                    'itc','on');

                                                                              % 'nfreqs', 100, ... %faster comp
                                                                              % 'ntimesout', 200, ... %faster comp
    % Set parameter
    STUDY = pop_erspparams(STUDY, 'subbaseline', 'on', ...
                                  'averagemode', 'ave', ...
                                  'averagechan','off', ...
                                  'topotime', [ersptimes(minTime) ersptimes(maxTime)], ...
                                  'topofreq', [erspfreqs(minFreq) erspfreqs(maxFreq)], ...
                                  'ersplim', [-3 3]);

    % % Get ersptimes erspfreqs
    % if i == 1
    %     [x x ersptimes erspfreqs x x x] = std_erspplot(STUDY,ALLEEG, ...
    %                                                                  'channels',allChans, ...
    %                                                                  'subject', allGrp{i}, ...
    %                                                                  'plotsubjects', 'off', ...
    %                                                                  'noplot', 'on', ...
    %                                                                  'design', 1);
    % end 


    % % <<<<<<<<<<<<<<<<<<<<<<<<< Select specific frequency and time range >>>>>>>>>>>>>>>>>>>>>>>>>
    % % Selects alpha range (8-14 Hz)
    % freqIdx = find(erspfreqs>=8 & erspfreqs<=14);
    % minFreq = freqIdx(1,1);
    % maxFreq = freqIdx(1,end);
    % % Select time > 200 secs
    % timeIdx = find(ersptimes >= 200);
    % minTime = timeIdx(1,1);
    % maxTime = timeIdx(1,end);
    % % <<<<<<<<<<<<<<<<<<<<<<<<< Select specific frequency and time range >>>>>>>>>>>>>>>>>>>>>>>>>


    % Selection-dependent function (TF-plot - output only)
    % Mean data for csv output starts within the if statements below. Every
    % erspdata is appended to dataAvg and dataIndiv per for-loop rotation.

    % NG_Left
    if isequal(condType, condList{1})
        [STUDY erspdata_NG_Left ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',allChans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_NG_Left{1};
            % dataIndiv{1} = mean(erspdata_NG_Left{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_NG_Left{1};
            % dataIndiv{i} = mean(erspdata_NG_Left{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    % NG_Right
    elseif isequal(condType, condList{2})
        [STUDY erspdata_NG_Right ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',allChans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_NG_Right{1};
            % dataIndiv{1} = mean(erspdata_NG_Right{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_NG_Right{1};
            % dataIndiv{i} = mean(erspdata_NG_Right{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    % NG_Neutral
    elseif isequal(condType, condList{3})
        [STUDY erspdata_NG_Neutral ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',allChans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_NG_Neutral{1};
            % dataIndiv{1} = mean(erspdata_NG_Neutral{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_NG_Neutral{1};
            % dataIndiv{i} = mean(erspdata_NG_Neutral{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    % G_Left
    elseif isequal(condType, condList{4})
        [STUDY erspdata_G_Left ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',allChans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_G_Left{1};
            % dataIndiv{1} = mean(erspdata_G_Left{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_G_Left{1};
            % dataIndiv{i} = mean(erspdata_G_Left{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    % G_Right
    elseif isequal(condType, condList{5})
        [STUDY erspdata_G_Right ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',allChans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_G_Right{1};
            % dataIndiv{1} = mean(erspdata_G_Right{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_G_Right{1};
            % dataIndiv{i} = mean(erspdata_G_Right{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    % G_Neutral
    elseif isequal(condType, condList{6})
        [STUDY erspdata_G_Neutral ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',allChans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_G_Neutral{1};
            % dataIndiv{1} = mean(erspdata_G_Neutral{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_G_Neutral{1};
            % dataIndiv{i} = mean(erspdata_G_Neutral{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    end
end

%% csv prep

% (Between Group Analysis) Code chunk below combines all participant's data 
% and average them. Specific time range and frequency band is then selected 
% to be written in .csv format to be analysed in R (output = 2D [times x freqs])

% Group Mean
% Combines all participant's individual erspdata from dataAvg into 1 cell array (3Dim)
dataAvgComb = cat(3, dataAvg{1,:});

if isequal(condType, condList{1})
    dataAvgComb1 = dataAvgComb;
elseif isequal(condType, condList{2})
    dataAvgComb2 = dataAvgComb;
elseif isequal(condType, condList{3})
    dataAvgComb3 = dataAvgComb;
elseif isequal(condType, condList{4})
    dataAvgComb4 = dataAvgComb;
elseif isequal(condType, condList{5})
    dataAvgComb5 = dataAvgComb;
elseif isequal(condType, condList{6})
    dataAvgComb6 = dataAvgComb;
end
% Averaged accross participants (2Dim)
dataAvgMean = mean(dataAvgComb, 3);

if isequal(condType, condList{1})
    dataAvgMean1 = dataAvgMean;
elseif isequal(condType, condList{2})
    dataAvgMean2 = dataAvgMean;
elseif isequal(condType, condList{3})
    dataAvgMean3 = dataAvgMean;
elseif isequal(condType, condList{4})
    dataAvgMean4 = dataAvgMean;
elseif isequal(condType, condList{5})
    dataAvgMean5 = dataAvgMean;
elseif isequal(condType, condList{6})
    dataAvgMean6 = dataAvgMean;
end
% % Filter from data mean based on above parameter (only select avg values as above)
% dataAvgOut = dataAvgMean(minFreq:maxFreq, minTime:maxTime);
% % Write to csv
% filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\between\\between_' grp '_' condType '_' chanTitle '.csv'];
% writematrix(dataAvgOut, filename);

%% TOPOPLOT NOT IN USE
% % toporeplot(dataAvgMean, 'plotrad',1, 'intrad',1);
% % topoplot(dataAvgMean, 'chanlocs');
% toPlotList= {'NG', 'G'};
% toPlot = toPlotList{1};
% 
% % topoplot(dataAvgMean, [ALLEEG(1).chanlocs]);
% if isequal(toPlot, toPlotList{1})
%     AMI_NG = (dataAvgMean1 - dataAvgMean2) ./ (dataAvgMean1 + dataAvgMean2);
%     [h val1 val2, xmesh, ymesh] = topoplot(AMI_NG, ALLEEG(1).chanlocs);
%     toporeplot(val2, 'plotrad', 0.5, 'intrad', 0.5, 'maplimits', [0 0]);
% elseif isequal(toPlot, toPlotList{2})
%     AMI_G = (dataAvgMean4 - dataAvgMean5) ./ (dataAvgMean4 + dataAvgMean5);
%     [h val1 val2, xmesh, ymesh] = topoplot(AMI_G, ALLEEG(1).chanlocs);
%     toporeplot(val2, 'plotrad', 0.5, 'intrad', 0.5, 'maplimits', [0 0]);
% end
% 
% % [h val1 val2, xmesh, ymesh]=topoplot(AMI, ALLEEG(1).chanlocs);
% % toporeplot(val2, 'plotrad', 0.5, 'intrad', 0.5, 'maplimits', [-1 1]);

%% TEST

figure; 
topoplot(dataAvgMean, ALLEEG(1).chanlocs, 'plotrad', 0.5, 'intrad', 0.5, 'maplimits', [-3 3]); hold on
c = colorbar;
title(c, 'dB');
title('8-14 Hz ~200-1000ms'); hold off;

%Save

%% which

which = [grp '_' condChan ];
which

%% Preview Averaged Plot

% dat{1,1} = dataAvgMean;
% std_plottf(ersptimes, erspfreqs, dat, 'titles', {condChan}, 'ersplim', [-3 3]);

% <<<<< OR >>>>>
    % STUDY = pop_erspparams(STUDY, 'subbaseline', 'on', ...
    %                               'averagemode', 'ave', ...
    %                               'averagechan','on');
% [x dat1] = std_erspplot(STUDY, ALLEEG, ...
%                                          'channels',chans, ...
%                                          'plotsubjects', 'on', ...
%                                          'noplot', 'off', ...
%                                          'design', 1);
% std_plottf(ersptimes, erspfreqs, dat1, 'titles', {condChan});
% 
% [x dat2] = std_erspplot(STUDY, ALLEEG, ...
%                                          'channels',chans, ...
%                                          'subject', 'participant_7', ...
%                                          'plotsubjects', 'off', ...
%                                          'noplot', 'on', ...
%                                          'design', 1);
% std_plottf(ersptimes, erspfreqs, dat2, 'titles', {'participant_7'});
% 
% [x dat3] = std_erspplot(STUDY, ALLEEG, ...
%                                          'channels',chans, ...
%                                          'subject', 'participant_9', ...
%                                          'plotsubjects', 'off', ...
%                                          'noplot', 'on', ...
%                                          'design', 1);
% std_plottf(ersptimes, erspfreqs, dat3, 'titles', {'participant_9'});


%% Run all C
% % A) Choose: C / MA / MO
% grp = 'C'; 
% % B) Group
% allGrp = allC;
% % C) Conditions
% condType = condList{1};
% % D) Channel Group
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'C'; 
% % B) Group
% allGrp = allC;
% % C) Conditions
% condType = condList{2};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'C'; 
% % B) Group
% allGrp = allC;
% % C) Conditions
% condType = condList{3};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% 
% % A) Choose: C / MA / MO
% grp = 'C'; 
% % B) Group
% allGrp = allC;
% % C) Conditions
% condType = condList{4};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'C'; 
% % B) Group
% allGrp = allC;
% % C) Conditions
% condType = condList{5};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'C'; 
% % B) Group
% allGrp = allC;
% % C) Conditions
% condType = condList{6};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;

%% Run all MA
% % % A) Choose: C / MA / MO
% % grp = 'MA'; 
% % % B) Group
% % allGrp = allMA;
% % % C) Conditions
% % condType = condList{1};
% % % D) Channel Group
% % chans = leftOcc;
% % clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% % rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'MA'; 
% % B) Group
% allGrp = allMA;
% % C) Conditions
% condType = condList{2};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'MA'; 
% % B) Group
% allGrp = allMA;
% % C) Conditions
% condType = condList{3};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'MA'; 
% % B) Group
% allGrp = allMA;
% % C) Conditions
% condType = condList{4};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'MA'; 
% % B) Group
% allGrp = allMA;
% % C) Conditions
% condType = condList{5};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'MA'; 
% % B) Group
% allGrp = allMA;
% % C) Conditions
% condType = condList{6};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;

%% Run all MO
% % % A) Choose: C / MA / MO
% % grp = 'MO'; 
% % % B) Group
% % allGrp = allMO;
% % % C) Conditions
% % condType = condList{1};
% % % D) Channel Group
% % chans = leftOcc;
% % clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% % rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'MO'; 
% % B) Group
% allGrp = allMO;
% % C) Conditions
% condType = condList{2};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'MO'; 
% % B) Group
% allGrp = allMO;
% % C) Conditions
% condType = condList{3};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'MO'; 
% % B) Group
% allGrp = allMO;
% % C) Conditions
% condType = condList{4};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'MO'; 
% % B) Group
% allGrp = allMO;
% % C) Conditions
% condType = condList{5};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% % A) Choose: C / MA / MO
% grp = 'MO'; 
% % B) Group
% allGrp = allMO;
% % C) Conditions
% condType = condList{6};
% % D) Channel Group
% chans = leftOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightOcc;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = leftPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;
% 
% chans = rightPar;
% clear dat dataAvg dataAvgComb dataAvgMean dataAvgOut dataIndiv dataIndivComb dataIndivOut dataIndivOut2;
% rerun;


%%

% [x dat1] = std_erspplot(STUDY, ALLEEG, ...
%                                          'channels',chans, ...
%                                          'subject', 'participant_2', ...
%                                          'plotsubjects', 'off', ...
%                                          'noplot', 'on', ...
%                                          'design', 1);
% std_plottf(ersptimes, erspfreqs, dat1, 'titles', {'participant_2'}, 'ersplim', [-3 3]);
% 
% [x dat2] = std_erspplot(STUDY, ALLEEG, ...
%                                          'channels',chans, ...
%                                          'subject', 'participant_3', ...
%                                          'plotsubjects', 'off', ...
%                                          'noplot', 'on', ...
%                                          'design', 1);
% std_plottf(ersptimes, erspfreqs, dat2, 'titles', {'participant_3'}, 'ersplim', [-3 3]);
% 
% [x dat3] = std_erspplot(STUDY, ALLEEG, ...
%                                          'channels',chans, ...
%                                          'subject', 'participant_10', ...
%                                          'plotsubjects', 'off', ...
%                                          'noplot', 'on', ...
%                                          'design', 1);
% std_plottf(ersptimes, erspfreqs, dat3, 'titles', {'participant_10'}, 'ersplim', [-3 3]);
% 
% [x dat4] = std_erspplot(STUDY, ALLEEG, ...
%                                          'channels',chans, ...
%                                          'subject', 'participant_17', ...
%                                          'plotsubjects', 'off', ...
%                                          'noplot', 'on', ...
%                                          'design', 1);
% std_plottf(ersptimes, erspfreqs, dat4, 'titles', {'participant_17'}, 'ersplim', [-3 3]);
% 
% dat{1,1} = dataAvgMean;
% std_plottf(ersptimes, erspfreqs, dat, 'titles', {dataAvgMean}, 'ersplim', [-3 3]);













