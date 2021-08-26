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
Screen('Preference', 'SkipSyncTests', 0);
  oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
  oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);



% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens');

% To draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen.
screenNumber = max(screens);

%  Set wimdow in PsychToolbox
    whichScreen = 0; 
    window = Screen('OpenWindow', whichScreen);

    ifi = Screen ('GetFlipInterval', window);

% button presses
% Response Keys
key.left = 5;
key.right = 6;
key.esc = KbName('0)');

%Parallel port Setup
%Set up Parallel Port
%Much of these aren't related to our study

    allfalse = 0;
    imagePins = 1;
    testPins = 2;
    VerticalShift = 3;
    HorizontalShift = 4;
    ObliqueShift = 5;
    onsetPhaseShift = 16; %  Will not use these unless we define them as global
    onsetOrientPins = 32; %  Ditto
    trialEndPins = 99;
    trialStartPins = 100;
    EyesClosedStart=250;
    EyesClosedEnd=251;
    EyesOpenStart=252;
    EyesOpenEnd=253;

    ppdev_mex('Open', 1); %If this doesn't work...
    %Follow the steps in parallelPortHowTo



%% Participant information %%
%  User input GUI to get subject information
fileExists = 1;

 %{
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

  %}
%%START TRIAL? %%


%% Read in CSV File%%
 [GLTable] = readtable("GlobalLocalshort.csv");

 %imshow(myImage);
 fixcross = imread("fixcross.jpg");
 fiximg = Screen('MakeTexture', window, fixcross);
 
 Screen('FillRect', window);
 
% trials = find(GLTable, etc)

  % -------------Start-----------
    %lptwrite(1, trialStartPins);
for blk = 1: 1
    %Randomize 
    %Based on experiement number- pick which block goes first
    
    maxTrls = 5;
    for trl = 1:maxTrls
        
    %  load your trial stim file (see above)
      trlImage = string(GLTable{trl,2});
      StimImg = imread(trlImage);

    % Show fixation cross
    	Screen('DrawTexture', window, fiximg);
        Screen('Flip', window);  
        pause(0.7); 
    
    %  Show Stim image
       scrnImage = Screen('MakeTexture', window, StimImg);
       Screen('DrawTexture', window, scrnImage);       
       Screen('Flip', window);
       pause(0.7); 

    % Collect response
      % clrImage = Screen('MakeTexture', window, blankrect);
      %Screen('DrawTexture', window, clrImage);    
    Screen('Flip', window);
    KbWait;
  
    end
end

  fprintf("End of Exp\n");
  
  %  Prepare to exit
  sca;

  % Restores the mouse cursor.
  ShowCursor;

  % Restore preferences
  Screen('Preference', 'VisualDebugLevel', oldVisualDebugLevel);
  Screen('Preference', 'SuppressAllWarnings', oldSupressAllWarnings);