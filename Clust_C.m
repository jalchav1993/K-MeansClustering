clear
clc
% Data Vectors:
dataIn = dlmread('./dataForClustering.csv');

% Define constraints
% Labels = {1,2,3}
cutoff = 2;
method = 'average';
metric_link = 'cosine';

%(initializing the options)%
ID_link = linkage(dataIn,method,metric_link);
ID_actual_link = cluster(ID_link,cutoff);

% dendograms
figure_link = figure;
figure_silhouette = figure;
figure(figure_link)
dendrogram(ID_link);

% silhouette coeficient
avgSilCoef_eucl = 0;
silhouetteSet = silhouette(dataIn,ID_actual_link, metric_link);
figure(figure_silhouette);
silhouette(dataIn,ID_actual_link, metric_link)
n = length(silhouetteSet);
for i=1:n
  avgSilCoef_eucl = silhouetteSet(i)+avgSilCoef_eucl;
end
avgSilCoef_eucl = avgSilCoef_eucl/n;
disp(avgSilCoef_eucl);

%sillhouette cluster values
silClusters = [0,0];
nIteration = 1;
while nIteration<=length(ID_actual_link)
    index = ID_actual_link(nIteration);
    silClusters(index) = silhouetteSet(nIteration)+ silClusters(index);
    nIteration = nIteration + 1;
end
silClusters(1) = silClusters(1)/20;
silClusters(2) = silClusters(2)/length(ID_actual_link);
disp(silClusters);