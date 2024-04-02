import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  late Database _db; // Não precisamos mais do tipo opcional

  // Getter para acessar o banco de dados
  Future<Database> get db async {
    // Verifica se o banco de dados já está aberto
    if (_db.isOpen) {
      return _db;
    }
    // Caso contrário, inicializa o banco de dados
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal(); // Construtor interno para implementar o padrão Singleton

  // Inicializa o banco de dados
  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app.db');

    // Abre ou cria o banco de dados
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Função chamada quando o banco de dados é criado pela primeira vez
  Future<void> _onCreate(Database db, int version) async {
    // Cria a tabela de usuários
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        password TEXT
      )
    ''');
    // Adicione outras tabelas conforme necessário
  }

  // Função para criar um novo usuário
  Future<int> createUser(User user) async {
    Database dbClient = await db;
    return await dbClient.insert('users', user.toMap());
  }

  // Função para obter um usuário pelo email
  Future<User?> getUserByEmail(String email) async {
    Database dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query('users',
        where: 'email = ?', whereArgs: [email]);

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  // Função para atualizar um usuário no banco de dados
  Future<int> updateUser(User user) async {
    Database dbClient = await db;
    return await dbClient.update('users', user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  // Função para excluir um usuário do banco de dados
  Future<int> deleteUser(int id) async {
    Database dbClient = await db;
    return await dbClient.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Função para autenticar um usuário pelo email e senha
  Future<bool> authenticateUser(String email, String password) async {
    Database dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query('users',
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    return result.isNotEmpty;
  }
}

// Classe que representa um usuário
class User {
  final int id;
  final String name;
  final String email;
  final String password;

  // Construtor da classe
  User({required this.id, required this.name, required this.email, required this.password});

  // Converte os dados do usuário para um mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Construtor de fábrica para criar um objeto User a partir de um mapa
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
