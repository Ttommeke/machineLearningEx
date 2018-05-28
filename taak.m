%% overhead file for control and calling smaller functions

%first step load data
data= openFilesFromDir('Drink_glass');
%% exercise 1

%1.1: preprocessing
[training,validation,testing]= divideAndConquer(data);

%1.2: feature extraction -> this is for one instance in the subfolder, we
%need to evaluate ALL of the files
%gravity = getGravity(training{1}); %1.2.1
[grav] = getGravity(training{1}); %1.2.1
ampdata = GetAmplitudeOfAcceleration(training{1}); %1.2.2 we only need this for intermediate results
nodc = RemoveDCComponent(training{1}); %1.2.3
[stdev,skew] = timeDomainFeatures(training{1}); %1.2.4
[f25, f75] = getFrequencyDomain(training{1}); %1.2.5


%features we should have now:
%x=[gx,gy,gz,stdev,skewness, F25, F75]
getFeatures(training{2})

%1.3 feature selection: 

%% exercise 2 
%2.1 cost function and gradient
%2.2 linear model with 2 features
%2.3 polynomial features from 2 features
%2.4 linear classifier with 7 features
%2.5 non-linear classifier with 7 features


