
img = imread('tree.tiff');
img_gray = rgb2gray(img);
img_gray_int = img_gray ;
img_gray = cast(img_gray,'double');
img_int = img;
img = cast(img,'double');

img2 = imread('test_img.jpg');
img2_gray = rgb2gray(img2);

gretzky = imread('test2.jpg');
gretzky_gray = rgb2gray(gretzky);

building = imread('test3.jpg');
building_gray = rgb2gray(building);

bowl =imread('bowl-of-fruit.jpg');
bowl_gray = rgb2gray(bowl);

ryerson = imread('ryerson.jpg');

%%%%%%%%%%%%%Question 1.1%%%%%%%%%%%%%%%%%%%
fprintf('CPS843: Assignment 1\n')
fprintf('Feb 15th 2021\n')
fprintf('Jeffrey Keith 1\n\n')
fprintf('#############Question 1: Convolution#################\n')
fprintf('Question 1.1\n');
M = [0 5 0 0 0 0 0 0 0 0 
     0 0 0 0 0 0 0 0 0 0
     0 -7 2 8 -1 2 -1 -3 0 0
     0 0 1 1 0 0 -1 -1 0 0
     0 0 3 1 -2 4 -1 -5 0 0
     0 0 -1 -1 0 0 1 1 0 0
     0 0 1 2 2 2 -3 -4 0 0
     0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0] ;

% for r = 1:num_r(1)
%     %fprintf('-----------------------------------------\n');    
%     fprintf(' %d ', M(r,:));
%     fprintf('\n')   
% end
% fprintf('\n')   
disp(M)
 %fprintf('-----------------------------------------\n');
fprintf('\n')  
prompt = 'Press any key to continue.\n';
input(prompt);

%%%%%%%%%%%%%%%%%Question 1.2%%%%%%%%%%%%%%%%
fprintf('Question 1.2\n');
fprintf(char(8711));
fprintf('f(2,3) = ');
fprintf(char(8730));
fprintf('65\n');

fprintf(char(8711));
fprintf('f(4,3) = ');
fprintf(char(8730));
fprintf('5\n');

fprintf(char(8711));
fprintf('f(4,6) = ');
fprintf(char(8730));
fprintf('5\n');

prompt = '\nPress any key to continue.\n';
input(prompt);

%%%%%%%%%%%%%%Question 1.3%%%%%%%%%%%%%%%%%
fprintf('Question 1.3\n')

sigma = 2;
dim = 13;

h = fspecial('gaussian', [dim dim], sigma);

myconvoutput = MyConv(img_gray_int, h);


figure
subplot(2,2,1), imshow(img_gray_int), title('1.3 Tree');
subplot(2,2,2), imshow(myconvoutput, []), title('1.3 MyConv');

prompt = '\nPress any key to continue.\n';
input(prompt);


%%%%%%%%%%%%%Question 1.4%%%%%%%%%%%%%%%%%%
fprintf('Question 1.4\n')
%compare MyConv and 2d Guass

conv = imfilter(img_gray, h,'same','conv');
diff = abs(myconvoutput - conv);
% imshow(output2, []);

figure
subplot(2,2,1), imshow(img_gray_int), title('1.4 Tree');
subplot(2,2,2), imshow(myconvoutput, []), title('1.4 MyConv');
subplot(2,2,3), imshow(conv, []), title('1.4 imfilter: 2D Guass');
subplot(2,2,4), imshow(diff, []), title('1.4 Difference');

fprintf('\n The only difference is the padded zeros border which size 6 for a 13x13 kernel. This is because the filter is not seperable (Fig. 2)\n')


prompt = '\nPress any key to continue.\n';
input(prompt);



%%%%%%%%%%%%%Question 1.5%%%%%%%%%%%%%%%%%%
fprintf('Question 1.5\n') 
%compare 1d and 2d Guassian blur
%2d

dim = [13 13] ;
sigma = 8;
h = fspecial('gaussian',dim,sigma);
% surf(h)
% set(gca, 'Color', [0 0 0])

%3 sigma rule
h(1,:) = h(1,:) * 0;
h(13,:) = h(1,:) * 0;
h(:,1) = h(1,:) * 0;
h(:,13) = h(1,:) * 0;

fprintf('2d Guassian Blur: \n');

tic

guass_two = imfilter(img2_gray, h,'conv');

toc
fprintf('\n');
%1d Guass


%three sigma rule
x = -3:6/13:3;

G = @(x)(1/(sqrt(2*pi)*sigma)*exp(1)^((-1*(x^2))/(2*(sigma^2))));

gx = zeros(1,13);
gy = zeros(1,13);

for i = 1:13
    gx(i) = G(x(i));
    gy(i) = G(x(i));
end

gy = gy';

fprintf('1d Guassian Blur: \n');
tic

conv1 = imfilter(img2_gray, gy,'conv');
guass_one = imfilter(conv1, gx,'conv');

toc

fprintf('\n1.5 The time to process a 1d Guassian Blur is generally \nfaster than the time required to process 1d Guassian Blur\n');

figure
subplot(2,2,1), imshow(img2_gray, []), title('1.5 Original');
subplot(2,2,2), imshow(guass_two, []), title('1.5 2D Guass');
subplot(2,2,3), imshow(guass_one, []), title('1.5 1D Guass');


prompt = '\nPress any key to continue.\n';
input(prompt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%Question 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('########Question 2: Canny Edge Detection###############\n') 
fprintf('Question 2.1\n');
fprintf('Please wait...\n');

figure
subplot(1,1,1)
imshow(bowl, []), title('2.1 Original Bowl')

canny_bowl = MyCanny(bowl_gray,12,25);

figure
subplot(1,1,1)
imshow(canny_bowl), title('2.1 Bowl Edges')

prompt = '\nPress any key to for next image.\n';
input(prompt);
fprintf('Please wait...\n');

figure
subplot(1,1,1)
imshow(gretzky, []), title('2.1 Original Image')

canny_my_test = MyCanny(gretzky_gray,17,8);

figure
subplot(1,1,1)
imshow(canny_my_test), title('2.1 My Test')

prompt = '\nPress any key to continue.\n';
input(prompt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%Question 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('########Question 3: Seam Carving###############\n') 
prompt = '\nPress any key to start seam carving. Ryerson image and test_img.jpg have already been carved.\n See ry_720_320.bmp, ry_640_480.bmp and my_carved.bmp (original: test_img.jpg).\n';
input(prompt);

ry_720 = MySeamCarving(ryerson, [320 720 3]);
ry_640 = MySeamCarving(ryerson, [480 640 3]);
figure
subplot(1,1,1)
imshow(ry_720), title('Ryerson 720x320');

figure
subplot(1,1,1)
imshow(ry_640), title('Ryerson 640x480');

fprintf('########End of script, thank you.###############\n') ;
