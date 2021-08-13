clc;
clear all;
inputing = imread('img01.png');

% Grayscale image of original image
I = rgb2gray(inputing);
figure;
imshow(I);

% Binary Image
BW = im2bw(I,0.11);
% BW = imbinarize(I);
figure;
imshow(BW);

%Inverting the binary image
Invert = imcomplement(BW);
%imshow(Invert);
imshowpair(Invert,BW,'montage')

%converting black spot into white colour
Filled = imfill(Invert,'holes');
figure,imshow(Filled)
title('Filled Image')

%converting white spot on black area with black colour
Filled2 = bwareaopen(Filled, 100);%Removing objects containing fewer than 50-100 pixels
imshow(Filled2)

%Boundaries tracing
boundary = bwboundaries(Filled2);
% disp(boundary);
% plot(boundary(:,2),boundary(:,1),'g','LineWidth',3);

%Measure
stats = regionprops('table',Filled2,'Centroid','MajorAxisLength','MinorAxisLength')

%centers and radii of the circles
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2)*0.2645833333;
radii = diameters/2;

%Plotting the circles.
hold on
viscircles(centers,radii);
hold off

%Inverting the image again
Final = imcomplement(Filled2);
imshow(Final)
