% Data Vectors:
dataIn = dlmread('./q2_data.csv');
E = dlmread('./q2_expected.csv');

% Define constraints
% Labels = {1,2,3}
% Euclidean
method = 'centroid';

%(initializing the options)%
ID = linkage(dataIn,'ward','euclidean');
ID_actual = cluster(ID, 'maxclust',3);

% Rand Index: pariwise comparison
% [TP , FP]
% [TN , FN]
TP = 0;
TN = 0;
FN = 0;
FP = 0;

for i = 1: length(ID_actual)
    for j = i+1: length(ID_actual)
        if ID_actual(i) == ID_actual(j) && E(i) == E(j)
            TP = 1+TP;
        elseif ID_actual(i) == ID_actual(j) && E(i) ~= E(j)
            FP = 1+FP;
        elseif ID_actual(i) ~= ID_actual(j) && E(i) == E(j)
            FN = 1+FN;
        elseif ID_actual(i) ~= ID_actual(j) && E(i) ~= E(j)
            TN = 1+TN;
        end
    end
end
RandIndex = (TP+TN)/(TP+TN+FP+FN);
