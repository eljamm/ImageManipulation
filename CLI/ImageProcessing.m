% ====================================================================
%                   Manipulations on Grayscale Images
% ====================================================================
%                              Fedi Jamoussi
%                            Second Year GEC 1
%                               (2021-2022)
% ====================================================================
% Tested with MatLAB version 2018b.


%% Initialize
clear variables;
close all;
clc;


%% Read Image
Image = imread('LENA.BMP');
[rows, columns] = size(Image);


%% Display Original
figure(1)

subplot(2,2,1)
imshow(Image);
title('Original Image');


%% Information
resolution = rows*columns;
fprintf('This image has a Resolution of %dx%d pixels.\n',rows,columns); fprintf('---\n');


%% Number of Repetition
y = input('Enter a grayscale value to see how many times it repeats: ');

repetition = 0;
for i = 1:rows
    for j = 1:columns
        if Image(i,j) == y
           repetition = repetition + 1; 
        end
    end
end

fprintf('The grayscale value %d repeats %d times in the Image.\n',y,repetition); fprintf('---\n');


%% Color Inversion
InvImage = imcomplement(Image);

subplot(2,2,2)
imshow(InvImage);
title('Color Inversion');


%% Divide in Four
middleRow = round(rows/2);
middleColumn = round(columns/2);

upperLeft = Image(1:middleRow, 1:middleColumn);
upperRight = Image(1:middleRow, middleColumn:end);

bottomLeft = Image(middleRow:end, 1:middleColumn);
bottomRight = Image(middleRow:end, middleColumn:end);

y = input(['Which part of the image would you like to see ?\n' ...
    '1) Upper Left\n' ...
    '2) Upper Right\n' ...
    '3) Bottom Left\n' ...
    '4) Bottom Right\n' ...
    'Choice: ']); fprintf('---\n');

subplot(2,2,3)
if y==1
    imshow(upperLeft); title('Upper Left Corner');
elseif y==2
    imshow(upperRight); title('Upper Right Corner');
elseif y==3
    imshow(bottomLeft); title('Bottom Left Corner');
else
    imshow(bottomRight); title('Bottom Right Corner');
end


%% Rotation
y = input('Enter the angle of rotation for the image: '); fprintf('---\n');

RotImage = imrotate(Image,y);

subplot(2,2,4)
imshow(RotImage); title(sprintf('Rotation of %d°',y));


%% Histogram
figure(2)

subplot(3,3,[1,2,3]);
imhist(Image);
xlabel('Grayscale Value'), ylabel('Repetition Number'), title('Histogram');


%% Profile 
y = input(['Which profile would you like to see ?\n' ...
    '1) Line Only\n' ...
    '2) Column Only\n' ...
    '3) Line and Column\n' ...
    'Choice: ']);


if y==1
    % Profile of Line
    y = input('Enter your desired line number : ');
    
    subplot(3,3,[4,5,6]);
    plot(Image(y,:),'b');
    xlabel('Column Number');
    ylabel('Grayscale Value');
    title(sprintf('Profile of Line %d',y));
elseif y == 2
    % Profile of Column
    y = input('Enter your desired column number : ');
    
    subplot(3,3,[4,5,6]);
    plot(Image(:,y),'r');
    xlabel('Line Number');
    ylabel('Grayscale Value');
    title(sprintf('Profile of Column %d',y));
else
    % Profile of Line and Column
    y = input('Enter your desired number : ');
    
    subplot(3,3,[4,5,6]);
    x1 = (1:rows); x2 = (1:columns);
    plot(x1, Image(y,:),'b',x2, Image(:,y),'r');
    xlabel('Line/Column Number');
    ylabel('Grayscale Value');
    title(sprintf('Profile of Line and Column %d',y));
    legend('Line','Column','Fontsize',6); legend('boxoff');
end
fprintf('---\n');


%% Scanning
y = input('Which value would you like to isolate ? '); fprintf('---\n');

ScannedImage = Image;

for i=1:rows
   for j=1:columns
       if ScannedImage(i,j) == y
          ScannedImage(i,j) = 0;
       else
          ScannedImage(i,j) = 255;
       end
   end
end

subplot(3,3,8);
imshow(ScannedImage);
title(sprintf('Scanned Image of Value %d',y));



%% Noise and Filter
figure(3)

% --- Noise ---

% Gaussian Noise
subplot(3,3,1)
Gaussian = imnoise(Image,'gaussian');
imshow(Gaussian); title('Gaussian');

% Salt & Pepper Noise
subplot(3,3,2)
SaltPepper = imnoise(Image,'salt & pepper',0.2);
imshow(SaltPepper); title('Salt and Pepper');

% Speckle Noise
subplot(3,3,3)
Speckle = imnoise(Image,'speckle',0.03);
imshow(Speckle); title('Speckle');

% --- Filter ---

Filter = fspecial('average', 9);

% --- Gaussian ---

% Average Filter
subplot(3,3,4)
GaussianAverage = imfilter(Gaussian,Filter);
peaksnr = psnr(GaussianAverage, Image);
imshow(GaussianAverage); title(sprintf('Average\n(PSNR: %.3f)',peaksnr));

% Median Filter
subplot(3,3,7)
GaussianMedian = medfilt2(Gaussian);
peaksnr = psnr(GaussianMedian, Image);
imshow(GaussianMedian); title(sprintf('Median\n(PSNR: %.3f)',peaksnr));

% --- Salt & Pepper ---

% Average Filter
subplot(3,3,5)
SaltPepperAverage = imfilter(SaltPepper,Filter);
peaksnr = psnr(SaltPepperAverage, Image);
imshow(SaltPepperAverage); title(sprintf('Average\n(PSNR: %.3f)',peaksnr));

% Median Filter
subplot(3,3,8)
SaltPepperMedian = medfilt2(SaltPepper);
peaksnr = psnr(SaltPepperMedian, Image);
imshow(SaltPepperMedian); title(sprintf('Median\n(PSNR: %.3f)',peaksnr));

% --- Speckle ---

% Average Filter
subplot(3,3,6)
SpeckleAverage = imfilter(Speckle,Filter);
peaksnr = psnr(SpeckleAverage, Image);
imshow(SpeckleAverage); title(sprintf('Average\n(PSNR: %.3f)',peaksnr));

% Median Filter
subplot(3,3,9)
SpeckleMedian = medfilt2(Speckle);
peaksnr = psnr(SpeckleMedian, Image);
imshow(SpeckleMedian); title(sprintf('Median\n(PSNR: %.3f)',peaksnr));
