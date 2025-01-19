# MATLAB-Mini-Drone-Project

This project is a custom flight controller for the Parrot Mambo created in Simulink for the MATLAB Mini-Drone Competition.

This is the video of the flight controller in action:

https://github.com/user-attachments/assets/07eb1711-39eb-4ff6-95b7-dce3455464b8

This is the image processing algorithm which the Parrot Mambo drone utilizes to follow the red line when the landing pad (in the shape of a circle) is not detected. The algorithm uses a hough transform on the camera image to detect if the landing pad is present by searching for a circular object. If the landing pad is not detected, a mask is placed over the image to filter out all colors not present in the red line. Only the red pixels will be represented as a white pixel in the mask. The camera image is then split into five sections (each in the shape of a square) (Northwest, North, Northeast, West, and East) where the number of white pixels in each section is calculated. Finally, the image processing algorithm will output the the number of white pixels in each section inside the masked image to the path planning component of the Flight Controller.

![Screenshot 2025-01-19 120846](https://github.com/user-attachments/assets/44433096-a6ad-43ed-bf66-f2e9190402c1)

This is the path planning component of the flight controller. This component recieves the totals of the number of white pixels in each section of the masked image from the image processing component. There the totals are inputted into a MATLAB function along with the greatest number of white pixels found to assign the corresponding direction of the image section with the greatest number of white pixels as the targeted direction for the drone (when the landing pad is not detected). This targeted direction is then inputted into a Stateflow Chart, along with variables to check if a landing pad is present and the coordinates of its center if found.

![Screenshot 2025-01-19 120911](https://github.com/user-attachments/assets/1a7bca82-bd58-4587-a0d1-cab7627c7fb0)

This is the Stateflow chart which is used to either guide the drone along the red line or center and land the drone on the landing pad once it is detected. The left side of the chart contains the logic neeeded to guide the drone along the red line. The right hand portion of the Stateflow chart contains the algorithm which centers the drone on the landing pad before sending the command for the drone to land on it.

![Screenshot 2025-01-19 121013](https://github.com/user-attachments/assets/223d6b4c-89f6-40db-b4dd-8a678bd22094)

This portion is used to guide the drone along the red line by using a MATLAB function to translate the inputted targeted direction for the drone into virtual motor commands.

![Screenshot 2025-01-19 121024](https://github.com/user-attachments/assets/f009d3d4-bd8f-4aca-b6ff-d496a0f2068b)

This portion is used to center the drone on the landing pad before landing on it by calculating the error between the detected center coordinates of the landing pad with the center of the drone's camera. Once the error between the center of the camera and the center of the landing pad is less than 2, the drone will then land on the landing pad.

![Screenshot 2025-01-19 121043](https://github.com/user-attachments/assets/9e451cfe-dc04-4699-938f-8e590a98e068)
