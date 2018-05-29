function [ allSamples ] = openFilesNotFromDir( subdir )
%READNONDRINKGLASSEXAMPLES Summary of this function goes here
%   Detailed explanation goes here
    allDirs = { 'Brush_teeth', 'Comb_hair', 'Drink_glass', 'Eat_meat', 'Eat_soup', 'Pour_water', 'Use_telephone'};
    allSamples = {};
    index = 1;
    allSamplesIndex = 1;
    for i = 1:length(allDirs)
        
        if strcmp(string(allDirs(i)), subdir)
            
        else
            samples = openFilesFromDir(allDirs{i});
            for j = 1:length(samples)
                allSamples{allSamplesIndex} = samples{j};
                
                allSamplesIndex = allSamplesIndex + 1;
            end
            
            index = index + 1;
        end
    end

end