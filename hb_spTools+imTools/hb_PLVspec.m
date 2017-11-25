function [PLVspec, Times, Freqs ] = hb_PLVspec( dat, window, tStep,freqRange, freqWidth, t_input, srate )
% dat : [ 1 x T ] , timeseries 'double'

if nargin < 2
    window = 2^8; srate = 2000;
    freqRange = [2:2:100]; freqWidth=1.5;
    tStep = 2;
end; if mean( class(dat) == 'single' ) == 1;
    dat = double(dat);
end; if size(dat,1)>size(dat,2)
    dat = dat';
end

% Set Frequency Parameters & Filters
window = 2^10;
x = (1:length(dat));
xx = [ 1+(window*.5):tStep:length(dat)-(window*.5) ];
xx2 = [xx, xx(end)+window*.5];
Times = t_input(xx);
Freqs = freqRange;

PLVspec = nan([ length(Freqs), length(Times)]);

% Initialize output variable
targetHz = 40;
sinewave = MakeBeep( targetHz, 2* length(dat)/srate, srate);
for freqIdx = 1:length(freqRange)
%     freqRange(freqIdx)
%     freqWidth
    dat_filt = zerofilt( dat, freqRange(freqIdx)-(freqWidth), freqRange(freqIdx)+(freqWidth), srate); 
    
    plv_timeseries = [];
    for tIdx = 1:length(xx)
        window_temp = xx2(tIdx):xx2(tIdx+1);
        plv_timeseries(tIdx)=hb_getPLV( dat_filt(window_temp), sinewave(window_temp) );
    end
    PLVspec(freqIdx, :) = plv_timeseries;
end

PLVspec = single(PLVspec);

return
% imagesc( Times, Freqs, imgaussfilt( PLVspec , 1 ) ); axis xy; colormap jet; cb=colorbar;
% xlabel('Time (sec)'); ylabel('Freq (Hz)'); ylabel(cb, 'PLV');
% figure; plot(dat) 
% 
    





