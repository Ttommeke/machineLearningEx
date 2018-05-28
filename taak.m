%% overhead file for control and calling smaller functions

%first step load data
data= openFilesFromDir('Drink_glass');
%% exercise 1

%1.1: preprocessing
[training,validation,testing]= divideAndConquer(data);

%1.2: feature extraction
Gravity = getGravity(training{1}); %1.2.1
ampdata = GetAmplitudeOfAcceleration(training{1}); %1.2.2
nodc = RemoveDCComponent(training{1}); %1.2.3
[stdev,skew] = timeDomainFeatures(training{1}); %1.2.4
[f25, f75] = getFrequencyDomain(training{1}); %1.2.5

%1.3 feature selection: TODO

%% exercise 2 
%2.1 cost function and gradient
%2.2 linear model with 2 features
%2.3 polynomial features from 2 features
%2.4 linear classifier with 7 features
%2.5 non-linear classifier with 7 features


