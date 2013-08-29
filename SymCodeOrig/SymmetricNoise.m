function image = SymmetricNoise(N, n, type)

if strcmp(type, 'null')
    image = createTile(N,N);
elseif strcmp(type, 'P1')
    %% P1
    tile = createTile(n,n);
    image = repmat(tile, [round(N/n),round(N/n)]);
elseif strcmp(type, 'P2')
    %% P2
    tile = createTile(n,n);
    tileR180 = imrotate(tile, 180);
    p2 = [tileR180, tile];
    image = repmat(p2, [round(N/n), round(N/(2*n))]);
elseif strcmp(type, 'PM')
    %% PM
    tile = createTile(n,n);
    tileHR = tile(n:-1:1,:);
    image = repmat([tileHR; tile], [round(N/(2*n)), round(N/n)]);
elseif strcmp(type, 'PG')
    %% PG
    tile = createTile(n,n);
    tileVR = tile(:,n:-1:1);
    image = repmat([tile; tileVR], [round(N/(2*n)), round(N/n)]);
elseif strcmp(type, 'CM')
    %% CM
    tile = createTile(n,n);
    cm = [tile, tile(:,n:-1:1) tile, tile(:,n:-1:1); tile(:,n:-1:1) tile, tile(:,n:-1:1), tile];
    image = repmat(cm,[round(N/(2*n)) round(N/(4*n))]);
elseif strcmp(type, 'PMM')
    %% PMM
    tile = createTile(n,n);
    pmm = [tile,tile(:,n:-1:1); tile(n:-1:1,:), tile(n:-1:1,n:-1:1)];
    image = repmat(pmm, [round(N/(2*n)), round(N/(2*n))]);
elseif strcmp(type, 'PMG')
    %% PMG
    tile = createTile(n,n);
    pmg = [tile(n:-1:1,n:-1:1)  tile; tile(:,n:-1:1), tile(n:-1:1,:) ];
    image = repmat(pmg,[round(N/(2*n)), round(N/(2*n))]);
elseif strcmp(type, 'PGG')
    %% PGG
    % repeating tile is a triangle, so is actually half of Tile size
    tile = createTile(n,2*n);
    for x=1:n
        tile(x:n, x) = tile((n+1-x):-1:1, x+n);
    end
    for x=(n+1):(n*2)
        tile((2*n+1-x):n, x) = tile((x-n):-1:1, x-n);
    end
    pgg = tile(n:-1:1,(2*n):-1:1);
    image = repmat([tile; pgg],[round(N/(2*n)), round(N/(2*n))]);
elseif strcmp(type, 'CMM')
    %% CMM
    tile = createTile(n,n);
    pmm = [tile,tile(:,n:-1:1); tile(n:-1:1,:), tile(n:-1:1,n:-1:1)];
    cmm1 = [pmm,pmm];
    cmm2 = [cmm1(:,(n+1):(3*n)),cmm1(:,(n+1):(3*n))];
    image = repmat([cmm1;cmm2], [round(N/(4*n)), round(N/(4*n))]);
elseif strcmp(type, 'P4')
    tile = createTile(n,n);
    p4 = [tile, imrotate(tile,270); imrotate(tile,90), imrotate(tile,180)];
    image = repmat(p4, [round(N/(2*n)), round(N/(2*n))]);
elseif strcmp(type, 'P4M')
    %% P4M
     s = round(sqrt(2)*n);
    tile = createTile(s,s);
    for x=1:s
        for y=1:x
            tile(x,y) = tile(y,x);
        end
    end
    p4m = [tile, imrotate(tile,270); imrotate(tile,90), imrotate(tile,180)];
    image = repmat(p4m, [round(N/(2*n)), round(N/(2*n))]);
elseif strcmp(type, 'P4G')
    %% P4G
    tile = createTile(ceil(sqrt(2)*n/2), floor(sqrt(2)*n));
    tile = [tile; tile(round(sqrt(2)*n/2):-1:2,:)];
    p4g = [tile, imrotate(tile,270); imrotate(tile,90), imrotate(tile,180)];
    I = repmat(p4g, [ceil(N/(2*sqrt(2)*n)), ceil(N/(2*sqrt(2)*n))]);
    image = I(1:N, 1:N);
elseif strcmp(type, 'P3')
    image = p3(N,n);
elseif strcmp(type, 'P3M1')
    image = p3m1(N,n);
elseif strcmp(type, 'P31M')
    image = p31m(N,n);
elseif strcmp(type, 'P6')
    image = p6(N,n);
elseif strcmp(type, 'P6M')
    image = p6m(N,n);
end

B= fspecial('gaussian', [9 9], 1.5);
image = imfilter(image, B);
image = image - min(image(:));
image = image./max(image(:));
end

function tile = createTile(n,m)
tile = rand(n,m);
% tile(1,:) = 1;
% tile(:,1) = 1;
% tile(n,:) = 1;
% tile(:,m) = 1;
% tile(58:62,50:70) = 1;
% tile(48:58,30:70) = 1;
% tile = rand(n/4,m/4);
% tile = imresize(tile, 4);
end