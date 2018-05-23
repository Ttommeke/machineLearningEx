%% overhead file for control and calling smaller functions

%first step load data
data= openFilesFromDir('Drink_glass');
[training,validation,testing]= divideAndConquer(data);


Gravity = getGravity(training{1});
GetAmplitudeOfAcceleration(training{1});
[stdev,skew] = timeDomainFeatures(training{1});

RemoveDCComponent(training{1});
