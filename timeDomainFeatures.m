%% load in data first
function [stdev,skew] = timeDomainFeatures(data)
    ampdata = GetAmplitudeOfAcceleration(data);
    stdev = std(ampdata);
    skew= skewness(ampdata);
end