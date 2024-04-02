import 'package:flutter/material.dart';
import 'package:sa2/View/CadastroView.dart'; // Importe a página de registro
import 'package:sa2/model/LoginModel.dart'; // Importe o modelo de login

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginModel _loginModel = LoginModel();

  // Função para lidar com o login do usuário
  void _login(BuildContext context, String email, String password) async {
    bool isAuthenticated = await _loginModel.authenticateUser(email, password);

    if (isAuthenticated) {
      // Se as credenciais forem válidas, navegue para a tela de configurações
      Navigator.pushReplacementNamed(context, '/settings'); // Substitui a tela atual pela tela de configurações
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
                Navigator.pop(context);
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
    );
  }
}
