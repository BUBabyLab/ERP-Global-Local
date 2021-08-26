%Fall 2021- Emily Blakley
%Script for Global Local ERP

%START%

%% Set up psychtoolbox here %%

% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens');

% To draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen.
screenNumber = max(screens);



% button presses
% Response Keys
key.left = 5;
key.right = 6;
key.esc = KbName('0)');
numGamepads = Gamepad('GetNumGamepads');
if numGamepads == 0
   error('NO GAMEPAD FOUND!');
end

%% Participant information %%
%  User input GUI to get subject information
fileExists = 1;
while fileExists == 1
    
    % Participant Information
    subjInfo = struct;
    title  = {'Subject#', 'Age', 'Gender (M/F)', 'Handedness (L/R)', 'Normal Vision? (Y/N)'};
    default = {'', '', '', '', ''};
    answer = inputdlg(title, 'Subj Info', 1, default);
    [subjInfo.subjnum, subjInfo.age, subjInfo.gender, subjInfo.hand, subjInfo.normvis] = deal(answer{:});
    
    % Experiment Versions
    versions = {'A' 'B' 'C' 'D'};
    [h, ok] = listdlg('PromptString', 'Experiment Version',...
        'SelectionMode', 'single',...
        'ListSize', [200 200],...
        'ListString', versions);
    
    %FIX VERSION TO ACTUALLY BE MEANINGFUL%
    %if ok == 1
    %    subjInfo.expVers  = versions{h};
    %    if h == 1
   %         subjInfo.col1   = 'pink';
   %         subjInfo.col2  = 'green';          
   %         subjInfo.targShape = 'circle';
   %     elseif h == 2
   %         subjInfo.col1   = 'pink';
   %         subjInfo.col2   = 'green';
   %         subjInfo.targShape = 'diamond';
    %    elseif h == 3
     %       subjInfo.col1   = 'orange';
     %       subjInfo.col2   = 'blue';
     %      subjInfo.targShape = 'circle';
     %   elseif h == 4
     %       subjInfo.col1   = 'orange';
     %       subjInfo.col2   = 'blue';
     %       subjInfo.targShape = 'diamond';
     %   end  
    %elseif ok == 0
     %   closeShop();
     %   return;
   % end
    
    % File Overwrite Protection 
    outFilename = ['data/', expName, '_', subjInfo.expVers, '_', subjInfo.subjnum, '.txt'];
    if strcmp(subjInfo.subjnum, '999') == 1
        delete(outFilename);
    end
    if exist(outFilename, 'file') == 2 && strcmp(subjInfo.subjnum, '999') ~= 1
        errMess = ['Participant #', subjInfo.subjnum,' already exists!',...
            '  Doublecheck the subject information.',...
            '  Try another participant # or experiment version.'];
        h = errordlg(errMess, 'Duplicate DataFile');
        waitfor(h);
    else fileExists = 0;
    end
    
end



%%START TRIAL? %%


%% Read in CSV File%%
 [GLScript] = csvread("GlobalLocal.csv")


%Data script 
%% Find command - find with a flag- randomize 

%%Load images?%%

%%Do ERP%%

%%END%%