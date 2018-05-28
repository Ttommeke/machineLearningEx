%% load in data first
function [stdev,skew] = timeDomainFeatures(data)
    stdev = std(GetAmplitudeOfAcceleration(data) );
    skew= skewness(data);
end