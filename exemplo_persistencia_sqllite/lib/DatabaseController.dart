import 'package:exemplo_persistencia_sqllite/Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String DATABASE_NAME = 'contacts.db';
  static const String TABLE_NAME = 'contact';
  static const String CREATE_CONTACTS_TABLE_SCRIPT =
      "CREATE TABLE contacts(id INTEGER PRIMARY KEY," +
          "name TEXT, email TEXT, phone TEXT," +
          "addressLine1 TEXT)";

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasePath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_CONTACTS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  Future create(ContactModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.insert(
        TABLE_NAME,
        model.toMap(),
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<ContactModel>> getContacts() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

      return List.generate(
        maps.length,
        (i) {
          return ContactModel.fromMap(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      // ignore: unnecessary_new
      return new List<ContactModel>();
    }
  }
}
