# AI Crash Log Explainer - Flutter App

A Flutter frontend for an AI-powered crash log explainer that transforms complex Flutter error logs into clear, human-readable explanations.

The app sends your Flutter stack trace and preferred language to a Python backend powered by **Gemini 3.6 Flash**, making debugging faster and more accessible.

---

## ✨ Features

- 🤖 AI-powered error analysis
- 📋 Paste Flutter error logs or stack traces
- 🌍 Choose your preferred explanation language
- 💡 Receive simple explanations with possible causes and fixes
- 📱 Clean and responsive Flutter UI

---

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **HTTP API**
- **Python Backend**
- **Gemini 3.6 Flash**

---

## 📷 Screenshots

> Add screenshots of your app here.

| Home | Result |
|------|--------|
| ![Home](screenshots/home.png) | ![Result](screenshots/result.png) |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Android Studio or VS Code
- An instance of the Python backend running

### Installation

1. Clone the repository

```bash
git clone https://github.com/yourusername/flutter_mobile_app.git
```

2. Navigate to the project

```bash
cd flutter_mobile_app
```

3. Install dependencies

```bash
flutter pub get
```

4. Configure the backend URL in the project.

5. Run the app

```bash
flutter run
```

---

## 📖 How It Works

1. Paste a Flutter error log or stack trace.
2. Select your preferred language.
3. The app sends the data to the Python backend.
4. The backend uses **Gemini 3.6 Flash** to analyze the error.
5. The explanation and possible fixes are returned and displayed in the app.

---

## 📂 Project Structure

```
lib/
├── screens/
├── widgets/
├── services/
├── models/
└── main.dart
```

---

## 🔗 Backend

This application works with a separate Python backend responsible for AI processing.

The backend:
- Receives the stack trace
- Uses Gemini 3.6 Flash
- Returns an easy-to-understand explanation with debugging suggestions

---

## 📌 Current Limitations

- Currently supports **Flutter** error logs only.
- Requires the backend service to be running.
- Internet connection is required for AI analysis.

---

## 🤝 Contributing

Contributions, feature requests, and bug reports are welcome. Feel free to open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the MIT License.
