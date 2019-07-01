%{
Author: Dai Nguyen
Filename: Template_Creation.m
Description: This program will generate a letter and number template, which
will help the license plate detection to recognize letters easier.

References:
    1.https://circuitdigest.com/tutorial/vehicle-number-plate-detection-using-matlab-and-image-processing
    2.https://www.mathworks.com/matlabcentral/fileexchange/54456-licence-plate-recognition

%}
clc;           
clear;        
close all;  

%% Tell MatLab to read all images in the Training_Images folder

% Go to Training_Images folder
image_folder=dir('Training_Images');

% Get current list of items in the folder
file_name={image_folder.name};

% Get only images' filename 
% ignore current directory(.) and parent directory(..)
image_name_array=file_name(3:end);

% Create an image template holder to keep images and filenames
image_template=cell(2,length(image_name_array));

%% Loop through each image to format and push into the cell matrix template
for i=1:length(image_name_array)
    % ATTENTION: MACOS uses '/' while Windows uses '\' in the imread method
   image_template(1,i)={
       imread(['Training_Images','/',cell2mat(image_name_array(i))])
   };
   temp=cell2mat(image_name_array(i));
   image_template(2,i)={temp(1)};
end

%% Save and clear workspace variables
save('image_template.mat','image_template');
clear;