# 🏥 DocTeleMY: AI Clinical Assistant for Rural Malaysia

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Cloud Vision API](https://img.shields.io/badge/Cloud%20Vision%20API-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white)
![Gemini API](https://img.shields.io/badge/Gemini%20API-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white)
![Speech-to-Text API](https://img.shields.io/badge/Speech--to--Text%20API-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white)
![Google Workspace](https://img.shields.io/badge/Google%20Workspace-4285F4?style=for-the-badge&logo=googleworkspace&logoColor=white)
![Google Meet Integration](https://img.shields.io/badge/Google%20Meet-00897B?style=for-the-badge&logo=googlemeet&logoColor=white)

**DocTeleMY** is an offline-first, AI-powered Clinical Decision Support System (CDSS) designed specifically for medical assistants staffing doctor-less rural clinics in regions like Sabah and Sarawak.

By combining Google's Gemini AI with a resilient local database architecture, DocTeleMY provides specialist-level triage guidance 24/7—even when the internet goes down.

## 🎯 The Problem
In rural Malaysia, nearly half of remote clinics operate without a resident doctor. Medical assistants face the daily burden of making life-or-death triage decisions with limited resources. Current AI tools fail here because they assume a constant 4G/5G connection, creating a digital divide where those who need AI the most cannot access it.

**UN SDGs Addressed:**
* **SDG 3.8:** Universal Health Coverage
* **SDG 9.c:** Resilient ICT Infrastructure (Offline-first functionality)
* **SDG 10.2:** Reduced Inequalities

## ✨ Key Features
* 📶 **Offline-First Architecture:** Powered by Floor (SQLite DAO), health workers can perform complete triage assessments and save records with zero internet connectivity. Data syncs to the cloud automatically when 2G/LTE is restored.
* 🤖 **Gemini-Powered Triage:** Utilizes **Gemini 1.5 Flash/Pro** to synthesize vitals (SpO2, heart rate), medical history, and symptoms into objective differential diagnoses.
* 🎙️ **Hands-Free Dictation:** Integrates **Google Speech-to-Text** allowing health workers to dictate symptoms rapidly in Bahasa Malaysia during high-stress emergencies.
* 🚦 **Visual Severity Zones:** Color-coded action banners (Red/Yellow/Green) for immediate urgency comprehension.

## 🛠️ Technology Stack
* **Frontend:** Flutter (Feature-First Clean Architecture)
* **Backend/Sync:** Firebase (Cloud Firestore, Authentication)
* **Local Database:** Floor (SQLite DAO pattern)
* **AI & Machine Learning:** Google AI Studio (Gemini API), Cloud Vision, Speech-to-Text

---

## 🚀 Getting Started

Follow these steps to run DocTeleMY on your local machine.

### Prerequisites
* Flutter SDK (`>=3.0.0`)
* Dart SDK
* Firebase CLI installed and authenticated

### Installation

1. **Clone the repository**
   
```
git clone https://github.com/Kearskill/kitahackLah.git
cd kitahacklah
```
   

2. **Install dependencies**
   
```
flutter pub get
```

3. **Run the App**

```
flutter run
```

environmental variables

```
lib/firebase_options.dart
firebase.json
android\app\google-services.json
```

📂 Project Structure
This project utilizes a Feature-First architecture:

`lib/core/`: Shared services, themes, and global database initialization.

`lib/features/triage/`: Self-contained module for the entire triage flow.

`/data/`: Contains the `TriageRecord` model, Floor DAO, and Repository.

`/widgets/`: UI components like `PatientInfoStep`, `VitalsStep`, and the stepper indicator.


👥 Team
[Learn And Hustle] - Hackathon Submission
