%% Load Dataset

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for i = 1:length(allC)
    [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', condType ,'commands',{ ...
        {'index',i,'load',['C:\\MATLAB\\exp_1\\results\\EEG\\C\\' allC{i} '\\' condType '_' allC{i} '.set']}, ...
        {'index',i,'subject',allC{i}, 'group', 'C'}}, ...
        'updatedat','on','rmclust','on' );
end

for j = 1:length(allMA)
    [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', condType ,'commands',{ ...
        {'index',[j + length(allC)],'load',['C:\\MATLAB\\exp_1\\results\\EEG\\MA\\' allMA{j} '\\' condType '_' allMA{j} '.set']}, ...
        {'index',[j + length(allC)],'subject',allMA{j}, 'group', 'MA'}}, ...
        'updatedat','on','rmclust','on' );
end

for k = 1:length(allMO)
    [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'name', condType ,'commands',{ ...
        {'index',[k + length(allC) + length(allMA)],'load',['C:\\MATLAB\\exp_1\\results\\EEG\\MO\\' allMO{k} '\\' condType '_' allMO{k} '.set']}, ...
        {'index',[k + length(allC) + length(allMA)],'subject',allMO{k}, 'group', 'MO'}}, ...
        'updatedat','on','rmclust','on' );
end

%% Export for R

% Pre-Compute
[STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on', ...
                                                'rmicacomps','on', ...
                                                'interp','on', ...
                                                'recompute','on', ...
                                                'erp','on','erpparams',{'rmbase',[-1000 -200] }, ...
                                                'spec','on', 'specparams',{'specmode','fft','logtrials','off'}, ...
                                                'ersp','on','erspparams',{'cycles',[3 0.8] , ...
                                                                          'baseline',[-1000 -200], ...
                                                                          'basenorm', 'off', ...
                                                                          'plotphase', 'off', ...
                                                                          'padratio', 2, ...
                                                                          'freqscale', 'linear' ...
                                                                          'winsize', 512}, ...
                                                'itc','on');

% Set parameter
STUDY = pop_erspparams(STUDY, 'freqrange',[8 13], 'ersplim', [-5.4 5.4], 'subbaseline', 'on', 'averagemode', 'ave', 'averagechan','on');
[STUDY erspdata ersptimes erspfreqs pgroup pcond pinter] = std_erspplot(STUDY,ALLEEG, ...
                                                                        'channels',chans, ...
                                                                        'plotsubjects', 'on', ...
                                                                        'design', 1, ...
                                                                        'noplot', 'on');
% Write csv
filename = 'erspdata.csv';
M = squeeze([erspdata]);

writematrix(M, filename)
















































