import 'package:sqflite/sqflite.dart';

class LoginModel {
  // Função para simular autenticação do usuário
  Future<bool> authenticateUser(String email, String password) async {
    // Neste modelo, apenas verifica se o email e a senha não estão vazios
    if (email.isNotEmpty && password.isNotEmpty) {
      return true; // Retorna verdadeiro se ambos não estiverem vazios
    } else {
      return false; // Retorna falso se algum estiver vazio
    }
  }
   final Database _database; // Instância do banco de dados

  // Construtor que recebe uma instância do banco de dados
  LoginModel(this._database, String email);

  // Função para autenticar o usuário
  Future<bool> authenticatorUser(String email, String password) async {
    // Consulta ao banco de dados para verificar se o usuário existe
    List<Map<String, dynamic>> results = await _database.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    // Se a consulta retornar algum resultado, significa que o usuário existe
    if (results.isNotEmpty) {
      return true; // Retorna verdadeiro se o usuário existir
    } else {
      return false; // Retorna falso se o usuário não existir
    }
  }
}

