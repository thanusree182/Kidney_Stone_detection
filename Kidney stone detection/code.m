clc
clear all
close all
warning off
%The user is prompted to select an image file using the "uigetfile" function.
[filename,pathname]=uigetfile('*.*','Pick a MATLAB code file');
filename=strcat(pathname,filename);
%The image is loaded and displayed using the "imread" and "imshow" functions.
a=imread(filename);
imshow(a);
%The image is converted to grayscale using the "rgb2gray" function, and the grayscale image is displayed.
b=rgb2gray(a);
figure;
imshow(b);
%The pixel information tool is activated using the "impixelinfo" function.
impixelinfo;
%The grayscale image is thresholded using the ">" operator and a threshold value of 20.
c=b>20;
figure;
%The resulting binary image is displayed.
imshow(c);
%Holes in the binary image are filled using the "imfill" function.
d=imfill(c,'holes');
figure;
imshow(d);
%Objects smaller than 1000 pixels are removed from the binary image using the "bwareaopen" function.
e=bwareaopen(d,1000);
figure;
imshow(e);
%The binary image is used to create a mask that is applied to the original RGB image, resulting in a preprocessed image.
PreprocessedImage=uint8(double(a).*repmat(e,[1 1 3]));
figure;
imshow(PreprocessedImage);
%The preprocessed image is adjusted using the "imadjust" function and displayed.
PreprocessedImage=imadjust(PreprocessedImage,[0.3 0.7],[])+50;
figure;
imshow(PreprocessedImage);
%The preprocessed image is converted to grayscale using the "rgb2gray" function and displayed.
uo=rgb2gray(PreprocessedImage);
figure;
imshow(uo);
%Median filtering is applied to the grayscale image using the "medfilt2" function and displayed.
mo=medfilt2(uo,[5 5]);
figure;
imshow(mo);
%The grayscale image is thresholded using a value of 250 and displayed.
po=mo>250;
figure;
imshow(po);
[r, c, m]=size(po);
x1=r/2;
y1=c/3;
row=[x1 x1+200 x1+200 x1];
col=[y1 y1 y1+40 y1+40];
%A region of interest (ROI) is defined using the "roipoly" function.
BW=roipoly(po,row,col);
figure;
imshow(BW);
k=po.*double(BW);
figure;
imshow(k);
%Small objects in the masked image are removed using the "bwareaopen" function.
M=bwareaopen(k,4);
%The "bwlabel" function is used to count the number of connected components in the masked image.
[ya,number]=bwlabel(M);
%If the number of connected components is greater than or equal to 1, a message is displayed indicating that a stone has been detected. Otherwise, a message is displayed indicating that no stone has been detected.
if(number>=1)
    disp('Stone is Detected');
else
    disp('No Stone is detected');
end
