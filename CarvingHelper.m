function carved = CarvingHelper(im)
%CarvingHelper(im) find seam in image im and removes seam. Only finds seam vertically.
%To find horizontal seam transpose image beforehand.
im_size = size(im);
score = zeros(im_size(1),im_size(2));
energy = zeros(im_size);
seam = zeros(im_size(1),1,1);
carved = zeros(im_size(1),im_size(2)-1,3);
carved = cast(carved,'uint8');
Dx = [1 0 -1];
Dy = Dx';
%Compute Energy
for color = 1:im_size(3)
    im_color = im(:,:,color);
    im_dx = MyConv(im_color,Dx);
    im_dy = MyConv(im_color,Dy);
    energy(:,:,color) = (im_dx.^2 + im_dy.^2).^(0.5);
end
e = sum(energy,3);
%compute score
score(1,:) = e(1,:);
for r = 2: im_size(1)    
    for c = 1: im_size(2)        
        if c == 1
            adj = [score(r-1,c),score(r-1,c+1)];
        elseif c == im_size(2)
%             adj = [score(r-1,c-1), score(r-1,c)];
            score(r,c) = inf;
            continue;
        else
            adj = [score(r-1,c-1), score(r-1,c),score(r-1,c+1)];
        end
        [minimum, ~] = min(adj);
        score(r,c) = e(r,c) + minimum;
    end    
end
%lowest row min score
[min_vals_color, arg_mins] = min(score(im_size(1),:,:));
[~, color_arg_min_val] = min(min_vals_color);    
seam(im_size(1)) = arg_mins(color_arg_min_val);   
%seam backtrack
for r = im_size(1):-1:2
    col = seam(r);
    if col == 1         
        above = [ score(r-1,col), score(r-1,col+1)];
        %add one to offset switch statement
        col = col + 1;
    elseif col == im_size(2)
        above = [score(r-1,col-1), score(r-1,col)];
    else
        above = [score(r-1,col-1), score(r-1,col), score(r-1,col+1)];
    end
    [~, color_arg_min_val] = min(above);
    %set row above
    switch color_arg_min_val
        case 1
            seam(r-1) = col-1;
        case 2
            seam(r-1) = col;
        case 3
            seam(r-1) = col+1;
    end
end
%remove seam
for color = 1:im_size(3)
%     page = im(:,:,color);
    for r = 1:im_size(1)
        carved_row = im(r,:,color);
        carved_row(:,seam(r)) = [];
        carved(r,:,color) = carved_row;
    end
%     carved_page = carved(:,:,color);
end
        

