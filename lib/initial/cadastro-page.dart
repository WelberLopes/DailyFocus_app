import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // Para fazer requisição HTTP
import 'package:focus_app/login/tela_login.dart';

class SignUpPage extends StatefulWidget {
  static const String tag = 'sign-up-page';  // Rota para navegação

  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  // Função para enviar os dados para a API
  Future<void> register(String name, String email, String password) async {
    final url = Uri.parse('http://localhost:3000/alunos'); // Substitua pela URL da sua API

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        setState(() {
          _message = 'Cadastro realizado com sucesso!';
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginApp()), // Tela principal após login
        );
      } else {
        setState(() {
          _message = '${response.statusCode}Erro ao cadastrar. Tente novamente.';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Erro: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Cadastro'),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Cadastre-se no Focus!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Campo de Nome
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Campo de E-mail
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Campo de Senha
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent, // Cor de fundo
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        String name = _nameController.text;
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        register(name, email, password);
                      },
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _message,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    // Link para a tela de login
                    TextButton(
                      onPressed: () {
                        // Navega para a tela de login
                        Navigator.pushNamed(context, LoginApp.tag);
                      },
                      child: const Text(
                        'Já tem uma conta? Faça login.',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
