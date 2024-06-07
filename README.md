# chat_chit

Welcome to the Chat Chit App! This Flutter application allows users to chat with friends.

## Function
  - User registration and login with Firebase Authentication
  - Chat with other users.
  - Edit or delete your messages.
  - Logout functionality.
  - User-friendly interface with a responsive design.

## Sreenshots
<div style="display:flex">
  <img src="https://github.com/minhanh0501/chat_chit/assets/102590487/1b1d304c-e01f-4dfd-8ba9-23280074a9f9" width="200"/>
  <img src="https://github.com/minhanh0501/chat_chit/assets/102590487/95b94e5e-fb2b-4ab7-92ee-4c53798fda35" width="200"/>
  <img src="https://github.com/minhanh0501/chat_chit/assets/102590487/35d567b9-1697-469a-9a8e-da63dc6028d4" width="200"/>
  <img src="https://github.com/minhanh0501/chat_chit/assets/102590487/521d3417-4b4b-4340-8e8b-e4b421adc9a5" width="200"/>
  <img src="https://github.com/minhanh0501/chat_chit/assets/102590487/b12fdea5-2e06-47cd-8409-e635060aa1c5" width="200"/>
</div>

## Get started
### Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed [Flutter](https://flutter.dev/docs/get-started/install) on your local machine.
- You have a Firebase project set up. If not, create one [here](https://console.firebase.google.com/).

### Set up Firebase and Connect Firebase
#### Into your flutter project, open terminal and type the following command
- Go to the Firebase Console and create a new project.
- Enable Authentication (Email/Password) in the Authentication section.
- Into your flutter project, open terminal and type the following command:
  + npm install -g firebase-tools
  + firebase login
  + dart pub global activate flutterfire_cli
  + flutterfire configure
  + flutter pub add firebase_core
  + flutter pub add firebase_auth
  + flutter pub add cloud_firestore

#### Run app: "main.dart"
```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'services/auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
```


