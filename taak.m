%% overhead file for control and calling smaller functions

%first step load data
data= openFilesFromDir('Drink_glass');
[training,validation,testing]= divideAndConquer(data);

%GetAmplitudeOfAcceleration(training{1}); how to use