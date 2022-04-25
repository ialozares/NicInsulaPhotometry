%% Isis Alonso-Lozares 04-04-22 
% A script to make changes in traces, combine them, or add extra info
%conditional on other traces (e.g. magazine entry during CS+ or CS-)
%Column1 = time stamp for events
%column 2= type of response (active = 1, nic = 2, inac = 3, pun = 4)
%column3 = (to take Timeout = 1, afterrespon = 2)

clear all
close all

%% define where the stuff is
exp = 'Nic14_b'; %experiment
tankfolder = 'F:\Analysis\';
type = 'TESTS'; %type of session - if no type leave []
ses_num = 1;
r = 'R6'; %rat number
time = [-5, 10]; %limits for trace making 

%% define timestamps you wanna work with
var1 = 'Ac';
var2 = 'In';
var3 = 'Re';
var4 = 'Sh';

%% load individual session data 
files = dir(fullfile(tankfolder, exp, type));
files(ismember({files.name}, {'.', '..'})) = [];
for i = 1:length(files) %iterate through experiment folder
   if isfile(fullfile(tankfolder, exp, type, [exp ' ' type ' session ' num2str(ses_num) ' data ' r  '.mat']))
           load(fullfile(tankfolder, exp, type,  [exp ' ' type ' session ' num2str(ses_num) ' data ' r  '.mat']))

if isempty(var4)
           v1 = cell2mat(sesdat.events(contains(sesdat.events(:,1), var1) | contains(sesdat.events(:,1), var2), 2));  
           c1 = cell2mat(sesdat.events(contains(sesdat.events(:,1), var3), 2));   %condition1        

for k = 1:length(C1(:,1))
    for j = 1:length(V1(:,1))
        if V1(k, 1) < C1(j, 1)
            if V1(k+1,1) < V1(k, 1)+5
                V1(k,2) 
                
for k = 1:length(C1(:,1))
    for j = 1:length(V1(:,1))
        if V1(k, 1) < C1(j, 1)
            if V1(k+1,1) < V1(k, 1)+5
                V1(k,2)
            continue
        elseif mag(k, 1) >= cond(j, 1)+15 && mag(k,1) <= (cond(j, 1) +40) && cond(j,4) == 0
            cond(j,3) =2;
            cond(j,4) = mag(k,1);
            mag(k, 3) = 2;
            mag(k,2) = cond(j,2)+3;
        elseif mag(k, 1) >= cond(j, 1) && mag(k,1) <= (cond(j, 1)+14) && cond(j,4) == 0
            cond(j,3) =1; 
            mag(k, 3) = 1;
            cond(j,4) = mag(k,1);
            mag(k,2) = cond(j,2)+3;
        end
    end      
end

else  
    c2 = cell2mat(sesdat.events(contains(sesdat.events(:,1), var4), 2)); %condition2

end


 sesdat.conversion = conversion;
 sesdat.ts = ts;
sesdat.hemi = 'Left';
sesdat.traces = ev;
sesdat.rat = r;
sesdat.phase = type;
sesdat.dat = lp_normDat;
% sesdat.cond = cond;
save([tankfolder '\' exp '\' type '\' exp ' session ' num2str(ses_num) ' data ' r '.mat'], 'sesdat')
  ses_num = ses_num + 1; 
   else
        ses_num = ses_num + 1; 
   end
end