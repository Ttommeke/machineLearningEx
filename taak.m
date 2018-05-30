%% overhead file for control and calling smaller functions

%first step load data
data= openFilesFromDir('Drink_glass');
nondata = openFilesNotFromDir('Drink_glass');

%% exercise 1

%1.1: preprocessing
[training,validation,testing]= divideAndConquer(data);
[trainingFalse,validationFalse,testingFalse]= divideAndConquer(nondata);

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
X = getFeatures(training{2}); % example for testing



%1.3 feature selection: 

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
%gplotmatrix(X,[],G,['b' 'r'],[],[],'on',[],varNames,varNames);

% best features -> stdev & F25


%% exercise 2 
%2.1 cost function and gradient
% preparing input data and classifier labels
preparedX = [singleX(:, [1,4]); X2(:, [1,4])];
preparedY = [ones(length(singleX),1); zeros(length(X2),1)];

plottingX = preparedX;
plottingY = preparedY;
% note: need to transform this to training data sets later

%plotData(plottingX, plottingY);

[m, n] = size(preparedX);
preparedX = [ones(m, 1) preparedX];
initial_theta = zeros(n + 1, 1);
%%initial_theta = rand(n + 1,1)*5;
%%initial_theta = [0;-1;0];
lambda = 0;

[cost, grad] = costFunctionReg(initial_theta, preparedX, preparedY, lambda);
fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', grad);

options = optimset('GradObj', 'on', 'MaxIter', 400);
[theta, cost, exit_flag] = fminunc(@(t)(costFunctionReg(t, preparedX, preparedY, 0)), initial_theta, options);

fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('theta: \n');
fprintf(' %f \n', theta);

% Plot Boundary
plotDecisionBoundary(theta, preparedX, plottingY);


%2.2 linear model with 2 features

%trainingFeatures = cellfun(@getFeatures,training,'UniformOutput',0);
%trainingFeatures = vertcat(trainingFeatures{:});

%trainingX= trainingFeatures(:,[4,6]), trainingY= ones(size(trainingX,1),1);

%  Set options for fminunc
%options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
%[theta, cost] = fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

% Print theta to screen
%fprintf('Cost at theta found by fminunc: %f\n', cost);
%fprintf('theta: \n');
%fprintf(' %f \n', theta);

% Plot Boundary
%plotDecisionBoundary(theta, X, y);

% Chiel


%2.3 polynomial features from 2 features
X = plottingX; y = preparedY;

X = mapFeature(X(:, 1), X(:, 2));
[m,n] = size(X);
initial_theta = zeros(n, 1);
lambda = 0;

options = optimset('GradObj', 'on', 'MaxIter', 2000);
[theta, cost, exit_flag] = fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

%fprintf('Cost at theta found by fminunc: %f\n', cost);
%fprintf('theta: \n');
%fprintf(' %f \n', theta);

plotDecisionBoundary(theta, X, y);

%2.4 linear classifier with 7 features
%2.5 non-linear classifier with 7 features


