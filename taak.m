%% overhead file for control and calling smaller functions

%first step load data
data= openFilesFromDir('Drink_glass');
nondata = openFilesNotFromDir('Drink_glass');

%% exercise 1

%% 1.1: preprocessing
[trainingTrue,validationTrue,testingTrue]= divideAndConquer(data); % positive training data
[trainingFalse,validationFalse,testingFalse]= divideAndConquer(nondata); % negative training data

%1.2: feature extraction -> this is for one instance in the subfolder, we
%need to evaluate ALL of the files
%gravity = getGravity(training{1}); %1.2.1
[grav] = getGravity(trainingTrue{1}); %1.2.1
ampdata = GetAmplitudeOfAcceleration(trainingTrue{1}); %1.2.2 we only need this for intermediate results
nodc = RemoveDCComponent(trainingTrue{1}); %1.2.3
[stdev,skew] = timeDomainFeatures(trainingTrue{1}); %1.2.4
[f25, f75] = getFrequencyDomain(trainingTrue{1}); %1.2.5


%features we should have now:
%x=[gx,gy,gz,stdev,skewness, F25, F75]
;
%X = getFeatures(trainingTrue{2}); % example for testing

%% 1.3 feature selection: 
% get feature vector for training set
trainingTrue = cellfun(@getFeatures,trainingTrue,'UniformOutput',0);
trainingTrue = vertcat(trainingTrue{:});
trainingFalse = cellfun(@getFeatures,trainingFalse,'UniformOutput',0);
trainingFalse = vertcat(trainingFalse{:});
trainingX = [trainingTrue; trainingFalse];

% get feature vector for validation data
validationTrue = cellfun(@getFeatures,validationTrue,'UniformOutput',0);
validationTrue = vertcat(validationTrue{:});
validationFalse = cellfun(@getFeatures,validationFalse,'UniformOutput',0);
validationFalse = vertcat(validationFalse{:});
validationX = [validationTrue; validationFalse];

% get feature vector for testing data
testingTrue = cellfun(@getFeatures,testingTrue,'UniformOutput',0);
testingTrue = vertcat(testingTrue{:});
testingFalse = cellfun(@getFeatures,testingFalse,'UniformOutput',0);
testingFalse = vertcat(testingFalse{:});
testingX = [testingTrue; testingFalse];

% label positive and negative data accordingly
trainingY = [ones(length(trainingTrue),1); zeros(length(trainingFalse),1)];
validationY = [ones(length(validationTrue),1); zeros(length(validationFalse),1)];
testingY = [ones(length(testingTrue),1); zeros(length(testingFalse),1)];


% create feature vector -> for training data set 
singleX = cellfun(@getFeatures,data,'UniformOutput',0); % extract features from data 
singleX = vertcat(singleX{:}); % convert ugly resulting cellArray to beautiful useful feature Array/vector

% creating a group vector
G = strings(size(singleX,1),1);
G(:,1) = 'drink glass';

X2=cellfun(@getFeatures,nondata,'UniformOutput',0); % extract features from nondata 
X2 = vertcat(X2{:}); % convert ugly resulting cellArray to beautiful useful feature Array/vector

G2 = strings(size(X2,1),1);
G2(:,1) = 'not drink glass';

X= [singleX;X2];
G= [G;G2];

% now we need other samples as well
varNames = {'gx'; 'gy'; 'gz'; 'stdev'; 'skewness'; 'F25'; 'F75'};

% plot all features
close all,figure;
gplotmatrix(X,[],G,['b' 'r'],[],[],'on',[],varNames,varNames);
figure
gscatter(X(:,1),X(:,4),G,['b' 'r']);

% best features -> stdev & F25
% clean up workspace too
clear f25 f75 G G2 grav ampdata skew stdev;

%% exercise 2 
%2.1 cost function and gradient
%2.2 linear model with 2 features
% preparing input data and classifier labels
selectedTrainingDataX = trainingX(:, [1,4]); %% selecting features 1 and 4 -> feature space
[m, n] = size(selectedTrainingDataX);
selectedTrainingDataX = [ones(m, 1), selectedTrainingDataX]; %creating feature vector, including theta0

initial_theta = zeros(n + 1, 1); % initiating theta at zeros

% calculate cost at initial values
[cost, grad] = costFunction(initial_theta, selectedTrainingDataX, trainingY); % cost function without regularisation (lambda = 0)
fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', grad);

%calculate decision boundary for minimal cost using fminunc
options = optimoptions(@fminunc, 'GradObj', 'on', 'MaxIter', 1000);
[theta, cost, exit_flag] = fminunc(@(t)(costFunction(t, selectedTrainingDataX, trainingY)), initial_theta, options);

fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('theta: \n');
fprintf(' %f \n', theta);

% Plot training data points and decision boundary
plotData(selectedTrainingDataX(:,[2,end]), trainingY); % be careful which feature you choose for creating a scatterplot
plotDecisionBoundary(theta, selectedTrainingDataX, trainingY);

% Compute accuracy on our training set vs validation set
p = predict(theta, selectedTrainingDataX);
fprintf('Training Accuracy: %f\n', mean(double(p == trainingY)) * 100);

fprintf('polynomial: hit enter');
%pause;


%% 2.3 polynomial features from 2 features
% step 1: new hypothesis -> new feature space
% we need to update our feature space to include powers of the features

% use mapfeature to add quadratic features, also handles the intercept
% feature, we choose features number 1 and 4 from the training and
% validation data sets

order = 6; % polynomial degree/order

selectedTrainingDataX = mapFeature(trainingX(:, 1), trainingX(:, 4) , order);
selectedValidationDataX = mapFeature(validationX(:, 1), validationX(:, 4) , order);

initial_theta = zeros(size(selectedTrainingDataX,2), 1); % initiating theta at zeros

% run finding the best theta ONCE or something like that, running it on
% repeat makes the code illegible and the outut unusable
% optimal lambda is VERY large, need to check if this is okay
[bestTheta, bestLambda, bestAccuracy, lambdaVSTrainingAndValidation] = getBestLambda( selectedTrainingDataX, selectedValidationDataX, trainingY, validationY);

lambda = 0;

options = optimoptions(@fminunc, 'GradObj', 'on', 'MaxIter', 2000);
[theta, cost , ~] = fminunc(@(t)(costFunctionReg(t, selectedTrainingDataX, trainingY, lambda)), initial_theta, options);
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('lambda: %d \n', lambda);
%fprintf('theta: \n');
%fprintf(' %f \n', theta);

p = predict(theta, selectedTrainingDataX);
fprintf('Training Accuracy: %f\n', mean(double(p == trainingY)) * 100);

plotDecisionBoundary(bestTheta, selectedTrainingDataX, trainingY, order);
%plotDecisionBoundary(theta, selectedTrainingDataX, trainingY, order);

loglog(lambdaVSTrainingAndValidation(:,1),lambdaVSTrainingAndValidation(:,2),lambdaVSTrainingAndValidation(:,1),lambdaVSTrainingAndValidation(:,3))

lambda = 1;
options = optimoptions(@fminunc, 'GradObj', 'on', 'MaxIter', 2000);
[theta, cost , ~] = fminunc(@(t)(costFunctionReg(t, selectedTrainingDataX, trainingY, lambda)), initial_theta, options);
%plotExtraBoundary(selectedTrainingDataX,theta,lambda,order,'g');

fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('lambda: %d \n', lambda);
%fprintf('theta: \n');
%fprintf(' %f \n', theta);
p = predict(theta, selectedTrainingDataX);
fprintf('Training Accuracy: %f\n', mean(double(p == trainingY)) * 100);


lambda = 10;

options = optimoptions(@fminunc, 'GradObj', 'on', 'MaxIter', 2000);
[theta, cost , ~] = fminunc(@(t)(costFunctionReg(t, selectedTrainingDataX, trainingY, lambda)), initial_theta, options);
%plotExtraBoundary(selectedTrainingDataX,theta,lambda,order,'r');

fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('lambda: %d \n', lambda);
%fprintf('theta: \n');
%fprintf(' %f \n', theta);
p = predict(theta, selectedTrainingDataX);
fprintf('Training Accuracy: %f\n', mean(double(p == trainingY)) * 100);


%2.4 linear classifier with 7 features

fprintf('7 features: hit enter');
pause;

selectedTrainingDataX = trainingX;
selectedValidationDataX = validationX;

% only do this when neccesary
%[bestTheta, bestLambda, bestAccuracy, lambdaVSTrainingAndValidation] = getBestLambda( selectedTrainingDataX, selectedValidationDataX, trainingY, validationY);

%loglog(lambdaVSTrainingAndValidation(:,1),lambdaVSTrainingAndValidation(:,2),lambdaVSTrainingAndValidation(:,1),lambdaVSTrainingAndValidation(:,3))

fprintf('7 features polynomial: hit enter');
pause;

%2.5 non-linear classifier with 7 features
selectedTrainingDataX = trainingX;
selectedValidationDataX = validationX;
selectedTrainingDataX = x2fx(selectedTrainingDataX,'quadratic');
selectedValidationDataX = x2fx(selectedValidationDataX,'quadratic');

lambda = 1;
%[bestTheta, bestLambda, bestAccuracy, lambdaVSTrainingAndValidation] = getBestLambda( selectedTrainingDataX, selectedValidationDataX, trainingY, validationY);

size(selectedTrainingDataX)
%loglog(lambdaVSTrainingAndValidation(:,1),lambdaVSTrainingAndValidation(:,2),lambdaVSTrainingAndValidation(:,1),lambdaVSTrainingAndValidation(:,3))



