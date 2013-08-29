function image = p3m1(N,n)

% N=1024;
% 
% n = 64;

s = round(n*sqrt(4/sqrt(3)));
a = floor(s/2)-1;
 tile = rand(s);
% tile(1,:) = 1;
% tile(s,:) = 1;
% tile(:,1) = 1;
% tile(:,s) = 1;
% tile(:,(a-1):(a+1)) =1;
% tile(10:20, 10:20) = 1;

magfactor = 8;
tile = imresize(tile, magfactor, 'nearest');
n=magfactor*n;
s = round(n*sqrt(4/sqrt(3)));
h = round(sqrt(s^2-(s/2)^2));
% make triangular tile
for y=1:s
    for x=1:floor(s/2)
        if (x<y*tand(30))
            tile(x,y) = 0;
        end
    end
    for x=ceil(s/2):s
        if ((s-x)<y*tand(30))
            tile(x,y) = 0;
        end
    end
end
% tile(:,(h+1):size(tile,2)) = [];
tile = trim(tile);
% tile((size(tile,1)-3):size(tile,1), :) = [];
%imshow(tile)
% reflect!
tileR1 = imrotate(tile(:,size(tile,2):-1:1),240, 'bilinear');
tileR1 = trim(tileR1);
tileR1(:,size(tileR1,2)) = [];
tileR1(:,size(tileR1,2)) = [];
tileR2 = imrotate(tileR1,240, 'bilinear');
tileR2 = trim(tileR2);
tileR2(:,size(tileR2,2)) = [];
tileR2(:,size(tileR2,2)) = [];
tileR2(:,size(tileR2,2)) = [];

tile(:,size(tile,2)) = [];
a = size(tile,1)/2;
b = floor(size(tile,2));

tile = [zeros(a+1,b);tile;zeros(a,b)];
tileR1 = [zeros(a-1,b);zeros(a-1,b);tileR1];
tileR2 = [tileR2;zeros(a-1,b);zeros(a-1,b)];

half = max(tile,tileR1);
half = max(half,tileR2);
%imshow(half)

whole = [half, half(:,size(half,2):-1:1)];

c = ceil(size(whole,1)/4)+1;
topbit = [whole((size(whole,1)-c-1):size(whole,1),(size(whole,2)/2):size(whole,2))...
    whole((size(whole,1)-c-1):size(whole,1),1:(size(whole,2)/2-1))];

botbit = [whole(1:(c+1),(size(whole,2)/2):size(whole,2))...
    whole(1:(c+1),1:(size(whole,2)/2-1))];

whole(1:(c+2),:) = max(whole(1:(c+2),:),topbit);
whole((size(whole,1)-c):size(whole,1),:) = max(whole((size(whole,1)-c):size(whole,1),:), botbit);
%imshow(whole)

s= size(whole,2)/2;
l = size(whole,1)*3/4;
bigTile = [whole;  whole((l/3):l, s:-1:1), whole((l/3):l, (2*s):-1:(s+1))];
tile = imresize(bigTile, 1/magfactor);
n=n./magfactor;
I = repmat(tile, [N/(4*n),N/(2*n)]);
%imshow(I)
% imwrite(I(1:1024,1:1024), ['p3m1_-n' int2str(n) '.png']);
image = I(1:N,1:N);
end

function tile = trim(tile)
linesum = sum(tile(1,:));
while(linesum==0)
    tile(1, :) = [];
    linesum = sum(tile(1, :));
end
linesum = sum(tile(:, 1));
while(linesum==0)
    tile(:, 1) = [];
    linesum = sum(tile(:, 1));
end
linesum = sum(tile(size(tile, 1), :));
while(linesum==0)
    tile(size(tile,1), :) = [];
    linesum = sum(tile(size(tile, 1),:));
end
linesum = sum(tile(:, size(tile ,2)));
while(linesum==0)
    tile(:, size(tile,2)) = [];
    linesum = sum(tile(:, size(tile, 2)));
end
end
