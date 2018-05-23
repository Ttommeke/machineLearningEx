%% load in data first
function [gx, gy, gz] = getGravity(data) % data contains l collumns of values
    [gx,gy,gz]= mean(data);    
end