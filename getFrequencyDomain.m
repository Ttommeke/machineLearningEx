function [ f25, f75 ] = getFrequencyDomain( data )
%GETFREQUENCYDOMAIN Summary of this function goes here
%   Detailed explanation goes here
    AmplitudeData = RemoveDCComponent(data);
    [f25, f75] = F25F75(AmplitudeData, 32);
end

