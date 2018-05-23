function [training,validation,testing] = divideAndConquer(data)
    % divide data into 40%/30%/30% randomly
    datasetlength = (size(data));
    datasetlength= datasetlength(2);
    randomlist= randperm(datasetlength);

    training={};
    validation={};
    testing={};

    for i=1:datasetlength
        if randomlist(i)<=0.4*datasetlength
           training{end+1}=(data{i}); 
        elseif randomlist(i)<=0.7*datasetlength
            validation{end+1}=(data{i});
        else
            testing{end+1}=(data{i});
        end
    end
end