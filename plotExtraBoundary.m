function plotExtraBoundary(X,theta,lambda,degree,color)
%PLOTEXTRABOUNDARY Plots the decision boundary defined by theta on top of
% another plot function which has already performed plotDecisonBoundary 
%   PLOTDECISIONBOUNDARY(theta, X,y) plots the data points with + for the 
%   positive examples and o for the negative examples. X is assumed to be 
%   a either 
%   1) Mx3 matrix, where the first column is an all-ones column for the 
%      intercept.
%   2) MxN, N>3 matrix, where the first column is all-ones

% Plot Data
hold on

if size(X, 2) <= 3
    % Only need 2 points to define a line, so choose two endpoints
    plot_x = [min(X(:,2))-1,  max(X(:,2))+1];

    % Calculate the decision boundary line
    plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));

    % Plot, and adjust axes for better viewing
    plot(plot_x, plot_y)
       
else
    % Here is the grid range
    u = linspace(min(X(:,2))-2, max(X(:,2))+1, 100); % values of x1, going from min to max
    v = linspace(min(X(:,3))-2, max(X(:,3))+1, 100); % values of x2, going from min to max

    z = zeros(length(u), length(v)); % points defined by decision boundary
    
    % Evaluate z = theta*x over the grid
    for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = mapFeature(u(i), v(j),degree)*theta; % plot grid point according to found theta
        end
    end
    z = z'; % important to transpose z before calling contour

    % Plot z = 0
    % Notice you need to specify the range [0, 0]
    legend('off');
    contour(u, v, z, [0, 0], 'LineWidth', 2,'LineColor',color,'DisplayName',sprintf('lambda= %d',lambda));
    lgd =  findobj('type','legend');
    legend('Location', 'best');
    
end
hold off

end
