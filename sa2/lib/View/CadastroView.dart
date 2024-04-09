import 'package:flutter/material.dart';
import 'package:sa2/View/Login.dart';
import 'package:sa2/Controller/DatabaseController.dart'; // Importação do controlador do banco de dados
import 'package:sa2/model/UserModel.dart'; // Importação do modelo de usuário

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Método para registrar um novo usuário
  void _register(BuildContext context, String name, String email, String password) async {
    // Criar uma instância do usuário com os dados fornecidos
    User newUser = User(name: name, email: email, password: password);
    
    // Salvar o novo usuário no banco de dados e obter o resultado da operação
    int result = await DatabaseHelper().createUser(newUser);

    // Verificar se o usuário foi criado com sucesso
    if (result != 0) {
      // Se o usuário foi criado com sucesso, navegar para a tela de login
      Navigator.pushReplacementNamed(context, LoginPage() as String);
    } else {
      // Se houve um erro ao criar o usuário, exibir uma mensagem de erro
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Ocorreu um erro ao criar a conta. Por favor, tente novamente.'),
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
