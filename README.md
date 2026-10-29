[10/29/2026 1:25 PM] Naili Abderrahim: # 🌱 Smart Farming Assistant - Nabit (نبت)

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white)
![TensorFlow](https://img.shields.io/badge/TensorFlow-%23FF6F00.svg?style=for-the-badge&logo=TensorFlow&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

Repository Link: [https://github.com/abderrahimnaili-cell/ai-farming-app](https://github.com/abderrahimnaili-cell/ai-farming-app)

---

## 📌 Project Abstract

The Smart Farming Assistant is a comprehensive mobile application designed to digitize and support the agricultural sector. The project aims to empower farmers by integrating Artificial Intelligence (AI) into daily farming operations. The application leverages the Flutter framework to build a unified, high-performance frontend that runs on both Android and iOS from a single codebase (Cross-Platform). The system provides an integrated solution combining early plant disease diagnosis, personalized farming recommendations, agricultural e-commerce, and continuous education, with the goal of increasing productivity and reducing losses.

---

## 🏗️ System Architecture & Technical Stack

The application is engineered using a modular architecture to ensure maintainability and future scalability.

### 1. Presentation Layer (Frontend)
*   Technology: Flutter (Dart language) for cross-platform mobile development.
*   Components: An interactive interface including a Splash screen, a Home Dashboard displaying weather and crop status, and dedicated screens for each module (Diagnosis, Marketplace, Education).
*   Features: Flutter's customizable Widget system enables a responsive, smooth design that supports Dark Mode and multi-language support (Arabic, French, English).

### 2. Business Logic Layer (Backend)
*   Technology: Node.js (Express) or PHP (Laravel) with RESTful API.
*   Description: The backend manages authentication, farm data processing, and marketplace operations. Features a clear separation of endpoints for each service (e.g., /api/diagnosis, /api/marketplace, /api/recommendations), facilitating seamless integration with the Flutter app via libraries such as http or dio.

### 3. Data Persistence Layer (Database)
*   Technology: PostgreSQL / MySQL.

### 4. AI Layer
*   Technology: TensorFlow Lite.
*   Description: A Deep Learning model embedded in the Flutter application via dedicated packages (e.g., tflite_flutter) to analyze plant images and diagnose diseases with high accuracy, without requiring continuous internet connectivity (Offline Capability).

---

## ⚙️ Functional Workflow

The following scenario illustrates the integration of the system's layers from the user's perspective:

1.  Initial Interaction (Flutter Frontend): The farmer logs in, selects a language, and navigates to the dashboard displaying weather summaries and alerts.
2.  Diagnosis (AI & API): The farmer captures an image of an infected plant using the device camera (via the image_picker package in Flutter). The image is sent to the embedded AI model (TensorFlow Lite).
3.  Result Processing (Backend): The model analyzes the image and returns the disease name, severity level, and treatment suggestions. The result is stored in the database (Diagnosis History) via the API.
4.  Recommendations (Backend): Based on farm data (soil type, region), the system provides personalized recommendations on what to plant and when.
5.  Marketplace: The farmer can list products for sale and communicate with buyers via an integrated chat system, completing the digital agricultural economy cycle.

---

## ✨ Technical Highlights & Value Proposition
[10/29/2026 1:25 PM] Naili Abderrahim: *   📱 Cross-Platform Development: Using Flutter allows the application to run on both Android and iOS from a single codebase, reducing development time and cost.
*   🧠 Embedded AI: The integration of TensorFlow Lite with Flutter enables fast, on-device diagnosis without relying on a central server, reducing cost and increasing speed.
*   🌍 Multi-language & Accessibility: Support for three languages (Arabic, French, English) and Dark Mode ensures the application is inclusive for all user groups.
*   🛒 Integrated Ecosystem: The application combines diagnosis, education, and commerce into a single platform, reducing the need for farmers to juggle multiple apps.
*   🚀 Scalability: The modular architecture (Flutter + Node.js/PHP + REST API) allows for the seamless addition of advanced features (such as interactive agricultural maps and production statistics).

---

## 📱 Application Features

*   AI Disease Diagnosis: Scan plant leaves using the camera for instant offline analysis.
*   Weather Forecast: Real-time weather dashboard with a 7-day forecast (localized per region).
*   Community Feed: Share posts, ask questions, and interact with other farmers (with tags for Disease, Irrigation, Market, Soil).
*   Marketplace: Buy and sell agricultural products, seedlings, and produce.
*   Secure Checkout: Integrated payment methods (BaridiMob, Edahabia, Cash on Delivery) with full delivery address management.
*   Smart Tools: Agricultural Map, Production Statistics, AI Chatbot, and a Smart Farm Calendar for task scheduling.
*   Education: Interactive Farming & Plant Care Quizzes to earn points and learn best practices.
*   User Profile: Verified farmer accounts with farm details, listing history, and diagnosis records.

---

## 🚀 Getting Started (Installation)

1.  Clone the repository:
   
    git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
    
2.  Navigate to the project directory:
   
    cd smart_farming_assistant
    
3.  Install dependencies:
   
    flutter pub get
    
4.  Run the app:
   
    flutter run
    
---

## 📄 License

This project is developed for academic and technical demonstration purposes.

---

*The "Smart Farming Assistant" represents an advanced technical solution reflecting a deep understanding of modern agricultural needs. It combines advanced software engineering (Full-Stack Development) using Flutter with AI technologies, making it an effective tool for improving agricultural productivity and digitizing farming operations.*
