% Landingpad Centering Algorithm
clc, clear, close all

test_image = imread("TestParrotDownwardCircleImage.png");
blurred_image = imgaussfilt(test_image, 2);
[centers, radii] = imfindcircles(blurred_image, [15 25])
%imshow(blurred_image)

screen_middle = int32([(160 / 2), (120 / 2)]);
circle_image = insertShape(blurred_image, "circle", [80, 60, 10], LineWidth=2);
imshow(circle_image)

hold on
viscircles(centers, radii, 'EdgeColor', 'b');
converted_vector = int32(centers);
plot(converted_vector(1), converted_vector(2), 'g+', 'MarkerSize', 30, 'LineWidth', 2);

% Plotting the Screen's Center and the Optimal Area to begin landing
plot(screen_middle(1), screen_middle(2), 'g+', 'MarkerSize', 30, 'LineWidth', 2);

errorx = 80 - converted_vector(1)
errory = 60 - converted_vector(2)