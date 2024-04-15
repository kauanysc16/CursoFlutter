import 'package:sa2/Controller/DatabaseController.dart';

class LoginModel {
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<bool> authenticateUser(String email, String password) async {
    // Lógica de autenticação...
    bool isAuthenticated = await dbHelper.authenticateUser(email, password);
    return isAuthenticated;
  }
}
