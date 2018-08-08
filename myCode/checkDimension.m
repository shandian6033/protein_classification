function [ newCm ] = checkDimension( cm, aLabel, pLabel, n)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
[x,y] = size(cm);
if(x==n && y==n)
    newCm = cm;
else
    
    %actual Matrix
%     actualCm = zeros(n,n);
%     [uvals, ~, uidx] = unique(aLabel);
%     output = [uvals, accumarray(uidx, 1)]
%     for i=1:length(output)
%         idx = output(i,1);
%         actualCm(idx,idx)=output(i,2);
%     end
    
    %newCm
    newCm = zeros(n,n);
    for i=1:n
        idx = find(aLabel==i);
        if(length(idx)==0)
            continue;            
        else
            temp = pLabel(idx);
            [uvals, ~, uidx] = unique(aLabel);
            output = [uvals, accumarray(uidx, 1)];
            [x,y]=size(output);
            for j=1:x
                 idx = output(j,1);
                 newCm(i,idx)=output(j,2);
            end
        end
    end


end

