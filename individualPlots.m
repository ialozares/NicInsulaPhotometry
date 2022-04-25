for k = 1:size(allDat,1)
for i = 1:size(allDat, 2)
m = figure;
subplot(4,1,1)
imagesc(time, 1:size(allDat{k, i}.ac), allDat{k, i}.ac)
vline(0, 'k')
title(['active nosepokes ' allDat{k,i}.rat ' phase ' allDat{k,i}.phase ' hemi ' allDat{k,i}.hemi])
subplot(4,1,2)
imagesc(time, 1:size(allDat{k, i}.inac), allDat{k, i}.inac)
vline(0, 'k')
title(['inactive nosepokes ' allDat{k,i}.rat ' phase ' allDat{k,i}.phase ' hemi ' allDat{k,i}.hemi])
subplot(4,1,3)
imagesc(time, 1:size(allDat{k, i}.rew), allDat{k, i}.rew)
vline(0, 'k')
title(['rewarded nosepokes ' allDat{k,i}.rat ' phase ' allDat{k,i}.phase ' hemi ' allDat{k,i}.hemi])
if ~isempty(allDat{k,i}.pun)
    subplot(4,1,4)
imagesc(time, 1:size(allDat{k, i}.pun), allDat{k, i}.pun)
vline(0, 'k')
title(['punished nosepokes ' allDat{k,i}.rat ' phase ' allDat{k,i}.phase ' hemi ' allDat{k,i}.hemi])
end
set(findobj(gcf,'type','axes'), 'FontName', 'Helvetica',  'clim', [-5 5])
    saveas(m, ['C:\Users\Isis\surfdrive\1_Experiments\Nic photometry\IndividualTrials\' allDat{k,i}.rat ' phase ' allDat{k,i}.phase ' hemi ' allDat{k,i}.hemi ' exp ' allDat{k,i}.exp '.fig'])
    saveas(m, ['C:\Users\Isis\surfdrive\1_Experiments\Nic photometry\IndividualTrials\'  allDat{k,i}.rat ' phase ' allDat{k,i}.phase ' hemi ' allDat{k,i}.hemi ' exp ' allDat{k,i}.exp  '.png'])
close all
end
end