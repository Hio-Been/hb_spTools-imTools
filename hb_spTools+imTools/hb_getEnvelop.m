function [evlp_posi, evlp_nega] = hb_getEnvelop( signal , plotOption )
% function [evlp_posi, evlp_nega] = hb_getEnvelop( signal , plotOption )

% Find peaks
change_directions = diff(diff(signal) > 0);
zc_upper = find(( change_directions ) == (-1)) + 1; % find zero-crossing points
zc_lower = find(( change_directions ) == (1)) + 1; % find zero-crossing points

% (Positive) Interpolation
evlp_posi = nan([1, length(signal)]);
evlp_posi(zc_upper) = signal(zc_upper);
% Filling in first and last 
evlp_posi(1:zc_upper(1)) = linspace(mean(signal), signal(zc_upper(1)), zc_upper(1));
evlp_posi(zc_upper(end):end) = linspace(signal(zc_upper(end)), mean(signal), length(evlp_posi(zc_upper(end):end)));
for idx = 1:length(zc_upper)-1
    dp_t1 = zc_upper(idx);
    dp_t2 = zc_upper(idx+1);
    value_t1 = signal(dp_t1);
    value_t2 = signal(dp_t2);    
    evlp_posi(dp_t1:dp_t2) = linspace(value_t1, value_t2, length(dp_t1:dp_t2));
end


% (Negative) Interpolation
evlp_nega = nan([1, length(signal)]);
evlp_nega(zc_lower) = signal(zc_lower);
% Filling in first and last 
evlp_nega(1:zc_lower(1)) = linspace(mean(signal), signal(zc_lower(1)), zc_lower(1));
evlp_nega(zc_lower(end):end) = linspace(signal(zc_lower(end)), mean(signal), length(evlp_posi(zc_lower(end):end)));
for idx = 1:length(zc_lower)-1
    dp_t1 = zc_lower(idx);
    dp_t2 = zc_lower(idx+1);
    value_t1 = signal(dp_t1);
    value_t2 = signal(dp_t2);    
    evlp_nega(dp_t1:dp_t2) = linspace(value_t1, value_t2, length(dp_t1:dp_t2));
end


if plotOption
    figure;
    plot( signal, 'k-');
    hold on;
    plot( evlp_posi, 'ro--')
    plot( evlp_nega , 'bx--')
end

return



