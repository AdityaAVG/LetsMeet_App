import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/MainWindow.dart'; // Import your MainWindow screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyD8R2OafctoAYWgkgDAkI9vjZsXakMIuWs",
        authDomain: "letsmeet-1a26d.firebaseapp.com",
        projectId: "letsmeet-1a26d",
        storageBucket: "letsmeet-1a26d.appspot.com",
        messagingSenderId: "341188907109",
        appId: "1:341188907109:web:19de9941718e9be91b768c",
        measurementId: "G-HWMPHG6F4G",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }


  runApp(FriendsApp());
}

class FriendsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friends App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.lightBlue.shade50,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
      home: AuthChecker(), // Use AuthChecker as the home screen
      routes: {
        '/MainWindow': (context) => MainWindow(), // Define your MainWindow route here
        '/Login': (context) => LoginScreen(),
        '/Signup': (context) => SignupScreen(),
      },
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking auth state
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          // If the user is logged in, go to the main window
          return MainWindow();
        } else {
          // If the user is not logged in, show the home screen with login/signup options
          return HomeScreen();
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.peopleGroup, size: 100, color: Colors.blueAccent), // Icon
                SizedBox(height: 20),
                Text(
                  'Discover Friends Along the Journey', // Updated text
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Login'); // Navigate using route name
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Signup'); // Navigate using route name
                  },
                  child: Text('Sign Up'),
                ),
                SizedBox(height: 20),
              ],
            )
        ),
      ),
    );
  }
}
