
%% B) Group

% allC =  {'participant_4','participant_5', 'participant_6', 'participant_8', 'participant_12', ...
%          'participant_13', 'participant_14', 'participant_15', 'participant_16', 'participant_18', ...
%          'participant_19', 'participant_22'};
% allMA = {'participant_7', 'participant_9', 'participant_11', 'participant_20', 'participant_21'};
% allMO = {'participant_2', 'participant_3', 'participant_10','participant_17'};

tes =  {'participant_18', 'participant_19'};
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
chans = leftOcc;

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

condChan = [grp '_' condTitle '_' chanTitle];

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
                                  'averagechan','on');

    % Get ersptimes erspfreqs
    if i == 1
        [x x ersptimes erspfreqs x x x] = std_erspplot(STUDY,ALLEEG, ...
                                                                     'channels',chans, ...
                                                                     'subject', allGrp{i}, ...
                                                                     'plotsubjects', 'off', ...
                                                                     'noplot', 'on', ...
                                                                     'design', 1);
    end 

    filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\SaN\\ersptimes.csv'];
    writematrix(ersptimes, filename);

    filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\SaN\\erspfreqs.csv'];
    writematrix(erspfreqs, filename);

    % <<<<<<<<<<<<<<<<<<<<<<<<< Select specific frequency and time range >>>>>>>>>>>>>>>>>>>>>>>>>
    % Selects alpha range (8-14 Hz)
    freqIdx = find(erspfreqs>=8 & erspfreqs<=14);
    minFreq = freqIdx(1,1);
    maxFreq = freqIdx(1,end);

    filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\SaN\\minFreq.csv'];
    writematrix(minFreq, filename);
    filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\SaN\\maxFreq.csv'];
    writematrix(maxFreq, filename);

    % Select time > 200 secs
    timeIdx = find(ersptimes >= 200);
    minTime = timeIdx(1,1);
    maxTime = timeIdx(1,end);

    filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\SaN\\minTime.csv'];
    writematrix(minTime, filename);
    filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\SaN\\maxTime.csv'];
    writematrix(maxTime, filename);

    % <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


    % Selection-dependent function (TF-plot - output only)
    % Mean data for csv output starts within the if statements below. Every
    % erspdata is appended to dataAvg and dataIndiv per for-loop rotation.

    % NG_Left
    if isequal(condType, condList{1})
        [STUDY erspdata_NG_Left ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',chans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_NG_Left{1};
            dataIndiv{1} = mean(erspdata_NG_Left{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_NG_Left{1};
            dataIndiv{i} = mean(erspdata_NG_Left{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    % NG_Right
    elseif isequal(condType, condList{2})
        [STUDY erspdata_NG_Right ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',chans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_NG_Right{1};
            dataIndiv{1} = mean(erspdata_NG_Right{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_NG_Right{1};
            dataIndiv{i} = mean(erspdata_NG_Right{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    % NG_Neutral
    elseif isequal(condType, condList{3})
        [STUDY erspdata_NG_Neutral ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',chans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_NG_Neutral{1};
            dataIndiv{1} = mean(erspdata_NG_Neutral{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_NG_Neutral{1};
            dataIndiv{i} = mean(erspdata_NG_Neutral{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    % G_Left
    elseif isequal(condType, condList{4})
        [STUDY erspdata_G_Left ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',chans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_G_Left{1};
            dataIndiv{1} = mean(erspdata_G_Left{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_G_Left{1};
            dataIndiv{i} = mean(erspdata_G_Left{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    % G_Right
    elseif isequal(condType, condList{5})
        [STUDY erspdata_G_Right ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',chans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_G_Right{1};
            dataIndiv{1} = mean(erspdata_G_Right{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_G_Right{1};
            dataIndiv{i} = mean(erspdata_G_Right{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    % G_Neutral
    elseif isequal(condType, condList{6})
        [STUDY erspdata_G_Neutral ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                                'channels',chans, ...
                                                                                'subject', allGrp{i}, ...
                                                                                'plotsubjects', 'off', ...
                                                                                'noplot', 'on', ...
                                                                                'design', 1);
        if i == 1
            dataAvg{1} = erspdata_G_Neutral{1};
            dataIndiv{1} = mean(erspdata_G_Neutral{1}(minFreq:maxFreq, minTime:maxTime), "all");
        elseif i ~= 1
            dataAvg{i} = erspdata_G_Neutral{1};
            dataIndiv{i} = mean(erspdata_G_Neutral{1}(minFreq:maxFreq, minTime:maxTime), "all");
        end

    end
end

%% csv prep

% (Within Group Analysis) Code chunk below takes each n participant's data 
% and averaged the specific frequency band and timerange to be written on row n in 
% a .csv format to be analysed in R (output = 2D [avg value x each participant)

% Frequency and Time Range selection and its mean for each participant already done in erspplot for loop
% Combines all participant's individual erspdata from dataIndiv into 1 cell array (3Dim)
dataIndivComb = (cat(3, dataIndiv{1,:}));
dataIndivOut = squeeze(dataIndivComb);
dataIndivOut2 = array2table(dataIndivOut, 'RowNames', allGrp, 'VariableNames', {condChan});
% Write to csv
filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\within\\within_' grp '_' condType '_' chanTitle '.csv'];
writetable(dataIndivOut2, filename, 'WriteRowNames', 1);


% (Between Group Analysis) Code chunk below combines all participant's data 
% and average them. Specific time range and frequency band is then selected 
% to be written in .csv format to be analysed in R (output = 2D [times x freqs])

% dataAvgMean is also used to regenerate plot in the next code chunk

% Group Mean
% Combines all participant's individual erspdata from dataAvg into 1 cell array (3Dim)
dataAvgComb = cat(3, dataAvg{1,:});
% Averaged accross participants (2Dim). Results in average whole matrix
dataAvgMean = mean(dataAvgComb, 3);
filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\SaN\\SaN_' grp '_' condType '_' chanTitle '.csv'];
writematrix(dataAvgMean, filename);
% Filters above data to only frequency and time range of interest (e.g. alpha between 200-1000).
dataAvgOut = dataAvgMean(minFreq:maxFreq, minTime:maxTime);
% Write to csv
filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\between\\between_' grp '_' condType '_' chanTitle '.csv'];
writematrix(dataAvgOut, filename);


%% Plot Average

% dat{1,1} = dataAvgMean;
% std_plottf(ersptimes, erspfreqs, dat, 'titles', {condChan}, 'ersplim', [-3 3]);

% Create figure input matrix to plot
figure; 
x = [ersptimes(1) ersptimes(end)];
y = [erspfreqs(1) erspfreqs(end)];
imagesc(x, y, dataAvgMean); hold on
% Mark freq and time of interest (-10 and -5 for lines to fit in figuer)
plot([ersptimes(minTime) ersptimes(maxTime)-10], [erspfreqs(minFreq) erspfreqs(minFreq)], '--', 'linewidth', 2, 'color', 'k'); % Bottom
plot([ersptimes(minTime) ersptimes(maxTime)-10], [erspfreqs(maxFreq) erspfreqs(maxFreq)], '--', 'linewidth', 2, 'color', 'k'); % Top
plot([ersptimes(minTime) ersptimes(minTime)], [erspfreqs(minFreq) erspfreqs(maxFreq)], '--', 'linewidth', 2, 'color', 'k'); % Left
plot([ersptimes(maxTime)-5 ersptimes(maxTime)-5], [erspfreqs(minFreq) erspfreqs(maxFreq)], '--', 'linewidth', 2, 'color', 'k'); % Right
% Colourbar limit
clim([-3 0]);
% Plot y axis line (t = 0); -1 +1 to fit in figure
plot([[ersptimes(1)-ersptimes(1)] [ersptimes(1)-ersptimes(1)]], [[erspfreqs(1)-1] [erspfreqs(end)+1]], ':', 'linewidth', 1.2, 'color', 'k');
% flip matrix, set x and y axis, just in case image is flipped
axis xy;
% Change colour
colormap(jet);
% set colour bar for scale
c = colorbar;
title(c, 'dB');

% Titles
title(condChan);
xlabel('Time (ms)');
ylabel('Frequency (Hz)');
fontsize(12, 'points');

hold off

% % save fugrue
fpath = 'C:\MATLAB\exp_1\results\plots';
saveas(gca, fullfile(fpath, condChan), 'jpg');
% saveas(gca, [condChan '.jpg']);

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
% 
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













