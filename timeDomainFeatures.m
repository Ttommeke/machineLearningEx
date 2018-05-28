%% load in data first
function [stdev,skew] = timeDomainFeatures(data)
    stdev = std(sqrt( data(:,1).^2 + data(:,2).^2 + data(:,3).^2 ) );
    skew= skewness(data);
end