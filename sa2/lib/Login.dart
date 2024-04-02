import 'package:flutter/material.dart';
import 'package:sa2/Cadastro.dart';
import 'package:sa2/DatabaseController.dart'; // Importe o helper do banco de dados
// Importe a página de configurações

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context, String email, String password) async {
    // Lógica de autenticação...
    DatabaseHelper dbHelper = DatabaseHelper(); // Instância do helper do banco de dados
    // Verificar se as credenciais são válidas
    bool isAuthenticated = await dbHelper.authenticateUser(email, password);

    if (isAuthenticated) {
      // Se as credenciais forem válidas, você pode navegar para a tela de configurações
      Navigator.pushReplacementNamed(context, '/Config.dart'); // Substitui a tela atual pela tela de configurações
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
