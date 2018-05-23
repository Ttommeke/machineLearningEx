function [ result ] = GetAmplitudeOfAcceleration( data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    result = sqrt( data(:,1).^2 + data(:,2).^2 + data(:,3).^2 );

end

