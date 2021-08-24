function im_carved = MySeamCarving(im, res)
%MySeamCraving(im, res) takes in an image im and resizes it to the
%resolution spesified by res
im_size = size(im);
res_diff = im_size - res;
im_carved = im;
im_carved = cast(im_carved,'uint8');

for r = 1:res_diff(2)
    im_carved = CarvingHelper(im_carved);    
end

im_carved_t = zeros(res(2),im_size(1),im_size(3));
im_carved_t = cast(im_carved_t, 'uint8');
im_carved_t(:,:,1) = im_carved(:,:,1)';
im_carved_t(:,:,2) = im_carved(:,:,2)';
im_carved_t(:,:,3) = im_carved(:,:,3)';

for r = 1:res_diff(1)
    im_carved_t = CarvingHelper(im_carved_t);    
end

im_carved = zeros(res(1),res(2),res(3));
im_carved = cast(im_carved,'uint8');
im_carved(:,:,1) = im_carved_t(:,:,1)';
im_carved(:,:,2) = im_carved_t(:,:,2)';
im_carved(:,:,3) = im_carved_t(:,:,3)';