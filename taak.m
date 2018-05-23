%% overhead file for control and calling smaller functions

%first step load data
data= openFilesFromDir('Brush_teeth');
[training,validation,testing]= divideAndConquer(data);

