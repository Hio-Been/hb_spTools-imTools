function m2 = hb_getGabor( rec, freq, phase, tilt, contrast )
% rec: size in pixel
% freq: spatial frequency
% phase: phase (0~360)
% tilt: tilt angle (0~360)


%% Set input parameters
% rec = 300; res = [rec rec];
% sc = 50.0;
% freq = .03;
% tilt = 90;
% contrast = 100.0;

if nargin < 1
    rec = 100; 
    freq = .025;
    phase = 5;
    tilt = 90;
    contrast = 100.0;
end
sc = rec/5;

aspectratio = 1.0;
res = [rec rec];

tw = res(1);
th = res(2);
x=tw/2;
y=th/2;

%%
% for phase = phase_vector
sf = freq;
[gab_x gab_y] = meshgrid(0:(res(1)-1), 0:(res(2)-1));
a=cos(deg2rad(tilt))*sf*360;
b=sin(deg2rad(tilt))*sf*360;
multConst=1/(sqrt(2*pi)*sc);
x_factor=-1*(gab_x-x).^2;
y_factor=-1*(gab_y-y).^2;
sinWave=sin(deg2rad(a*(gab_x - x) + b*(gab_y - y)+phase));
varScale=2*sc^2;
m=0.5 + contrast*(multConst*exp(x_factor/varScale+y_factor/varScale).*sinWave)';
m2 = ((m-.5)*.125)+.5;

if nargin < 1
    subplot(2,1,1);
    imagesc(m2);    colormap gray;
    caxiss = [0 1];
    caxis(caxiss);
    colorbar;
    
    subplot(2,1,2)
    histogram( m2(:), 30 );
    xlim([0 1]);
    title('Color histogram)'); colorbar;
    drawnow;
end

return