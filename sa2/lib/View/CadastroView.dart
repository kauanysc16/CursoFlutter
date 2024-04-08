import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _register(BuildContext context, String name, String email, String password) {
    // Aqui você adicionaria a lógica para criar uma nova conta
    // Por exemplo, chamar uma função para enviar os dados do novo usuário para um servidor
    // Substitua este exemplo com a lógica real do seu aplicativo
    print('Nome: $name, Email: $email, Senha: $password');

    // Após o cadastro bem-sucedido, você pode navegar para a próxima tela
    // Por exemplo, você pode navegar para a tela de login ou para a tela inicial do aplicativo
    Navigator.pushReplacementNamed(context, '/login'); // Substitui a tela atual pela tela de login
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
