import 'package:flutter/material.dart';
import 'package:focus_app/login/tela_login.dart';
import 'package:focus_app/sobre.dart';

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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SobreTela()), // Tela principal após login
                    );
                  },
                  child: const Text(
                    'Ver mais sobre o app',
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

class SobreTela extends StatelessWidget {
  const SobreTela({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o App'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Retorna para a tela de boas-vindas
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const WelcomePage()),
                  (Route<dynamic> route) => false, // Remove todas as rotas anteriores
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Este aplicativo foi desenvolvido para ajudar os usuários a manter o foco em suas tarefas diárias.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Através de funcionalidades como listas de tarefas e lembretes buscamos melhorar sua produtividade!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
