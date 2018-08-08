close all;
clear all;
clc;
dataBase = pwd;
selectedFolder = 'SCOP';
path = strcat(dataBase,'\',selectedFolder);
folderInfo = dir (path);

Seq = {};
AcNmb = {};
clusterNames = {};
pointsPerCluster = {};
numberOfClusters = length(folderInfo)-2;

%reading fasta files

    for i=3:length(folderInfo)
        cd(path);
        subFolderPath = strcat(path,'/',folderInfo(i).name);
        subFolderInfo = dir(subFolderPath);
        cd(subFolderPath);
        clusterNames = [clusterNames folderInfo(i).name];
        points=length(subFolderInfo)-2;
    
        for j=3:length(subFolderInfo)
             [Header, Sequence] = fastaread(subFolderInfo(j).name);    
             Sequence = regexprep(Sequence,'[^R,^H,^K,^D,^E,^S,^T,^N,^Q,^C,^U,^G,^P,^A,^V,^I,^L,^M,^F,^Y,^W]','','ignorecase');
             Seq = [Seq Sequence];
             AcNmb = [AcNmb Header(1:9)]; 
        end
        pointsPerCluster = [pointsPerCluster points];   
end

cd(dataBase);
totalSeq = length(Seq);

nmValSH=cell(1,totalSeq);
f=cell(1,totalSeq);
lg=cell(1,totalSeq);
maxLen=0;

for a = 1:totalSeq
    if(length(Seq{a})>maxLen)
       maxLen = length(Seq{a});
    end   
end

minLen=500000;
for a = 1:totalSeq
    if(length(Seq{a})<minLen)
       minLen = length(Seq{a});
    end   
end
%mean length
meanLen = 0;
for a = 1:totalSeq
   meanLen=meanLen+length(Seq{a});
end  
meanLen=round(meanLen/totalSeq);

%upsample/trim to median length
lenAry = cell(1,totalSeq);
for a = 1:totalSeq
   lenAry{a}=length(Seq{a});
end  
mLen=round(median(cell2mat(lenAry)));

parfor a = 1:totalSeq
    nmValSH{a} = numMappingPP(Seq{a});
    ns = nmValSH{a};
    nsLen = length(ns);
    I = mLen-nsLen;
    if(I>0)
        nsTemp = wextend('1','asym',ns,I);
        nsNew = nsTemp((I+1):length(nsTemp));
    elseif(I<0)
        nsNew=ns(1:mLen);
    else
        nsNew = ns;
    end
    f{a} = fft(nsNew);
    lg{a} = abs(f{a});   
end


%distance calculation
fm=cell2mat(lg(:));
disMat = f_dis(fm,'cor',0,1);


[Y,eigvals] = cmdscale(disMat);
index=1;
counter=1;
Cluster = zeros(1,totalSeq);
for i=1:totalSeq   
    Cluster(i)=index;
    if(counter==pointsPerCluster{index})
        index=index+1;
        counter=0;
    end
    counter= counter+1;
end
uniqueClusters  = unique(Cluster);
cmap = distinguishable_colors(numberOfClusters);
hf = figure;
hold on;
for h=1:numberOfClusters
    cIndex = Cluster == uniqueClusters(h);
    plot3(Y(cIndex,1),Y(cIndex,2),Y(cIndex,3),'.','markersize', 15, 'Color',cmap(h,:),'DisplayName',clusterNames{h});
end
view(3), axis vis3d, box on, datacursormode on%rotate3d on
xlabel('x'), ylabel('y'), zlabel('z')
tname = strcat(selectedFolder,' -(',int2str(totalSeq),') ','Sequences');
title(tname)
hdt = datacursormode(hf);
set(hdt,'UpdateFcn',{@myupdatefcn,Y,AcNmb})
legend('show');

%classification
%add col
    clear a;
    a=[];
    for i=1:numberOfClusters
        for j=1:pointsPerCluster{i}
            a=[a; i];
        end
    end
    ATestlg = [disMat a];
    rng(15,'twister');
    
    Atest = fm.';
    id = mLen+1;
    Atest(id,:) = a.';
    ATest = [fm a];
    alabels = a;
    classScript;
