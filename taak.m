%% overhead file for control and calling smaller functions

%first step load data
data= openFilesFromDir('Drink_glass');
nondata = openFilesNotFromDir('Drink_glass');

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
X = getFeatures(training{2}); % example for testing



%1.3 feature selection: 

% create feature vector -> for training data set 
X = cellfun(@getFeatures,data,'UniformOutput',0); % extract features from data 
X = vertcat(X{:}); % convert ugly resulting cellArray to beautiful useful feature Array/vector

% creating a group vector
G = strings(size(X,1),1);
G(:,1) = 'drink glass';

X2=cellfun(@getFeatures,nondata,'UniformOutput',0); % extract features from nondata 
X2 = vertcat(X2{:}); % convert ugly resulting cellArray to beautiful useful feature Array/vector

G2 = strings(size(X2,1),1);
G2(:,1) = 'not drink glass';

X= [X;X2];
G= [G;G2];
% now we need other samples as well

varNames = {'gx'; 'gy'; 'gz'; 'stdev'; 'skewness'; 'F25'; 'F75'};

% code below works now
close all,figure;
gplotmatrix(X,[],G,['b' 'r'],[],[],'on',[],varNames,varNames);

% best features -> stdev & F25

%% exercise 2 -> allemaal logistic regression
%2.1 cost function and gradient 
% sigmoid
% cost & gradient given h_theta(x) and Y
% 
% Tom

%2.2 linear model with 2 features
% first get a relevant training dataset
% getting started with the positive data.
trainingFeatures = cellfun(@getFeatures,training,'UniformOutput',0);
trainingFeatures = vertcat(trainingFeatures{:});

trainingX= trainingFeatures(:,[4,6]), trainingY= ones(size(trainingX,1),1);

% then we add the negatvie data 
% reuse ex2
% lambda = 0
% use training dataset to train and validation to check
% use fminunc
% Show a figure with the trainings dataset and the linear decision boundary
%  In this exercise, you will use a built-in function (fminunc) to find the
%  optimal parameters theta.

%  Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[theta, cost] = fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

% Print theta to screen
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('theta: \n');
fprintf(' %f \n', theta);

% Plot Boundary
plotDecisionBoundary(theta, X, y);

% Chiel


%2.3 polynomial features from 2 features


%2.4 linear classifier with 7 features
%2.5 non-linear classifier with 7 features


