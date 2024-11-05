# DEEPFORGE

DEEPFORGE is a mobile application designed to detect forged objects in RGB images using advanced deep-learning techniques. Utilizing the YOLO v8n algorithm, the app provides real-time forgery detection, making it accessible and efficient for users in fields such as digital forensics, journalism, social media content moderation, and e-commerce.

## Table of Contents
- [Motivation](#motivation)
- [Problem Statement](#problem-statement)
- [Objectives](#objectives)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Installation](#installation)
- [Usage](#usage)
- [Testing and Performance](#testing-and-performance)
- [Challenges and Limitations](#challenges-and-limitations)
- [Future Work](#future-work)
- [Contributing](#contributing)
- [License](#license)

## Motivation
In today's digital age, image authenticity is critical due to the prevalence of sophisticated image manipulation tools. Forged images can lead to fraud, misinformation, and other malicious activities. DEEPFORGE leverages deep learning in a mobile app that is widely available and user-friendly, helping users identify fake objects in RGB images, contributing to a secure and trustworthy digital landscape.

## Problem Statement
The rise of advanced image editing tools has increased the prevalence of forged images, which compromise authenticity and contribute to misinformation and deception. Detecting these forgeries is essential for digital content integrity. Current methods are either manual, computationally intensive, or lack accuracy. DEEPFORGE addresses these challenges by offering an efficient, accessible solution that uses deep learning algorithms for forgery detection.

## Objectives

### Data Collection and Preparation
- Collect diverse datasets of forged RGB images, including copy-move and splicing examples.
- Preprocess images and labels for YOLO format compatibility and perform data augmentation.

### Model Development and Training
- Implement the YOLO v8n algorithm with pre-trained weights from the COCO dataset.
- Train the model on the prepared dataset, optimizing hyperparameters for high accuracy.

### Evaluation and Validation
- Assess model performance on a separate validation dataset to evaluate accuracy and generalization.

### Application Development
- Develop a cross-platform mobile application using Flutter.
- Integrate the trained model using `flutter_vision` and `tflight_flutter` packages.

### Testing and Deployment
- Conduct rigorous testing for reliability, performance, and user experience.
- Deploy the application to relevant app stores.

## Features
- **Real-Time Forgery Detection**: Detects forged objects in images with high accuracy and speed.
- **User-Friendly Interface**: Intuitive design for easy navigation and interaction.
- **Cross-Platform Compatibility**: Developed using Flutter for seamless integration on Android and iOS.
- **Detection Visualization**: Highlights manipulated regions with bounding boxes for easy identification.

## Technology Stack
- **Deep Learning Model**: YOLO v8n algorithm for object detection.
- **Mobile Development**: Flutter framework for cross-platform application.
- **Machine Learning Framework**: TensorFlow Lite for mobile model integration.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/YourUsername/DEEPFORGE.git
   cd DEEPFORGE
