%% this function evaluates one data sample (input) and returns the feature vector for that sample
%feature vector should look like this: [gx,gy,gz,stdev,skewness, F25,F75]
function [featureVector] = getFeatures(input)

gravity = getGravity(input); %1.2.1
ampdata = GetAmplitudeOfAcceleration(input); %1.2.2 we only need this for intermediate results
nodc = RemoveDCComponent(input); %1.2.3
[stdev,skew] = timeDomainFeatures(input); %1.2.4
[f25, f75] = getFrequencyDomain(input); %1.2.5
featureVector = [gravity(1), gravity(2), gravity(3), stdev, skew, f25, f75];
end