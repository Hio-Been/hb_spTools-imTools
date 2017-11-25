function [power,actual_band] = hb_bandpower(x, targetBand, Fs)

if nargin < 3
    Fs = 2000;
end

[X,freq]=positiveFFT(x,Fs);

f_low = find(freq < targetBand(1));
f_high = find(freq > targetBand(2));
if targetBand(1) > 0
    power = mean(abs( X(f_low(end)+1:f_high(1)-1) ).^2);
    actual_band = [ freq(f_low(end)+1), freq(f_high(1)+1) ];
else
    power = mean(abs( X(1:f_high(1)-1) ).^2);
    actual_band = [ 0, freq(f_high(1)-1) ];
end    
return

%% FFT Function
function [X,freq]=positiveFFT(x,Fs)

N=(length(x));  %get the number of points
k=0:N-1;        %create a vector from 0 to N-1
T=N/Fs;         %get the frequency interval
freq=k/T;       %create the frequency range
cutOff = ceil(N/2);
freq = freq(1:cutOff);

X=fft(x)/N*2; % normalize the data
X = X(1:cutOff); % Single trial FFT

return
