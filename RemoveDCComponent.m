function [ result ] = RemoveDCComponent( data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    r = GetAmplitudeOfAcceleration(data);
    result = r - mean(r);

end

