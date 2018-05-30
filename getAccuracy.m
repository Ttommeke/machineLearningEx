function [accuracy] = getAccuracy(x, y, theta)
%GETACCURACY Summary of this function goes here
%   Detailed explanation goes here
    accuracy = 0;

    prediction = predict(theta, x);
    for i = 1:size(x, 1)
        if prediction(i) == y(i)
            accuracy = accuracy + 1;
        end
    end
    
    accuracy = accuracy/size(x, 1);
end

