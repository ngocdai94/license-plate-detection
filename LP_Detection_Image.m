%{

%}
clc
close all;
clear;
load image_template.mat;

%% Display UI to choose an image
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
filePath=[path,file];

%% Read and resize the image to get image information
picture=imread(filePath);
[~,width]=size(picture);                % get picture width only
picture=imresize(picture,[300 500]);    % resize the picture

%% Format image to get a high contrast image to do image processing

% Get up to 3 rows of the picture array
if size(picture,3)==3
  picture=rgb2gray(picture);            % convert to gray scale
end


threshold = graythresh(picture);
picture =imbinarize(picture,threshold);
picture = bwareaopen(picture,30);
imshow(picture)

if width>2000
    picture1=bwareaopen(picture,3500);
else
    picture1=bwareaopen(picture,3000);
end

figure,imshow(picture1)
picture2=picture-picture1;
figure,imshow(picture2)
picture2=bwareaopen(picture2,200);
figure,imshow(picture2)

% Highlight detected object
[L,Ne]=bwlabel(picture2);
propied=regionprops(L,'BoundingBox');
hold on
pause(1)
for n=1:size(propied,1)
  rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off

figure
final_output=[];
t=[];
for n=1:Ne
    [r,c] = find(L==n);
    n1=picture(min(r):max(r),min(c):max(c));
    n1=imresize(n1,[42,24]);
    imshow(n1)
    pause(0.2)
    x=[ ];

    totalLetters=size(image_template,2);

    for k=1:totalLetters
        y=corr2(image_template{1,k},n1);
        x=[x y];
    end
     
    t=[t max(x)];
    if max(x)>.45
        z=find(x==max(x));
        out=cell2mat(image_template(2,z));

        final_output=[final_output out];
    end
end

%% Save result to text file
file = fopen('Plate_Number.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);                     