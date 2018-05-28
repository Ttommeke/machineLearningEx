function [ allSamples ] = openFilesNotFromDir( subdir )
%READNONDRINKGLASSEXAMPLES Summary of this function goes here
%   Detailed explanation goes here
    allDirs = dir('./HMP_Dataset/*');
    allSamples = {};
    for i = 3:length(allDirs)
        if strcmp(allDirs(i).name, subdir)
            samples = openFilesFromDir(allDirs(i).name);
            allSamples = [allSamples ; samples];
        end
    end

end