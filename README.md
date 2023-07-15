# Pest Detection, Classification and Pesticides Recommendation System

- [Features](#features)
- [Pests Classes](#pests-classes)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Executing program](#executing-program)
- [Technologies Used](#technologies-used)
- [Deployment](#deployment)
- [Future Enhancements](#future-enhancements)

<a href="#deployment">About The Project</a>

This project is a Flutter application designed to detect and classify pests in images uploaded or captured by users using their smartphones. The system utilizes the YOLOv5 model for accurate and real-time pest detection and classification. It also incorporates a recommendation system to suggest appropriate pesticides based on the identified pests.

## Features
+ User Authentication: Users can sign up and log in to the application to access its features.
+ Image Upload and Capture: Users can select an image from their phone's gallery or capture a real-time picture using their phone's camera.
+ Pest Detection and Classification: The selected or captured image is sent to a local server or API developed in Node.js. The server forwards the image to ROBOFLOW for processing using the YOLOv5 model. ROBOFLOW analyzes the image and provides a response to the server containing the class and confidence level of the detected pests.
+ Pesticides Recommendation: Based on the identified pests, the system generates recommendations for suitable pesticides that can be used to address the pest issue.
+ Flutter App Integration: The response from the server, containing the detected pests and recommended pesticides, is sent back to the Flutter app for display to the user.

## Pests Classes

The system is designed to identify and classify the following pest classes:

1. Aphids
1. Sawfly
1. Grasshopper
1. Green Leaf-hopper
1. Beetle
1. Armyworm

## Getting Started

### Prerequisites

Ensure that you have Flutter SDK and Node.js installed before running the project. Also, make sure you have connected an Android or iOS device or have a simulator/emulator set up to run the Flutter app.

### Executing program

To run both the Flutter app and the server using Visual Studio Code (VS Code), you can follow these steps:

1. Open VS Code.

1. Open the Flutter app folder and the backend server folder in separate VS Code windows/tabs. You can use the File -> Open Folder option to open each folder.
1. **For the Flutter app:**

   a. In the VS Code window/tab with the Flutter app folder, open a terminal within VS Code by going to View -> Terminal or using the keyboard shortcut Ctrl+ backtick.

   b. Run the following command to install the required dependencies:

   ```shell
   flutter pub get
   ```
   c. Once the dependencies are installed, you can launch the app on an Android or iOS device/emulator by running the following command:

   ```shell
   flutter run
   ```
   d. This command will build the Flutter app and launch it on a connected device or emulator.

1. **For the Backend server:**

   a. In the VS Code window/tab with the backend server folder, open a terminal within VS Code by going to View -> Terminal or using the keyboard shortcut Ctrl+ backtick.
   
   b. Run the following command to install the required packages:

   ```shell
   npm install
   ```
   c. Once the installation is complete, start the server by running the following command:

   ```shell
   npm start
   ```
   d. The server should now be running and ready to receive requests from the Flutter app.

By following these steps, you can simultaneously run the Flutter app and the backend server in VS Code. This allows you to test the app and interact with the server while having them both easily accessible within the same development environment.
   

## Technologies Used

+ Flutter: A cross-platform framework used for developing the mobile application.
+ YOLOv5: A state-of-the-art object detection model used for pest detection and classification.
+ ROBOFLOW: A platform for training, deploying, and managing computer vision models.
+ Node.js: A JavaScript runtime used for creating a local server and API to handle image processing and communication with ROBOFLOW.

## Deployment

To deploy the application locally, follow these steps:

1. Clone the repository from GitHub.
1. Set up the Flutter development environment.
1. Install the required dependencies specified in the project.
1. Run the Flutter application on an Android or iOS device/emulator.

## Future Enhancements

Here are some potential areas for future enhancements:

+ Integration of additional pest classes for a more comprehensive detection and classification system.
+ Integration of a database to store user data and historical pest detection records.
+ Implementation of real-time pest monitoring using the smartphone's camera feed.
+ Enhancement of the recommendation system with more sophisticated algorithms based on pest characteristics and pesticide effectiveness.
