function f3 = hb_gaussianBlob(N,sigma,plotOption)

if nargin < 1
    N = 30^2;
    sigma = sqrt(N) ^ 1.5;
end

% Generate basic gaussian blob
[x, y] = meshgrid(floor(-N/2):floor(N/2)-1, floor(-N/2):floor(N/2)-1);
f0 = exp(-x.^2/(2*sigma^2)-y.^2/(2*sigma^2));
f1 = f0./sum(f0(:));

% Range re-scaling
f2 = (f1 - min(min(f1)));
f3 = 127.5  + (127.5 * (f2 / max(max(f2))));

if plotOption == 1
    meshz(f3); %colormap(gray);
    title(strcat(['N = ' num2str(sqrt(N)) '^2, sigma = ' num2str(sqrt(sigma)) '^2']), 'FontSize', 15);
end


return