%% load in data first
function [stdev,skew] = timeDomainFeatures(data)
    stdev = std(data);
    skew= skewness(data);
end