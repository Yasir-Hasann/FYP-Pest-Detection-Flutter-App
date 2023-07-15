<a name="readme-top"></a>

<div align="justify">
<p align="center">
<img src="https://github.com/Yasir-Rana/FYP-Pest-Detection-Flutter-App/assets/99634661/40a8bc3e-669c-4a73-bf52-9a9f18743824" alt="Login User" width="200" />

<img src="https://github.com/Yasir-Rana/FYP-Pest-Detection-Flutter-App/assets/99634661/71408f39-ab0a-4e13-8c14-932d9fd0003b" alt="Pest Detection" width="200" height="387" />

<img src="https://github.com/Yasir-Rana/FYP-Pest-Detection-Flutter-App/assets/99634661/861d0b14-43d5-4280-9a1f-4be99cd60933" alt="No Pest" width="200" height="387" />
</p>


# Pest Detection, Classification and Pesticides Recommendation System

This project is a Flutter application designed to detect and classify pests in images uploaded or captured by users using their smartphones. The system utilizes the YOLOv5 model for accurate and real-time pest detection and classification. It also incorporates a recommendation system to suggest appropriate pesticides based on the identified pests.

<details>
<summary><strong>Table of Contents</strong></summary>

- [Features](#features)
- [Pests Classes](#pests-classes)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Executing program](#executing-program)
- [Technologies Used](#technologies-used)
- [Future Enhancements](#future-enhancements)

</details>

## Features
+ User Authentication: Users can sign up and log in to the application to access its features.
+ Image Upload and Capture: Users can select an image from their phone's gallery or capture a real-time picture using their phone's camera.
+ Pest Detection and Classification: The selected or captured image is sent to a local server or API developed in Node.js. The server forwards the image to ROBOFLOW for processing using the YOLOv5 model. ROBOFLOW analyzes the image and provides a response to the server containing the class and confidence level of the detected pests.
+ Pesticides Recommendation: Based on the identified pests, the system generates recommendations for suitable pesticides that can be used to address the pest issue.
+ Flutter App Integration: The response from the server, containing the detected pests and recommended pesticides, is sent back to the Flutter app for display to the user.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Pests Classes

The system is designed to identify and classify the following pest classes:

1. Aphids
1. Sawfly
1. Grasshopper
1. Green Leaf-hopper
1. Beetle
1. Armyworm

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Getting Started

### Prerequisites

Ensure that you have Flutter SDK and Node.js installed before running the project. Also, make sure you have connected an Android or iOS device or have a simulator/emulator set up to run the Flutter app.


### Executing program

To run both the Flutter app and the server using Visual Studio Code (VS Code), you can follow these steps:

1. Open VS Code.

1. Open the Flutter app folder and the backend server folder in separate VS Code windows/tabs. You can use the File -> Open Folder option to open each folder.
 
**For the Flutter app:**

1. In the VS Code window/tab with the Flutter app folder, open a terminal within VS Code by going to View -> Terminal or using the keyboard shortcut Ctrl+ backtick.

1. Run the following command to install the required dependencies:

   ```shell
    flutter pub get
   ```
1. Once the dependencies are installed, you can launch the app on an Android or iOS device/emulator by running the following command:

   ```shell
    flutter run
    ```

1. This command will build the Flutter app and launch it on a connected device or emulator.

**For the Backend server:**

1. In the VS Code window/tab with the backend server folder, open a terminal within VS Code by going to View -> Terminal or using the keyboard shortcut Ctrl+ backtick.
   
1. Run the following command to install the required packages:

   ```shell
    npm install
   ```
1. Once the installation is complete, start the server by running the following command:

   ```shell
    npm start
   ```
1. The server should now be running and ready to receive requests from the Flutter app.

By following these steps, you can simultaneously run the Flutter app and the backend server in VS Code. This allows you to test the app and interact with the server while having them both easily accessible within the same development environment.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
   

## Technologies Used

+ Flutter: A cross-platform framework used for developing the mobile application.
+ YOLOv5: A state-of-the-art object detection model used for pest detection and classification.
+ ROBOFLOW: A platform for training, deploying, and managing computer vision models.
+ Node.js: A JavaScript runtime used for creating a local server and API to handle image processing and communication with ROBOFLOW.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Future Enhancements

Here are some potential areas for future enhancements:

+ Integration of additional pest classes for a more comprehensive detection and classification system.
+ Integration of a database to store user data and historical pest detection records.
+ Implementation of real-time pest monitoring using the smartphone's camera feed.
+ Enhancement of the recommendation system with more sophisticated algorithms based on pest characteristics and pesticide effectiveness.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

</div>
