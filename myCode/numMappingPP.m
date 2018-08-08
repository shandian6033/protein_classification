function [ numSeq ] = numMappingPP( sq )
%NUMMAPPINGREAL Summary of this function goes here
%   Detailed explanation goes here
    len = length(sq);  
    numSeq = zeros(1,len,'double');
    for K = 1:len
       t = sq(K);
       if(strcmpi(t,'R'))
           numSeq(K) = 1;
       elseif(strcmpi(t,'H'))
           numSeq(K) = 2;
       elseif(strcmpi(t,'K'))
           numSeq(K) = 3; 
       elseif(strcmpi(t,'D'))
           numSeq(K) = 4;
       elseif(strcmpi(t,'E'))
           numSeq(K) = 5;
       elseif(strcmpi(t,'S'))
           numSeq(K) = 6;
       elseif(strcmpi(t,'T'))
           numSeq(K) = 7;
       elseif(strcmpi(t,'N'))
           numSeq(K) = 8;
       elseif(strcmpi(t,'Q'))
           numSeq(K) = 9;
       elseif(strcmpi(t,'C'))
           numSeq(K) = 10;
       elseif(strcmpi(t,'U'))
           numSeq(K) = 11;
       elseif(strcmpi(t,'G'))
           numSeq(K) = 12;
       elseif(strcmpi(t,'P'))
           numSeq(K) = 13;
       elseif(strcmpi(t,'A'))
           numSeq(K) = 14;
       elseif(strcmpi(t,'V'))
           numSeq(K) = 15;
       elseif(strcmpi(t,'I'))
           numSeq(K) = 16;
       elseif(strcmpi(t,'L'))
           numSeq(K) = 17;
       elseif(strcmpi(t,'M'))
           numSeq(K) = 18;
       elseif(strcmpi(t,'F'))
           numSeq(K) = 19;
       elseif(strcmpi(t,'Y'))
           numSeq(K) = 20;
       elseif(strcmpi(t,'W'))
           numSeq(K) = 21;
       end           
    end   
%     for K = 1:len
%        t = sq(K);
%        if(strcmpi(t,'R'))
%            numSeq(K) = 1;
%        elseif(strcmpi(t,'H'))
%            numSeq(K) = 1;
%        elseif(strcmpi(t,'K'))
%            numSeq(K) = 1; 
%        elseif(strcmpi(t,'D'))
%            numSeq(K) = 2;
%        elseif(strcmpi(t,'E'))
%            numSeq(K) = 2;
%        elseif(strcmpi(t,'S'))
%            numSeq(K) = 3;
%        elseif(strcmpi(t,'T'))
%            numSeq(K) = 3;
%        elseif(strcmpi(t,'N'))
%            numSeq(K) = 3;
%        elseif(strcmpi(t,'Q'))
%            numSeq(K) = 3;
%        elseif(strcmpi(t,'C'))
%            numSeq(K) = 4;
%        elseif(strcmpi(t,'U'))
%            numSeq(K) = 4;
%        elseif(strcmpi(t,'G'))
%            numSeq(K) = 4;
%        elseif(strcmpi(t,'P'))
%            numSeq(K) = 4;
%        elseif(strcmpi(t,'A'))
%            numSeq(K) = 5;
%        elseif(strcmpi(t,'V'))
%            numSeq(K) = 5;
%        elseif(strcmpi(t,'I'))
%            numSeq(K) = 5;
%        elseif(strcmpi(t,'L'))
%            numSeq(K) = 5;
%        elseif(strcmpi(t,'M'))
%            numSeq(K) = 5;
%        elseif(strcmpi(t,'F'))
%            numSeq(K) = 5;
%        elseif(strcmpi(t,'Y'))
%            numSeq(K) = 5;
%        elseif(strcmpi(t,'W'))
%            numSeq(K) = 5;
%        end           
%    end     
end

