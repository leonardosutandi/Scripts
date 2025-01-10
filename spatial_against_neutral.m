

%% Load

% A) Choose: C / MA / MO
grp = 'C'; 

fpath = 'C:\MATLAB\exp_1\results\EEG\STUDY\SaN\';

ersptimes = readmatrix([fpath 'ersptimes.csv']);
erspfreqs = readmatrix([fpath 'erspfreqs.csv']);

minFreq = readmatrix([fpath 'minFreq.csv']);
maxFreq = readmatrix([fpath 'maxFreq.csv']);

minTime = readmatrix([fpath 'minTime.csv']);
maxTime = readmatrix([fpath 'maxTime.csv']);


%% Control
NG_Left_left_Par = readmatrix([fpath 'SaN_' grp '_NG_Left_left_Par.csv']);
NG_Left_right_Par = readmatrix([fpath 'SaN_' grp '_NG_Left_right_Par.csv']);
NG_Left_left_Occ = readmatrix([fpath 'SaN_' grp '_NG_Left_left_Occ.csv']);
NG_Left_right_Occ = readmatrix([fpath 'SaN_' grp '_NG_Left_right_Occ.csv']);

NG_Right_left_Par = readmatrix([fpath 'SaN_' grp '_NG_Right_left_Par.csv']);
NG_Right_right_Par = readmatrix([fpath 'SaN_' grp '_NG_Right_right_Par.csv']);
NG_Right_left_Occ = readmatrix([fpath 'SaN_' grp '_NG_Right_left_Occ.csv']);
NG_Right_right_Occ = readmatrix([fpath 'SaN_' grp '_NG_Right_right_Occ.csv']);

NG_Neutral_left_Par = readmatrix([fpath 'SaN_' grp '_NG_Neutral_left_Par.csv']);
NG_Neutral_right_Par = readmatrix([fpath 'SaN_' grp '_NG_Neutral_right_Par.csv']);
NG_Neutral_left_Occ = readmatrix([fpath 'SaN_' grp '_NG_Neutral_left_Occ.csv']);
NG_Neutral_right_Occ = readmatrix([fpath 'SaN_' grp '_NG_Neutral_right_Occ.csv']);

G_Left_left_Par = readmatrix([fpath 'SaN_' grp '_G_Left_left_Par.csv']);
G_Left_right_Par = readmatrix([fpath 'SaN_' grp '_G_Left_right_Par.csv']);
G_Left_left_Occ = readmatrix([fpath 'SaN_' grp '_G_Left_left_Occ.csv']);
G_Left_right_Occ = readmatrix([fpath 'SaN_' grp '_G_Left_right_Occ.csv']);

G_Right_left_Par = readmatrix([fpath 'SaN_' grp '_G_Right_left_Par.csv']);
G_Right_right_Par = readmatrix([fpath 'SaN_' grp '_G_Right_right_Par.csv']);
G_Right_left_Occ = readmatrix([fpath 'SaN_' grp '_G_Right_left_Occ.csv']);
G_Right_right_Occ = readmatrix([fpath 'SaN_' grp '_G_Right_right_Occ.csv']);

G_Neutral_left_Par = readmatrix([fpath 'SaN_' grp '_G_Neutral_left_Par.csv']);
G_Neutral_right_Par = readmatrix([fpath 'SaN_' grp '_G_Neutral_right_Par.csv']);
G_Neutral_left_Occ = readmatrix([fpath 'SaN_' grp '_G_Neutral_left_Occ.csv']);
G_Neutral_right_Occ = readmatrix([fpath 'SaN_' grp '_G_Neutral_right_Occ.csv']);

% %% MA
% MA_NG_Left_left_Par = readmatrix([fpath 'SaN_MA_NG_Left_left_Par.csv']);
% MA_NG_Left_right_Par = readmatrix([fpath 'SaN_MA_NG_Left_right_Par.csv']);
% MA_NG_Left_left_Occ = readmatrix([fpath 'SaN_MA_NG_Left_left_Occ.csv']);
% MA_NG_Left_right_Occ = readmatrix([fpath 'SaN_MA_NG_Left_right_Occ.csv']);
% 
% MA_NG_Right_left_Par = readmatrix([fpath 'SaN_MA_NG_Right_left_Par.csv']);
% MA_NG_Right_right_Par = readmatrix([fpath 'SaN_MA_NG_Right_right_Par.csv']);
% MA_NG_Right_left_Occ = readmatrix([fpath 'SaN_MA_NG_Right_left_Occ.csv']);
% MA_NG_Right_right_Occ = readmatrix([fpath 'SaN_MA_NG_Right_right_Occ.csv']);
% 
% MA_NG_Neutral_left_Par = readmatrix([fpath 'SaN_MA_NG_Neutral_left_Par.csv']);
% MA_NG_Neutral_right_Par = readmatrix([fpath 'SaN_MA_NG_Neutral_right_Par.csv']);
% MA_NG_Neutral_left_Occ = readmatrix([fpath 'SaN_MA_NG_Neutral_left_Occ.csv']);
% MA_NG_Neutral_right_Occ = readmatrix([fpath 'SaN_MA_NG_Neutral_right_Occ.csv']);
% 
% MA_G_Left_left_Par = readmatrix([fpath 'SaN_MA_G_Left_left_Par.csv']);
% MA_G_Left_right_Par = readmatrix([fpath 'SaN_MA_G_Left_right_Par.csv']);
% MA_G_Left_left_Occ = readmatrix([fpath 'SaN_MA_G_Left_left_Occ.csv']);
% MA_G_Left_right_Occ = readmatrix([fpath 'SaN_MA_G_Left_right_Occ.csv']);
% 
% MA_G_Right_left_Par = readmatrix([fpath 'SaN_MA_G_Right_left_Par.csv']);
% MA_G_Right_right_Par = readmatrix([fpath 'SaN_MA_G_Right_right_Par.csv']);
% MA_G_Right_left_Occ = readmatrix([fpath 'SaN_MA_G_Right_left_Occ.csv']);
% MA_G_Right_right_Occ = readmatrix([fpath 'SaN_MA_G_Right_right_Occ.csv']);
% 
% MA_G_Neutral_left_Par = readmatrix([fpath 'SaN_MA_G_Neutral_left_Par.csv']);
% MA_G_Neutral_right_Par = readmatrix([fpath 'SaN_MA_G_Neutral_right_Par.csv']);
% MA_G_Neutral_left_Occ = readmatrix([fpath 'SaN_MA_G_Neutral_left_Occ.csv']);
% MA_G_Neutral_right_Occ = readmatrix([fpath 'SaN_MA_G_Neutral_right_Occ.csv']);
% 
% %% MO
% MO_NG_Left_left_Par = readmatrix([fpath 'SaN_MO_NG_Left_left_Par.csv']);
% MO_NG_Left_right_Par = readmatrix([fpath 'SaN_MO_NG_Left_right_Par.csv']);
% MO_NG_Left_left_Occ = readmatrix([fpath 'SaN_MO_NG_Left_left_Occ.csv']);
% MO_NG_Left_right_Occ = readmatrix([fpath 'SaN_MO_NG_Left_right_Occ.csv']);
% 
% MO_NG_Right_left_Par = readmatrix([fpath 'SaN_MO_NG_Right_left_Par.csv']);
% MO_NG_Right_right_Par = readmatrix([fpath 'SaN_MO_NG_Right_right_Par.csv']);
% MO_NG_Right_left_Occ = readmatrix([fpath 'SaN_MO_NG_Right_left_Occ.csv']);
% MO_NG_Right_right_Occ = readmatrix([fpath 'SaN_MO_NG_Right_right_Occ.csv']);
% 
% MO_NG_Neutral_left_Par = readmatrix([fpath 'SaN_MO_NG_Neutral_left_Par.csv']);
% MO_NG_Neutral_right_Par = readmatrix([fpath 'SaN_MO_NG_Neutral_right_Par.csv']);
% MO_NG_Neutral_left_Occ = readmatrix([fpath 'SaN_MO_NG_Neutral_left_Occ.csv']);
% MO_NG_Neutral_right_Occ = readmatrix([fpath 'SaN_MO_NG_Neutral_right_Occ.csv']);
% 
% MO_G_Left_left_Par = readmatrix([fpath 'SaN_MO_G_Left_left_Par.csv']);
% MO_G_Left_right_Par = readmatrix([fpath 'SaN_MO_G_Left_right_Par.csv']);
% MO_G_Left_left_Occ = readmatrix([fpath 'SaN_MO_G_Left_left_Occ.csv']);
% MO_G_Left_right_Occ = readmatrix([fpath 'SaN_MO_G_Left_right_Occ.csv']);
% 
% MO_G_Right_left_Par = readmatrix([fpath 'SaN_MO_G_Right_left_Par.csv']);
% MO_G_Right_right_Par = readmatrix([fpath 'SaN_MO_G_Right_right_Par.csv']);
% MO_G_Right_left_Occ = readmatrix([fpath 'SaN_MO_G_Right_left_Occ.csv']);
% MO_G_Right_right_Occ = readmatrix([fpath 'SaN_MO_G_Right_right_Occ.csv']);
% 
% MO_G_Neutral_left_Par = readmatrix([fpath 'SaN_MO_G_Neutral_left_Par.csv']);
% MO_G_Neutral_right_Par = readmatrix([fpath 'SaN_MO_G_Neutral_right_Par.csv']);
% MO_G_Neutral_left_Occ = readmatrix([fpath 'SaN_MO_G_Neutral_left_Occ.csv']);
% MO_G_Neutral_right_Occ = readmatrix([fpath 'SaN_MO_G_Neutral_right_Occ.csv']);

%% SUBTRACT SPATIAL AGAINST NEUTRAL

NG_Left_LP = NG_Left_left_Par - NG_Neutral_left_Par;
NG_Left_RP = NG_Left_right_Par - NG_Neutral_right_Par;
NG_Left_LO = NG_Left_left_Occ - NG_Neutral_left_Occ;
NG_Left_RO = NG_Left_right_Occ - NG_Neutral_right_Occ;

NG_Right_LP = NG_Right_left_Par - NG_Neutral_left_Par;
NG_Right_RP = NG_Right_right_Par - NG_Neutral_right_Par;
NG_Right_LO = NG_Right_left_Occ - NG_Neutral_left_Occ;
NG_Right_RO = NG_Right_right_Occ - NG_Neutral_right_Occ;

G_Left_LP = G_Left_left_Par - G_Neutral_left_Par;
G_Left_RP = G_Left_right_Par - G_Neutral_right_Par;
G_Left_LO = G_Left_left_Occ - G_Neutral_left_Occ;
G_Left_RO = G_Left_right_Occ - G_Neutral_right_Occ;

G_Right_LP = G_Right_left_Par - G_Neutral_left_Par;
G_Right_RP = G_Right_right_Par - G_Neutral_right_Par;
G_Right_LO = G_Right_left_Occ - G_Neutral_left_Occ;
G_Right_RO = G_Right_right_Occ - G_Neutral_right_Occ;

dat = {NG_Left_LP, NG_Left_RP, NG_Left_LO, NG_Left_RO, NG_Right_LP, NG_Right_RP, NG_Right_LO, NG_Right_RO, ...
       G_Left_LP, G_Left_RP, G_Left_LO, G_Left_RO, G_Right_LP, G_Right_RP, G_Right_LO, G_Right_RO};

%% Plot image


for i = 1:length(dat)

% Create figure input matrix to plot
    figure; 
    x = [ersptimes(1) ersptimes(end)];
    y = [erspfreqs(1) erspfreqs(end)];
    imagesc(x, y, dataAvgMean);hold on
    % Mark freq and time of interest (-10 and -5 for lines to fit in figuer)
    plot([ersptimes(minTime) ersptimes(maxTime)-10], [erspfreqs(minFreq) erspfreqs(minFreq)], '--', 'linewidth', 2, 'color', 'k'); % Bottom
    plot([ersptimes(minTime) ersptimes(maxTime)-10], [erspfreqs(maxFreq) erspfreqs(maxFreq)], '--', 'linewidth', 2, 'color', 'k'); % Top
    plot([ersptimes(minTime) ersptimes(minTime)], [erspfreqs(minFreq) erspfreqs(maxFreq)], '--', 'linewidth', 2, 'color', 'k'); % Left
    plot([ersptimes(maxTime)-5 ersptimes(maxTime)-5], [erspfreqs(minFreq) erspfreqs(maxFreq)], '--', 'linewidth', 2, 'color', 'k'); % Right
    clim([-3 3]);
    % flip matrix, set x and y axis, just in case image is flipped
    axis xy;
    % Change colour
    colormap(jet);
    % set colour bar for scale
    c = colorbar;
    title(c, 'dB');
    
    % Titles
    if isequal(dat{i}, dat{1})
        t = 'NG_Left_LP';
    elseif isequal(dat{i}, dat{2})
        t = 'NG_Left_RP';
    elseif isequal(dat{i}, dat{3}) 
        t = 'NG_Left_LO';
    elseif isequal(dat{i}, dat{4})
        t = 'NG_Left_RO';
    elseif isequal(dat{i}, dat{5})
        t = 'NG_Right_LP';
    elseif isequal(dat{i}, dat{6})
        t = 'NG_Right_RP';
    elseif isequal(dat{i}, dat{7})
        t = 'NG_Right_LO';
    elseif isequal(dat{i}, dat{8})
        t = 'NG_Right_RO';
    elseif isequal(dat{i}, dat{9})
        t = 'G_Left_LP';
    elseif isequal(dat{i}, dat{10})
        t = 'G_Left_RP';
    elseif isequal(dat{i}, dat{11})
        t = 'G_Left_LO';
    elseif isequal(dat{i}, dat{12})
        t = 'G_Left_RO';
    elseif isequal(dat{i}, dat{13})
        t = 'G_Right_LP';
    elseif isequal(dat{i}, dat{14})
        t = 'G_Right_RP';
    elseif isequal(dat{i}, dat{15})
        t = 'G_Right_LO';
    elseif isequal(dat{i}, dat{16})
        t = 'G_Right_RO';
    end
    title(t);

    xlabel('Time (ms)');
    ylabel('Frequency (Hz)');
    fontsize(12, 'points');
    
    hold off
    
    % % save fugrue
    fpath = 'C:\MATLAB\exp_1\results\plots';
    saveas(gca, fullfile(fpath, condChan), 'jpg');
    % saveas(gca, [condChan '.jpg']);
end














