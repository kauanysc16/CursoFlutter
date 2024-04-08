import 'package:flutter/material.dart';
import 'package:sa2/DatabaseController.dart';
import 'package:sa2/Login.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _register(BuildContext context, String name, String email, String password) async {
  // Verificar se todos os campos foram preenchidos
  if (name.isEmpty || email.isEmpty || password.isEmpty) {
    _showErrorDialog(context, 'Erro no cadastro', 'Por favor, preencha todos os campos.');
    return;
  }

  // Instanciar a classe de gerenciamento de banco de dados
  DatabaseHelper dbHelper = DatabaseHelper();

  try {
    // Salvar os dados no banco de dados
    await dbHelper.saveUser(name, email, password);

    // Após salvar no banco de dados, navegar para a tela de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  } catch (e) {
    // Tratar qualquer exceção que possa ocorrer durante o salvamento no banco de dados
    _showErrorDialog(context, 'Erro no cadastro', 'Ocorreu um erro durante o cadastro. Por favor, tente novamente mais tarde.');
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
        title: Text('Cadastro'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
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
                  _register(
                    context,
                    nameController.text,
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
