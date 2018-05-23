%% overhead file for control and calling smaller functions

%first step load data
data= openFilesFromDir('Brush_teeth');
[training,validation,testing]= divideAndConquer(data);

Gravity = getGravity(training{1});
[stdev,skew] = timeDomainFeatures(training{1});