%% B) Group

% allC =  {'participant_4','participant_5', 'participant_6', 'participant_8', ...
%          'participant_12', 'participant_13', 'participant_14', 'participant_15', ...
%          'participant_16', 'participant_18', 'participant_19'};
% allMA = {'participant_7', 'participant_9', 'participant_11', 'participant_20'};
% allMO = {'participant_2', 'participant_3', 'participant_10','participant_17'};

tes =  {'participant_18'};
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

condChan = [condTitle '_' chanTitle];
