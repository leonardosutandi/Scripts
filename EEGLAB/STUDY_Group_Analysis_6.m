%% B) Group

% allC =  {'participant_1', 'participant_4','participant_5', 'participant_6', 'participant_8', ...
%          'participant_12', 'participant_13', 'participant_14', 'participant_15', 'participant_16'};
% allMA = {'participant_7', 'participant_9', 'participant_11'};
% allMO = {'participant_2', 'participant_3', 'participant_10','participant_17'};


allC =  {'participant_12', 'participant_13', 'participant_14', 'participant_15'};
allMA = {'participant_9', 'participant_11'};
allMO = {'participant_10','participant_17'};

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

titleList = {'Left Parietal', ...
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
allGrp = allC;
% C) Conditions
condType = condList{1};
% D) Channel Group
chans = rightOcc;

% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% Dependents for title
if isequal(chans, leftPar)
    title = titleList(1);
    titleSave = 'leftPar';
elseif isequal(chans, rightPar)
    title = titleList(2);
    titleSave = 'rightPar';
elseif isequal(chans, leftOcc)
    title = titleList(3);
    titleSave = 'leftOcc';
elseif isequal(chans, rightOcc)
    title = titleList(4);
    titleSave = 'rightOcc';
end


%% Load Dataset

% This chunk saves all participants from every group in 1 STUDY (but ONLY 1 condition and 1 channel group)

% [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

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
                                                    'ersp','on','erspparams',{'rmerp', 'on', ...
                                                                              'cycles',[3 0.8] , ...
                                                                              'baseline',[-1000 -200], ...
                                                                              'basenorm', 'off', ...
                                                                              'plotphase', 'off', ...
                                                                              'padratio', 2, ...
                                                                              'freqscale', 'linear' ...
                                                                              'winsize', 512, ...
                                                                              'nfreqs', 100, ... %faster computation
                                                                              'ntimesout', 200}, ... %faster computation
                                                    'itc','on');

    % Set parameter
    STUDY = pop_erspparams(STUDY, 'freqrange',[0 40], ...
                                  'ersplim', [-5.4 5.4], ...
                                  'subbaseline', 'on', ...
                                  'averagemode', 'ave', ...
                                  'averagechan','on');
   
    % Get ersptimes erspfreqs
    if i == 1
        [x x ersptimes erspfreqs x x x] = std_erspplot(STUDY,ALLEEG, 'channels',chans, ...
                                                                     'subject', allGrp{i}, ...
                                                                     'plotsubjects', 'off', ...
                                                                     'noplot', 'on', ...
                                                                     'design', 1);
    end 


    % <<<<<<<<<<<<<<<<<<<<<<<<< Select specific frequency and time range >>>>>>>>>>>>>>>>>>>>>>>>>
    % Selects alpha range (8-14 Hz)
    freqIdx = find(erspfreqs > 8 & erspfreqs < 14);
    minFreq = freqIdx(1,1);
    maxFreq = freqIdx(1,end);
    % Select time > 200 secs
    timeIdx = find(ersptimes >= 200);
    minTime = timeIdx(1,1);
    maxTime = timeIdx(1,end);
    % <<<<<<<<<<<<<<<<<<<<<<<<< Select specific frequency and time range >>>>>>>>>>>>>>>>>>>>>>>>>


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

% (Within Group Analysis) Code chunk below takes each participant's data 
% and averaged the specific frequency band and timerange to be written in 
% a .csv format to be analysed in R

% Frequency and Time Range selection and its mean for each participant already done in erspplot for loop
% Combines all participant's individual erspdata from dataIndiv into 1 cell array (3Dim)
dataIndivComb = (cat(3, dataIndiv{1,:}));
dataIndivOut = squeeze(dataIndivComb);
% Write to csv
filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\within\\' grp '_' condType '_' titleSave '.csv'];
writematrix(dataIndivOut, filename)


% (Between Group Analysis) Code chunk below combines all participant's data 
% and average them. Specific time raneg and frequency band is then selected 
% to be written in .csv format to be analysed in R

% Group Mean
% Combines all participant's individual erspdata from dataAvg into 1 cell array (3Dim)
dataAvgComb = cat(3, dataAvg{1,:});
% Averaged accross participants (in each 2Dim)
dataAvgMean = mean(dataAvgComb, 3);
% Filter from data mean based on above parameter (only select avg values as above)
dataAvgOut = dataAvgMean(minFreq:maxFreq, minTime:maxTime);
% Write to csv
filename = ['C:\\MATLAB\\exp_1\\results\\EEG\\STUDY\\between\\' grp '_' condType '_' titleSave '.csv'];
writematrix(dataAvgOut, filename)



% % Select specific frequency and time range
% % Selects alpha range (8-14 Hz)
% freqIdx = find(erspfreqs > 8 & erspfreqs < 14);
% minFreq = freqIdx(1,1);
% maxFreq = freqIdx(1,end);
% % Select time > 200 secs
% timeIdx = find(ersptimes >= 200);
% minTime = timeIdx(1,1);
% maxTime = timeIdx(1,end);

% dataOut = dataMean(3:5,93:200);


%% Write csv

% 
% 
% pop_savestudy(STUDY, EEG, 'filename', 'twoPerGroup', ...
%                           'filepath', 'C:\\MATLAB\\exp_1\\results\\EEG\\');
































