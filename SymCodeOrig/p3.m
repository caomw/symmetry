function image = p3(N,n)
close all
  n=64;
% work out dimensions so that the tile has area n.^2
% (plus/minus rounding errors!)
% s is side of equalateral triangle
tile = rand(n);
% tile(1,:) = 1;
% tile(n,:) = 1;
% tile(:,1) = 1;
% tile(:,n) = 1;
% tile(10:20, 10:20) = 1;
% tile(10:15,20:50) = 1;


magfactor = 8;
% tile = imfilter(tile, B, 'symmetric');
tile = imresize(tile, magfactor, 'nearest');
n=magfactor*n;
for x=1:n
    for y=1:round(n*sqrt(3/4))
        tile0(round(x+y*tand(30))+1, round(y)) = tile(x,mod(y,n)+1);
    end
end
% tile0 = trim(tile0);

tile120 = imrotate(tile0, 120, 'bilinear');
tile120 = trim(tile120);
if(size(tile120,1)<size(tile0,1))
    tile120 = [zeros(1,size(tile120,2)); tile120];
end
idx = sum(tile120)<mean(sum(tile120)/1.5);
tile120(:,idx) = [];
tile240 =  imrotate(tile0, 240, 'bilinear');
tile240 = trim(tile240);
tile120(:,1) = [];
tile120(:,size(tile120,2)) = [];
T = [tile0, tile120];

a = floor(size(tile240,1)/2);
b = floor(size(T,2)/2);
for i=1:a
    for j = 1:size(T,2)
        T(i,j) = max(T(i,j), tile240(a+i-1,j));
    end
end
size(T)
for j = 1:(b-1)
    for i=1:(a+1)        
%         if ((i+2*a-1 )> size(T,1))
%             break
%         end
        T(i+2*a-1, j+b+1) = max(T(i+2*a-1, j+b+1), tile240(i, j));
        T(i+2*a-1, j) = max(T(i+2*a-1, j), tile240(i, j+b));
    end
end
T(size(T,1),:) = [];

T  = [T; T(:, floor(size(T,2)/2):size(T,2)-1), T(:, 1:floor(size(T,2)/2))];

I = imresize(T, 1/magfactor, 'nearest');
clear T tile tile0 tile120 tile240
I = repmat(I, ceil(N./size(I)));

image = I(21:(N+20), 21:(N+20));
size(image)
%  imwrite(image, 'p3.png')
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

