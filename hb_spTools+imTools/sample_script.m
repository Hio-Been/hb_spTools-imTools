%% Single trial plot (single channel)
figure(1);
chanIdx = 1;
for trialIdx = 1:600;
    % Time domain 
    subplot(2,1,1);
    plot( EEG.times, EEG.data( chanIdx, :, trialIdx) ); 
    xlabel('time (msec)'); ylabel('amptd (uV)');
    ylim([-1 1]*200)
    drawnow;
    title(['Single Trial, trialIdx: ' num2str(trialIdx) ]); 
    
    % Frequency domain 
    subplot(2,1,2);
    positiveFFT( EEG.data(chanIdx,:,trialIdx), 2000, 1);
    xlim( [0 100] )
    title(['FFT result, trialIdx: ' num2str(trialIdx) ]); drawnow;
    
    pause(.5);
end


%% Average (ERP) plot
for chanIdx = 1:4
    subplot(2,2,chanIdx);
    plot( EEG.times, mean( EEG.data( chanIdx, :, :), 3) );
    xlabel('time (msec)'); ylabel('amptd (uV)');
    title(['ERP, chan: ' num2str(chanIdx) ]); 
    drawnow;
end


%% Simple filter practice
filter_band = [ 2 20 ]; % Hz
for chanIdx = 1:4
    subplot(2,2,chanIdx);
    dat = mean( EEG.data( chanIdx, :, :), 3) ;
    dat_filt = zerofilt( double(dat), filter_band(1), filter_band(2), EEG.srate);
    
    plot( EEG.times, dat_filt );
    xlabel('time (msec)'); ylabel('amptd (uV)');
    title(['Filtered ERP, band: ' num2str(filter_band(1)) '~' num2str(filter_band(2))   ...
        ', chan: ' num2str(chanIdx) ]); 
    drawnow;
end


