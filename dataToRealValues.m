%% load in data first
function [adjustedData] = dataToRealValues(data)
    L = size(data(1));
    % 1.5g = 1.5*9.81 = 14.709
    
    X= -14.709+ data(:,1)/63 * (2*14.709); % 1xL matrix
    Y= -14.709+ data(:,2)/63 * (2*14.709); % 1xL matrix
    Z= -14.709+ data(:,3)/63 * (2*14.709); % 1xL matrix
    
    
    adjustedData = [X,Y,Z]; % 3xL matrix
end