function [dprime, bias_c] = hb_getSDTresult(hit_ratio, fa_ratio)

%% infinite value scaling
if hit_ratio == 1
    hit_ratio = .9999;
end
if fa_ratio == 1
    fa_ratio = .9999;
end
if hit_ratio == 0
    hit_ratio = .0001;
end
if fa_ratio == 0
    fa_ratio = .0001;
end

%% hb_getSDTresult

dprime = norminv(hit_ratio,0,1) - norminv(fa_ratio,0,1);
bias_c = -.5 * (norminv(hit_ratio,0,1) + norminv(fa_ratio,0,1));

disp(['d-Prime : ' num2str(dprime) ', bias C : ' num2str(bias_c)]);

return

