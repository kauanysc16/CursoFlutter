import 'package:flutter/material.dart';
import 'package:sa2/View/CadastroView.dart';
import 'package:sa2/View/Config.dart';
import 'package:sqflite_common/sqlite_api.dart';
import '../model/LoginModel.dart'; // Importe a página de configurações

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Função para lidar com o login do usuário
  Future<void> _login(BuildContext context, String email, String password) async {
    // Aqui você deve instanciar o modelo de login
    var _loginModel = LoginModel(password as Database, email); // Substitua LoginModel pelo nome do seu modelo de login

    // Chame o método de autenticação no modelo de login
    bool isAuthenticated = await _loginModel.authenticateUser(email, password);

    if (isAuthenticated) {
      // Se as credenciais forem válidas, navegue para a outra página
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SettingsPage()));
    } else {
      // Se as credenciais não forem válidas, exiba uma mensagem de erro ao usuário
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro de autenticação'),
          content: Text('Credenciais inválidas. Por favor, tente novamente.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Campo de texto para o email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              // Campo de texto para a senha
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              SizedBox(height: 20),
              // Botão para fazer login
              ElevatedButton(
                onPressed: () {
                  _login(context, emailController.text, passwordController.text);
                },
                child: Text('Login'),
              ),
              SizedBox(height: 10), // Adiciona um espaço entre os botões
              // Botão para navegar para a página de registro
              TextButton(
                onPressed: () {
                  // Navegue para a tela de registro quando o botão de registro for pressionado
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Criar uma conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
