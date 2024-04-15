import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app.db');

    // Abra o banco de dados
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Crie a tabela de usuários
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

  Future<int> createUser(User user) async {
    Database dbClient = await db as Database;
    return await dbClient.insert('users', user.toMap());
  }

  authenticateUser(String email, String password) {}

  saveUser(String name, String email, String password) {}

  // Implemente outros métodos para manipular o banco de dados, como buscar usuários, atualizar, deletar, etc.
}

class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

