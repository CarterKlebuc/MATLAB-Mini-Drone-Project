%% Testing Image for Circle

% Image file was loaded manually into MATLAB instead of imread()
my_image = TestParrotDownwardCircleImage(:, :, 1);
other_image = TestParrotDownwardImage(:, :, 1);
new_image = imgaussfilt(my_image, 2);
% imshow(new_image)
% [centers, radii] = imfindcircles(new_image, [10, 25])
% viscircles(centers, radii, 'EdgeColor', 'b');

edge_detect = edge(new_image, "canny");
edge_detect2 = edge(other_image, "canny");
[centers, something] = test_hough(edge_detect, [10 25]);
[centers2, something2] = test_hough(edge_detect2, [10 25])
imshow(edge_detect)