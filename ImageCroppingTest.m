%% Image Crop Test

original_image = imread("TestParrotDownwardImage.png");

top_left_portion = imcrop(original_image, [0, 0, 59, 42]);
top_center_portion = imcrop(original_image, [60, 0, 39, 42]);
top_right_portion = imcrop(original_image, [100, 0, 59, 42]);

center_left_portion = imcrop(original_image, [0, 42, 59, 42]);
center_right_portion = imcrop(original_image, [100, 42, 59, 42]);


subplot(2, 3, 1);
imshow(top_left_portion)
title("Top Left Portion")
subplot(2, 3, 2);
imshow(top_center_portion)
title("Top Center Portion")
subplot(2, 3, 3);
imshow(top_right_portion)
title("Top Right Portion")

subplot(2, 3, 4)
imshow(center_left_portion);
title("Center Left Portion")

subplot(2, 3, 5);
imshow(center_right_portion);
title("Center Right Portion")

