function conv = MyConv(im, ker)
%MyConv(im, ker)
%Input: 
%im = arbitrary image
%ker = kernel function
%Output:
%convolved image with padded zeros
im = cast(im, 'double');

%flip kernel
ker = flip(ker,1);
ker = flip(ker,2);

ker_size = size(ker);
ker_r = ker_size(1);
ker_c = ker_size(2);

im_size = size(im);
im_r = im_size(1);
im_c = im_size(2);

%even kernel?
even_r = false;
even_c = false;

if mod(ker_r,2) == 0
    even_r = true;
end

if mod(ker_c,2) == 0
    even_c = true;
end
%Kernel center
if even_c && even_r
    kr = ker_r/2;
    kc = ker_c/2;
    ker_cent = [kr kc];
elseif ~even_c && even_r
    kr = ker_r/2;
    kc = round(ker_c/2);
    ker_cent = [kr kc];
elseif even_c && ~even_r
    kr = round(ker_r/2);
    kc = ker_c/2;
    ker_cent = [kr kc];
else 
    kr = round(ker_r/2);
    kc = round(ker_c/2);
    ker_cent = [kr kc];
end

conv = zeros(size(im));

for r = ker_cent(1):im_r - ker_cent(1)
    for c = ker_cent(2):im_c - ker_cent(2)
        im_region = im((r-kr)+1 : (r+kr)-1, (c-kc)+1 : (c+kc)-1);        
        rc_sum = sum(sum(im_region.*ker));        
        conv(r,c) = rc_sum;        
    end
end
    

