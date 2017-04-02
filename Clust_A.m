clc
clear
% Data Vectors:
dataIn = dlmread('./dataForClustering.csv');
%E = dlmread('./q2_expected.csv');

% Define constraints
% Labels = {1,2,3}
% Euclidean
nclusters = 2;
distance = 'sqeuclidean';

%(initializing the options)%
opts = statset('Display','final');
[ID, sumd, ctrs] = kmeans(dataIn,nclusters, 'Distance', distance,....
    'Replicates', 5, 'Options', opts);
outClusterVector = fopen('exam_q4_outk_clusterVector.csv','w');
outSumD = fopen('exam_q4_outk_sumD.csv','w');
format = '%d,\n';
fprintf(outClusterVector, format,  ID);
format = '%d, %d, %d, %d, %d\n';
fprintf(outSumD, format,  sumd);

%silhouette coeficient
silhouetteSet= silhouette(dataIn,ID, distance);
n = length(silhouetteSet);
avgSilCoef_link = 0;
for i=1:n
  avgSilCoef_link = silhouetteSet(i)+avgSilCoef_link;
end
avgSilCoef_link = avgSilCoef_link/n;
disp(avgSilCoef_link);
silClusters = [0,0];
nIteration = 1;
while nIteration<=length(ID)
    index = ID(nIteration);
    silClusters(index) = silhouetteSet(nIteration)+ silClusters(index);
    nIteration = nIteration + 1;
end
silClusters(1) = silClusters(1)/20;
silClusters(2) = silClusters(2)/length(ID);
disp(silClusters);