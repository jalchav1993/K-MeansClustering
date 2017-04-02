% Data Vectors:
dataIn = dlmread('./q2_data.csv');
E = dlmread('./q2_expected.csv');

% Define constraints
% Labels = {1,2,3}
% Euclidean
nclusters = 3;
distance = 'sqeuclidean';

%(initializing the options)%
opts = statset('Display','final');
[ID, ctrs] = kmeans(dataIn,nclusters, 'Distance', distance,....
    'Replicates', 5, 'Options', opts);

% Rand Index: pariwise comparison
% [TP , FP]
% [TN , FN]
TP = 0;
TN = 0;
FN = 0;
FP = 0;

for i = 1: length(ID)
    for j = i+1: length(ID)
        if ID(i) == ID(j) && E(i) == E(j)
            TP = 1+TP;
        elseif ID(i) == ID(j) && E(i) ~= E(j)
            FP = 1+FP;
        elseif ID(i) ~= ID(j) && E(i) == E(j)
            FN = 1+FN;
        elseif ID(i) ~= ID(j) && E(i) ~= E(j)
            TN = 1+TN;
        end
    end
end
RandIndex = (TP+TN)/(TP+TN+FP+FN);

