clear
clc
% Data Vectors:
dataIn = dlmread('./dataForClustering.csv');

% Define constraints
% Labels = {1,2,3}
cutoff = 2;
method = 'average';
metric_eucl = 'euclidean';

%(initializing the options)%
ID_eucl = linkage(dataIn,method,metric_eucl);
ID_actual_eucl = cluster(ID_eucl, cutoff);

% dendograms
figure_eucl = figure;
figure_silhouette = figure;
figure(figure_eucl)
dendrogram(ID_eucl);

% silhouette coeficient
avgSilCoef_eucl = 0;
silhouetteSet = silhouette(dataIn,ID_actual_eucl, metric_eucl);
figure(figure_silhouette);
silhouette(dataIn,ID_actual_eucl, metric_eucl)
n = length(silhouetteSet);
for i=1:n
  avgSilCoef_eucl = silhouetteSet(i)+avgSilCoef_eucl;
end
avgSilCoef_eucl = avgSilCoef_eucl/n;
disp(avgSilCoef_eucl);

silClusters = [0,0];
nIteration = 1;
while nIteration<=length(ID_actual_eucl)
    index = ID_actual_eucl(nIteration);
    silClusters(index) = silhouetteSet(nIteration)+ silClusters(index);
    nIteration = nIteration + 1;
end
silClusters(1) = silClusters(1)/20;
silClusters(2) = silClusters(2)/length(ID_actual_eucl);
disp(silClusters);
