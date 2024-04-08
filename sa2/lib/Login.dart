import 'package:flutter/material.dart';
import 'package:sa2/Cadastro.dart';
import 'package:sa2/DatabaseController.dart'; // Importe o helper do banco de dados
// Importe a página de configurações

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      // Se algum campo estiver vazio, exibe uma mensagem de erro
      _showErrorDialog(context, 'Erro de autenticação', 'Por favor, preencha todos os campos.');
      return;
    }

    // Mostrar um indicador de progresso enquanto autentica o usuário
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false, // Impede o fechamento do diálogo ao tocar fora dele
    );

    try {
      // Lógica de autenticação...
      DatabaseHelper dbHelper = DatabaseHelper(); // Instância do helper do banco de dados
      // Verificar se as credenciais são válidas
      bool isAuthenticated = await dbHelper.authenticateUser(email, password);

      if (isAuthenticated) {
        // Se as credenciais forem válidas, você pode navegar para a tela de configurações
        Navigator.pushReplacementNamed(context, 'Config.dart'); // Substitui a tela atual pela tela de configurações
      } else {
        // Se as credenciais não forem válidas, exibe uma mensagem de erro ao usuário
        _showErrorDialog(context, 'Erro de autenticação', 'Credenciais inválidas. Por favor, tente novamente.');
      }
    } catch (e) {
      // Se ocorrer uma exceção durante a autenticação, exibe uma mensagem de erro
      _showErrorDialog(context, 'Erro de autenticação', 'Ocorreu um erro durante a autenticação. Por favor, tente novamente mais tarde.');
    } finally {
      // Fecha o diálogo de progresso
      Navigator.pop(context);
    }
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
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
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login(context, emailController.text, passwordController.text);
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10), // Adiciona um espaço entre os botões
            TextButton(
              onPressed: () {
                // Navegue para a tela de cadastro quando o botão de cadastro for pressionado
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
