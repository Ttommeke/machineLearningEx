function [bestTheta, bestLambda, bestAccuracy, lambdaVSTrainingAndValidation] = getBestLambda( trainingX, validationX, trainingY, validationY)

    bestLambda = 3^(-10);
    bestTheta = [];
    bestAccuracy = 99999;
    
    [~,n] = size(trainingX);
    
    lambdaVSTrainingAndValidation = [0,0,0]
    
    for lambda = logspace(-10,10,100)
        initial_theta = zeros(n, 1);
        
        options = optimoptions(@fminunc, 'GradObj', 'on', 'MaxIter', 2000);
        [theta, cost, ~] = fminunc(@(t)(costFunctionReg(t, trainingX, trainingY, lambda)), initial_theta, options);
        
        accuracy = getAccuracy(validationX, validationY, theta);
        
        if bestAccuracy > accuracy
            bestAccuracy = accuracy;
            bestTheta = theta;
            bestLambda = lambda;
        end
        
        lambdaVSTrainingAndValidation = [lambdaVSTrainingAndValidation; ...
            [ lambda, getAccuracy(trainingX, trainingY, theta), getAccuracy(validationX, validationY, theta)] ];
    end

end