%% load in data first
function [allSamples] = openFilesFromDir(subdir)
    files= dir(strcat('.\HMP_Dataset\',subdir,'\A*.txt'));
    L = length(files); %% number of files to read
    allSamples{L}=[]; %% create empty 1 x L cell Array

    for i = 1:L
        data = textread([strcat('.\HMP_Dataset\', subdir, '\'), files(i).name]);
        allSamples{i}=dataToRealValues(data); % !!! -> {} to access values inside cell arrays
    end
end