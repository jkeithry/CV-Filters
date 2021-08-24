function canny = MyCanny(im, sigma, tau)
%canny = MyCanny(im, sigma, tau) where im is the image to have edges
%detected, sigma is the standard deviation of the 2d guassian blur an tau
%is the gradient magnitude threshold. Mask size is 13x13
im_size = size(im);
im = cast(im,'double');
%Guass
%Three sigma rule
x = -3:6/13:3;
G = @(x)(1/(sqrt(2*pi)*sigma)*exp(1)^((-1*(x^2))/(2*(sigma^2))));

gx = zeros(1,13);
gy = zeros(1,13);

for i = 1:13
    gx(i) = G(x(i));
    gy(i) = G(x(i));
end

gy = gy';

%discrete derivatives
Dx = [1 0 -1];
% Dy = [1 2 1];
Dy = Dx';

%Question 2.2 Seperable Gauss filter
%1. smooth with 2d gauss 
conv = im;
conv = MyConv(conv, gy);
conv = MyConv(conv, gx);

%2. Calculate squared gradient magnitude of the smoothed image m_xy.
im_dx = MyConv(conv,Dx);
im_dy = MyConv(conv,Dy);

%3. Estimate gradient magnitude in the gradient direction and opposite of
%the gradient direction
theta = atan2(im_dy,im_dx);
m_yx = im_dx.^2 + im_dy.^2;

%4. find peaks
canny = zeros(im_size);
for r = 2:im_size(1)-1
    for c = 2:im_size(2)-1
        %0 degrees
        if ((theta(r,c) >= -0.3927) && (theta(r,c) < 0.3927)) || ((theta(r,c) <= -2.7489) && (theta(r,c) > 2.7489))
            if(m_yx(r,c)>= m_yx(r,c+1)) && (m_yx(r,c) >= m_yx(r,c-1))
                canny(r,c) = m_yx(r,c);
            end
        %45 degrees
        elseif ((theta(r,c) >= 0.3927) && (theta(r,c) < 1.1781)) ||  ((theta(r,c) <= -0.3927) && (theta(r,c) > -1.1781))
            if(m_yx(r,c)>= m_yx(r+1,c+1)) && (m_yx(r,c) >= m_yx(r-1,c-1))
                canny(r,c) = m_yx(r,c);
            end
        %90 degrees
        elseif ((theta(r,c) >= 1.1781) && (theta(r,c) < 1.9635)) || ((theta(r,c) <= -1.1781) && (theta(r,c) > -1.9635))
            if(m_yx(r,c)>= m_yx(r+1,c)) && (m_yx(r,c) >= m_yx(r-1,c))
                canny(r,c) = m_yx(r,c);
            end

        %135 degrees
        else
            if(m_yx(r,c)>= m_yx(r+1,c-1)) && (m_yx(r,c) >= m_yx(r-1,c+1))
                canny(r,c) = m_yx(r,c);
            end
           
        end
        %5. Threshold: tau
        if(canny(r,c) > tau)
            canny(r,c) = 0;
        end

    end
end



