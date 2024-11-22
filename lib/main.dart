import 'package:flutter/material.dart';
import 'package:focus_app/home_page.dart';  // Certifique-se de que home_page.dart existe
import 'package:focus_app/login/tela_login.dart';
import 'package:focus_app/initial/welcome-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = {
    LoginApp.tag: (context) => const LoginApp(),
    AppTarefas.tag: (context) => const AppTarefas(),
    WelcomePage.tag: (context) => const WelcomePage(),
  };

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WelcomePage(), // Página inicial quando o app é carregado
      routes: routes, // Definindo as rotas para navegação
    );
  }
}
