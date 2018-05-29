%% overhead file for control and calling smaller functions

%first step load data
data= openFilesFromDir('Drink_glass');
nondata = openFilesNotFromDir('Drink_glass');
%nondata = openFilesFromDir('Comb_hair');
%size(nondata)
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
G(:,1) = 'drink\_glass';

X2=cellfun(@getFeatures,nondata,'UniformOutput',0); % extract features from nondata 
X2 = vertcat(X2{:}); % convert ugly resulting cellArray to beautiful useful feature Array/vector

G2 = strings(size(X2,1),1);
G2(:,1) = 'comb\_hair';

X= [X;X2];
G= [G;G2];
% now we need other samples as well

varNames = {'gx'; 'gy'; 'gz'; 'stdev'; 'skewness'; 'F25'; 'F75'};

% code below doesn't work yet
%figure
gplotmatrix(X,[],G,['b' 'r'],[],[],false);

%% exercise 2 
%2.1 cost function and gradient

%2.2 linear model with 2 features
%2.3 polynomial features from 2 features
%2.4 linear classifier with 7 features
%2.5 non-linear classifier with 7 features


