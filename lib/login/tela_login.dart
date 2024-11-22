import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:focus_app/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:focus_app/initial/cadastro-page.dart';  // Corrigido o import

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});
  static const String tag = 'login-page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  String _mensagemErro = '';

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://localhost:3000/login'); // URL da API

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _mensagemErro = 'Login bem-sucedido!';
        });
        // Redireciona para a tela principal após o login bem-sucedido
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AppTarefas()), // Tela principal após login
        );
      } else {
        setState(() {
          _mensagemErro = 'Email ou senha incorreto';
        });
      }
    } catch (erro) {
      setState(() {
        _mensagemErro = 'Erro: $erro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // Conteúdo
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('assets/leon-avatar.jpg'),
              ),
              const SizedBox(height: 20),
              // Título
              const Text(
                'DailyFocus',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 40),
              // Formulário
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    // Campo de Email
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    // Campo de Senha
                    TextField(
                      controller: _senhaController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    // Botão de Login
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () async {
                        String email = _emailController.text;
                        String password = _senhaController.text;
                        await login(email, password);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Mensagem de Erro
                    if (_mensagemErro.isNotEmpty)
                      Text(
                        _mensagemErro,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 10),
                    // Botão para cadastro
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()), // Navega para a tela de cadastro
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink, // Cor do botão
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Borda arredondada
                        ),
                      ),
                      child: const Text(
                        'Ir para Cadastro', // Texto do botão
                        style: TextStyle(fontSize: 18, color: Colors.white), // Estilo do texto
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Principal'),
      ),
      body: const Center(
        child: Text(
          'Bem-vindo à tela principal!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
