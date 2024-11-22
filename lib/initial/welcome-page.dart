import 'package:flutter/material.dart';
import 'package:focus_app/login/tela_login.dart';  // Import your Login page

void main() {
  runApp(MyApp());  // Wrap the app with MaterialApp in the main function
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Page',
      initialRoute: WelcomePage.tag,  // Start at the Welcome Page
      routes: {
        WelcomePage.tag: (context) => const WelcomePage(),
        LoginApp.tag: (context) => const LoginApp(),  // Add the LoginApp route
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  static const String tag = 'home-page';  // Tag for navigation

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DAILYFOCUS'),
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fundo com gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.yellow],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // O conteúdo da tela
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bem-vindo ao Focus!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent, // Cor de fundo
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    // Navega para a tela de login
                    Navigator.pushNamed(context, LoginApp.tag);
                  },
                  child: const Text(
                    'Ir para Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
