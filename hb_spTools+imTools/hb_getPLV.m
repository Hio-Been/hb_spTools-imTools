function [PLV, angDiff] = hb_getPLV(filtsig_x, filtsig_y)

%%  hb_getPLV function
% filtsig_x, _y, should be the shape of [ trialIdx x (time*srate) ],
% and each trial signal is hypothesized band-pass filtered already.

if min(size(filtsig_x) == size(filtsig_y)) == 0
    error('Signal X and Y should be the same size')
end

[nTrials, matDirection] = min(size(filtsig_x));
matDirection = 1;

% if ~(matDirection == 1)
%     disp(['Matrix rotation required'])
%     filtsig_x = filtsig_x';
%     filtsig_y = filtsig_y';
% end

%% Single trial
if nTrials == 1 
    xh = angle(hilbert(filtsig_x(:)));
    yh = angle(hilbert(filtsig_y(:)));
    angDiff = yh-xh;
    PLV = abs(mean(exp(1i* angDiff)));
%% Batch trials
else
    PLV = zeros([nTrials,1]);
    angDiff = zeros([nTrials,size(filtsig_x,2)]);
    for trialIdx = 1:nTrials
        xh = angle(hilbert(filtsig_x(trialIdx,:)));
        yh = angle(hilbert(filtsig_y(trialIdx,:)));
        angDiff(trialIdx,:) = yh-xh;
        PLV(trialIdx,1) = abs(mean(exp(1i* angDiff(trialIdx,:))));
    end    
end

return

