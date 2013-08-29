clear all
%% generate a load of tiled images
%scaling factors
% scalingFactors = [0.5, 0.6, 0.7, 0.8, 0.9];

% mask
r = 508;
X = -511:512;
X = repmat(X, [1024, 1]);
Y = X';
D = sqrt(X.^2+Y.^2);
clear X Y
D = D./r;
D(D<1) = 0;
D = 1-D;

Sym = { 'P3', 'P1', 'P2', 'PM' ,'PG', 'CM', 'PMM', 'PMG',...
    'PGG', 'CMM', 'P4', 'P4M', 'P4G','P3M1', 'P31M', 'P6', 'P6M'};
% create at double size so i can shrink!
N = 1024;
n= 64;


% create intensity hist to use for matching
B= fspecial('gaussian', [9 9], 1);
sample = imfilter(rand(256), B, 'symmetric');
refHist = imhist(sample);

daftctr=0
for S = 1:17
    for sf = 1%:5
        clear I
        daftctr=daftctr+1;
        I = SymmetricNoise(N, n, Sym(S));
        %         image = imrotate(image, 360*rand, 'bilinear', 'crop');
        %         a = round(size(image,1)/4);
        %         I = image(a:(3*a), a:(3*a));
        %         I = histeq(image, refHist);
        %         clear image
        I = 1-I;
        %         I = imresize(I, scalingFactors(sf), 'bilinear');
        m(daftctr) = mean(I(:));
        s(daftctr) = std(I(:));
        I = I(1:1024, 1:1024).*D;
        I = 1-I;
        filename = strcat(Sym(S), '.png');
        
      imwrite(I,filename{1});
    end
end
[mean(m) mean(s)]
