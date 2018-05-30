function [newFeatureArray] = createPolynominalFeatures(featureArray)
%CREATEPOLYNOMINALFEATURES Summary of this function goes here
%   Detailed explanation goes here
    X1 = featureArray(:, 2);    
    X2 = X1.^2;
    X3 = X1.^3;
    X4 = X1.^4;
    X5 = X1.^5;
    X6 = X1.^6;
    
    Y1 = featureArray(:, 3);
    Y2 = Y1.^2;
    Y3 = Y1.^3;
    Y4 = Y1.^4;
    Y5 = Y1.^5;
    Y6 = Y1.^6;
    
    X1Y1 = X1.*Y1;
    X2Y1 = X2.*Y1;
    X3Y1 = X3.*Y1;
    X4Y1 = X4.*Y1;
    X5Y1 = X5.*Y1;
    
    X1Y2 = X1.*Y2;
    X1Y3 = X1.*Y3;
    X1Y4 = X1.*Y4;
    X1Y5 = X1.*Y5;
    
    X2Y2 = X2.*Y2;
    X3Y2 = X3.*Y2;
    X4Y2 = X4.*Y2;
    
    X2Y3 = X2.*Y3;
    X2Y4 = X2.*Y4;
    
    X3Y3 = X3.*Y3;
    
    the1 = ones(length(X1), 1);
    
    newFeatureArray = [ ...
        the1,   X1,   X2,   X3,   X4,   X5,   X6, ...
          Y1,   Y2,   Y3,   Y4,   Y5,   Y6, ...
        X1Y1, X2Y1, X3Y1, X4Y1, X5Y1, ...
        X1Y2, X1Y3, X1Y4, X1Y5, ...
        X2Y2, X3Y2, X4Y2, ...
        X2Y3, X2Y4, ...
        X3Y3 ...
    ];

end

