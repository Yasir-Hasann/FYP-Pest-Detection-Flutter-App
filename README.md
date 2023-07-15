# Pest Detection, Classification, and Pesticides Recommendation System

This project is a Flutter application designed to detect and classify pests in images uploaded or captured by users using their smartphones. The system utilizes the YOLOv5 model for accurate and real-time pest detection and classification. It also incorporates a recommendation system to suggest appropriate pesticides based on the identified pests.

# Features
+ User Authentication: Users can sign up and log in to the application to access its features.
+ Image Upload and Capture: Users can select an image from their phone's gallery or capture a real-time picture using their phone's camera.
+ Pest Detection and Classification: The selected or captured image is sent to a local server or API developed in Node.js. The server forwards the image to ROBOFLOW for processing using the YOLOv5 model. ROBOFLOW analyzes the image and provides a response to the server containing the class and confidence level of the detected pests.
+ Pesticides Recommendation: Based on the identified pests, the system generates recommendations for suitable pesticides that can be used to address the pest issue.
+ Flutter App Integration: The response from the server, containing the detected pests and recommended pesticides, is sent back to the Flutter app for display to the user.

# Pests Classes

The system is designed to identify and classify the following pest classes:

1. Aphids
1. Sawfly
1. Grasshopper
1. Green Leaf-hopper
1. Beetle
1. Armyworm

# Technologies Used

+ Flutter: A cross-platform framework used for developing the mobile application.
+ YOLOv5: A state-of-the-art object detection model used for pest detection and classification.
+ ROBOFLOW: A platform for training, deploying, and managing computer vision models.
+ Node.js: A JavaScript runtime used for creating a local server and API to handle image processing and communication with ROBOFLOW.

# Deployment

To deploy the application locally, follow these steps:

1. Clone the repository from GitHub.
1. Set up the Flutter development environment.
1. Install the required dependencies specified in the project.
1. Run the Flutter application on an Android or iOS device/emulator.

# Future Enhancements

Here are some potential areas for future enhancements:

+ Integration of additional pest classes for a more comprehensive detection and classification system.
+ Integration of a database to store user data and historical pest detection records.
+ Implementation of real-time pest monitoring using the smartphone's camera feed.
+ Enhancement of the recommendation system with more sophisticated algorithms based on pest characteristics and pesticide effectiveness.
