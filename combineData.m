%% Isis Alonso-Lozares 16-06-21 script to combine data from different animals

%% define where the stuff is
% exp = 'Nic14'; 
tankfolder = 'C:\Users\Isis\surfdrive\1_Experiments\Nic photometry\Data\extractedData240821';
type = 'All SA sessions data';
allDat = cell(1,1);

files = dir(fullfile(tankfolder));
files(ismember({files.name}, {'.', '..'})) = [];
for i = 1:length(files) %iterate through experiment folder
%     if strfind(files(i).name, rat)
%        clear left right
   if isfile(type)
           load(type)
   allDat{1,i} = dat;
   end
end

   SArew = [];
   SAac = [];
   SAinac = [];
   PUNrew = [];
   PUNac = [];
   PUNinac = [];
   PUNpn = [];
   TESTrew = [];
   TESTac = [];
   TESTinac = [];


for l = 1:size(dat, 2)
   SArew = [SArew; dat{1, l}.rew];
   SAac = [SAac; dat{1, l}.ac];
   SAinac = [SAinac; dat{1,l}.inac];
   PUNrew = [PUNrew; dat{2, l}.rew];
   PUNac = [PUNac; dat{2, l}.ac];
   PUNinac = [PUNinac; dat{2,l}.inac];
   PUNpn = [PUNpn; dat{2,l}.pun];
   TESTrew = [TESTrew; dat{3, l}.rew];
   TESTac = [TESTac; dat{3, l}.ac];
   TESTinac = [TESTinac; dat{3,l}.inac];

end           