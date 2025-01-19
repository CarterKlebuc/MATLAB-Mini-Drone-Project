%% Ground Truth Import
clc, clear, close all

load firstLandingPadGroundTruth.mat gTruth

%% Preparing Data from Imported Ground Truth
[image_datastore, boundingbox_datastore] = objectDetectorTrainingData(gTruth);
ground_truth_data = combine(image_datastore, boundingbox_datastore);
shuffled_gtdata = shuffle(ground_truth_data);

%% Splitting Data into Training, Validation, and Testing Data
file_qty = numpartitions(shuffled_gtdata);
train_qty = floor(file_qty * 0.7);
val_qty = floor(file_qty * 0.1);

training_data = subset(shuffled_gtdata, 1:train_qty);
validation_data = subset(shuffled_gtdata, (train_qty + 1):(train_qty + val_qty));
testing_data = subset(shuffled_gtdata, (train_qty + val_qty + 1):(file_qty));

%% Train YOLO Detector
detector = yoloxObjectDetector("small-coco", "LandingPad", InputSize=[120 160 3]);
training_options = trainingOptions("adam", MiniBatchSize = 1, MaxEpochs=10, ValidationData=validation_data, ValidationFrequency=2, Plots="training-progress");

% Line Below should not end with a semicolon (output should be visible)
trained_detector = trainYOLOXObjectDetector(training_data, detector, training_options)

%% Object Detector Test
test_image = imread("TestParrotDownwardCircleImage.png");
[bbox, score, label] = detect(trained_detector, test_image, Threshold=0.75);

detected_image = insertObjectAnnotation(test_image, "rectangle", bbox, label);
imshow(detected_image)
title("Object Detector Test")

%% Save Model

save('yourDetector.mat', 'trained_detector');
save('detector73.mat', 'trained_detector', '-v7.3');


%% Reloading and Retesting Model

reloaded_model = load('yourDetector.mat').trained_detector;

test_image = imread("TestParrotDownwardCircleImage.png");
[bbox, score, label] = detect(reloaded_model, test_image, Threshold=0.75);

detected_image = insertObjectAnnotation(test_image, "rectangle", bbox, label);
imshow(detected_image)
title("Object Detector Test")