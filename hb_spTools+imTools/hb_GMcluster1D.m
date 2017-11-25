function [ClusterLabel, stat] = hb_GMcluster1D(y, nCluster, plotOption)

if nargin < 3; 
    plotOption = 0; 
end
    
% FITTING
try;
    GMFIT = fitgmdist( y', nCluster , 'Options', statset('MaxIter', 1000));

catch;GMFIT = fitgmdist( y, nCluster , 'Options', statset('MaxIter', 1000) );
end;

% SORTING
[mu_sort, order_sort ]= sortrows( GMFIT.mu ); 
s_sort = squeeze(GMFIT.Sigma(:,:,order_sort));
for clusterIdx = 1:nCluster
    disp(['Cluster#' num2str(clusterIdx) ...
        ' X~N(' num2str(round(1000*(mu_sort(clusterIdx)))/1000) ...
        ',' num2str(round(1000*(s_sort(clusterIdx)))/1000) ')']);
end

% LABELING
ClusterLabel = [];
for elemIdx = 1:length(y)
    element = y( elemIdx );
    prob = [];
    for clustIdx = 1:nCluster
        prob(clustIdx) = normpdf( element, mu_sort(clustIdx), s_sort(clustIdx) ); 
    end
    [~,maxIdx] = max(prob);
    ClusterLabel( elemIdx ) = maxIdx;
end

% SUMMARIZING
stat = [];
stat.M = mu_sort;
stat.S = s_sort;
stat.ratio = GMFIT.ComponentProportion( order_sort );
stat.GOF = GMFIT.NegativeLogLikelihood;

% PLOTTING
% plotOption = true;
if plotOption
    hold off;
    h1= histogram( y, 50 );
    h1.FaceColor = 'k';
    hold on;
    cLabels = {'Original'};
    for clusterIdx = 1:nCluster
        h2 = histogram( y(find(ClusterLabel==clusterIdx)), round(50*stat.ratio(clusterIdx)));
        cLabels{clusterIdx+1} = ['Cluster ' num2str( clusterIdx) ];
    end
    legend(cLabels);
end



return