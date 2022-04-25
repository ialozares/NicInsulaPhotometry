%% Isis Alonso 18-11-20 photometry extraction script
%% This is the main extraction and plotting script for individual sessions
%it outputs a at file per session per animal, where you can find the
%downsampled and filtered data and traces 

clear all


%% define where the stuff is
exp = 'Nic14_b'; 
% rats = ({'R1_R7' ; 'R5_R9'; 'R6_R10'});
%the left or right set ups so make sure you know this before saving it 
%as the wrong rat :)
tankfolder = 'E:\Analysis\';
type = 'PUN';
rat = 'R1_R6';
time = [-5, 10]; %limits for trace making 
% if you want plots of all sessions at the end of the extraction
ses_num = 1;



%% pre-processing
res = 64; % resampling factor
lowpass_cutoff = [3]; %low-pass cut-off for Hz, e.g. 2
filt_steepness = .95; %how steep the filter transition is (0.5-1, default 0.85)
db_atten = 90; %decibel attenuation of filters (default = 60)
% base = 7; %baseline for z-scoring

%% individual session data extraction 
files = dir(fullfile(tankfolder, exp, type));
files(ismember({files.name}, {'.', '..'})) = [];
for i = 1:length(files) %iterate through experiment folder
%    for x =  1:length(rats) 
%        rat = cell2mat(rats(x));
    if strfind(files(i).name, rat)
%        if ~isfile(fullfile(tankfolder, exp, type, [ exp ' ' rat(1:2) ' ' sesdat.phase ' ' files(i).name(end-12:end-2) 'session data.mat']))...
%          ||  ~isfile(fullfile(tankfolder, exp, type, [ exp ' ' rat(5:) ' ' sesdat.phase ' ' files(i).name(end-12:end-2) 'session data.mat']))
          [data, events, ts, conversion] = Sim_TDTextract([tankfolder '\' exp '\'  type '\' files(i).name]); % extract data from both set ups
%% filterting and traces
for l = 1:2 %go through the rats
    if l == 1
        r = rat(4:5);
        side = 'L';
%         try
        filt490 = cell2mat(data(contains(data(:,1), side) & contains(data(:,1), '9'), 2)); %%changed for nic
        filt405 =cell2mat(data(contains(data(:,1), side) & contains(data(:,1), '5'), 2));
        ev = events(startsWith(events(:,1), side), :); 
%         catch
%              fprintf('No left side data')
%           break
%       end
    else
      r = rat(1:2); 
      side = 'R';
%      if contains(data(:,1), side) & contains(data(:,1), '7')
      filt490 = cell2mat(data(contains(data(:,1), side) & contains(data(:,1), '7'), 2));
      filt405 =cell2mat(data(contains(data(:,1), side) & contains(data(:,1), '5'), 2));
      ev = events(startsWith(events(:,1), side), :);
%      else
%           fprintf('No right side data')
%           break
%       end
    end 

% Fit control to signal and calculate DFF
cfFinal = controlfit(filt490, filt405);
normDat= deltaFF(filt490,cfFinal);

%Highpass filter and moving average...
[hp_normDat, mov_normDat] = hpFilter(ts, normDat);

%lowpassfilter 
lp_normDat = lpFilter(hp_normDat, conversion, lowpass_cutoff,...
    filt_steepness, db_atten);
figure
plot(lp_normDat)

sesdat.filt490 = filt490;
sesdat.filt405 = filt405;

%% Make traces...
if ~isempty(ev) %if events variable is not empty
n = 1;
for m = 1:size(ev, 1)
    tmp = cell2mat(ev(m, 2));
    for k = 1:size(tmp, 1)
        adjts = ceil(conversion*tmp(k, 1));
        try
        signal = lp_normDat(adjts-ceil(time(1)*conversion):adjts+ceil(time(end)*conversion))'; 
        tmp2(k, :) = signal;
        catch
        fprintf('Trace around the timestamp goes over length of session signal! Ommiting and deleting ts...\n')
            continue %jump to the iteration
        end
    end
    if exist('tmp2', 'var') 
        if size(tmp, 1) > size(tmp2, 1)
        tmp(end-(size(tmp, 1) - size(tmp2, 1))+1:end, :) = [];
        end 
        tmp(:,2) = ones*m; tmp(:,3:4) = zeros;
    ev{m,2} = [tmp , tmp2];
    clear tmp tmp2
    end
end
    
            
%save variables
if size(ev, 1) == 2 || size(ev, 1) == 1
sesdat.phase = 'Reward';
elseif size(ev,1) > 2
    sesdat.phase = 'Discrimination';
end
% sesdat.phase = type;
sesdat.session = ses_num; 
sesdat.rat = r;
sesdat.conversion = conversion;
sesdat.lp_normDat = lp_normDat; 
sesdat.events = ev;
sesdat.hemi = 'Right';
sesdat.phase = type;

% 
% save([tankfolder '\' exp '\' type '\' exp ' ' r ' ' sesdat.phase ' ' files(i).name(end-12:end-2) ' data.mat'], 'sesdat')
save([tankfolder '\' exp '\' exp ' ' type ' session ' num2str(ses_num) ' data ' r  '.mat'], 'sesdat')
clear sesdat
else 
     fprintf('No events for session! Skippint to next session \n')
    continue
end
end %end of rat block
           ses_num = ses_num +1;
end%end of session block
           close all
end 


 

