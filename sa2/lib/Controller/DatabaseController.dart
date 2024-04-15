import 'dart:async';
import 'package:path/path.dart';
import 'package:sa2/model/UserModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton para garantir apenas uma instância do DatabaseHelper
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  // Método para limpar todos os dados do usuário no banco de dados
  static Future<void> clearUserData() async {
    final Database db = await openDatabase('app.db');
    await db.delete('users');
    await db.close();
  }

  // Getter para acessar o banco de dados
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  // Método para inicializar o banco de dados
  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app.db');

    // Abra o banco de dados e crie a tabela de usuários
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Método chamado durante a criação do banco de dados para criar a tabela de usuários
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      email TEXT,
      password TEXT
    )
  ''');
  }

  // Método para criar um novo usuário no banco de dados
  Future<int> createUser(User user) async {
    Database dbClient = await db as Database;
    return await dbClient.insert('users', user.toMap());
  }

  // Métodos para autenticar, salvar e buscar usuários podem ser implementados aqui
}
