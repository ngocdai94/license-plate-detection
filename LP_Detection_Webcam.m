%% Plate Detection with Dynamic Captured Images
% Description: This program will capture an image on a white background
% through camera. Then, it will count how many objects are on the white
% background. Finally, it will log the counter to ThingSpeak server

% ThingSpeak Public Channel Link: http://thingspeak.com/channels/287151

% Before running this program, the following packages must be installed 
% 1) webcam package
% 2) image processing toolbox
% 3) computer vision toolbox
% 4) ThingSpeak Addon

% Clear everything from previous programs
clear, clc, close all

%% Initialize Object
%USB Camera 1280x960 (for Mac)
%Logitech HD Webcam C270, 640x480 (for Windows)
vidObj = webcam('USB Camera','Resolution','1280x960');

%% Get a frame for frame-size information
frame = snapshot(vidObj);
frame = fliplr(frame);
frameSize = size(frame);

%% Create a video player instance
videoPlayer = vision.VideoPlayer('Position',[200 100 fliplr(frameSize(1:2)+30)]);

%% Add a close button to the figure
fig = findall(groot,'Tag','spcui_scope_framework');
setappdata(fig,'RequestedClose',false)
fig.CloseRequestFcn = @(~,~) setappdata(fig,'RequestedClose',true);

%% Loop through the main code until the player is closed
frameNumber = 0;
countObject = 0;
disp('Close the video player to exit');

while ~getappdata(fig,'RequestedClose')
    % try to see if the webcam can capture an image?
    % if not, force it to do
    try
        framergb = snapshot(vidObj);
    catch
        framergb = snapshot(vidObj);
    end
    
    
    if (frameNumber == 300)
        %% Capture an image at the 300th frame
        capturedImage = snapshot(vidObj);
        
        %% Display captured image
        subplot(2, 3, 1);
        imshow(capturedImage);
        title ('Captured Image');
        % Enlarge figure to full screen.
        % set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

        
        %% Convert the image to gray scale and display it
        grayImage = rgb2gray(capturedImage);
        subplot(2, 3, 2);
        imshow(grayImage);
        title ('Gray Image');
        
        % Alternative way to ensure correct color
        % 1) extract RBG, then covert each of them to gray scale 
        %    (using ib2bw function)
        % 2) sun all the gray scale colors
%         levelRed = 0.5;
%         levelGreen = 0.5;
%         levelBlue = 0.5;
%         i1 = im2bw(rmat, levelRed);
%         i2 = im2bw(rmat, levelGreen);
%         i3 = im2bw(rmat, levelBlue);
%         Isum = (i1&i2&i3);
%         grayImage = Isum;

%         grayImage = imbinarize(capturedImage, 'adaptive');
%         imshow(grayImage);
%         title ('Gray Image');
        
        %% Binarize the image and display it (Using Otsu's method)
        threshLevel = graythresh(grayImage);
        binaryImage = imbinarize(grayImage,threshLevel);
        subplot(2, 3, 3);
        imshow(binaryImage);
        title ('Binary Image');
        
        %% Convert white background to black background
        binaryImage = ~binaryImage;
        subplot(2, 3, 4);
        imshow(binaryImage);
        title('Inverted Background');
        
        %% Do a "hole fill" to get rid of any background pixels or
        % "holes" inside the blobs.
        binaryImage = imfill(binaryImage, 'holes');
        % Suppress light structures connected to image border collapse
        binaryImage =  imclearborder(binaryImage);
        
        %~~~~~~
        se = strel('disk',15);
        binaryImage = imdilate(binaryImage,se);
        
        labeledImage = bwlabel(binaryImage);
        st=regionprops(labeledImage,'area','Perimeter', 'MajorAxisLength','MinorAxisLength');
        
        % Get areas and perimeters of all the regions into single arrays.
        allAreas = [st.Area];
        allPerimeters = [st.Perimeter];
        
        % Compute circularities.
        circularities = allPerimeters.^2 ./ (4*pi*allAreas);
        diameters = mean([st.MajorAxisLength st.MinorAxisLength],2);
        radii = diameters/2;
        
        % Find objects that have "round" values of circularities.
        roundObjects = find(circularities < 1.2 & radii > 50); % Whatever value you want.
        
        % Compute new binary image with only the round objects in it.
        binaryImage = ismember(labeledImage, roundObjects) > 0;
        %imshow(binaryImage);
        % ~~~~~~~~~~~~~~`
        
        subplot(2, 3, 5);
        imshow(binaryImage);
        title ('Remove Image Detail');
        
        %% Count object
        % The bwlabel function is a very powerful function. It finds
        % the connectivity of the pixel to detect and count object
        [labeledImage, countObject] = bwlabel(binaryImage);
        
        % Display the counter in the command window
        disp(countObject);
        
        %% Display bounding retangles around objects
        rectBounding = regionprops(labeledImage);        
        for n=1:size(rectBounding)
            rectangle('Position', rectBounding(n).BoundingBox,'EdgeColor','g','LineWidth', 2);
        end
        
        %% Display text and counter on a image and show it
        subplot(2, 3, 6);
        imshow(binaryImage);
        title ('Counted Object');
        text(15,20,strcat('\color{green}Objects Found:',num2str(countObject)));    
    end

    % Increasing the video frame to read
    videoPlayer.step(framergb);
    frameNumber = frameNumber + 1;   
end


%% Image Classification


%% Clean up and realease memory
release(videoPlayer)
clear vidObj
clear fig
clear videoPlayer
