import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _fontSize = 16.0; // Tamanho de fonte padrão
  String _selectedLanguage = 'Português'; // Idioma padrão
  List<String> _languages = ['Português', 'Inglês', 'Espanhol']; // Lista de idiomas disponíveis

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Configurações de Fonte',
              style: TextStyle(fontSize: _fontSize),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: _languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
            ),
            Slider(
              value: _fontSize,
              min: 10,
              max: 30,
              divisions: 4,
              onChanged: (newValue) {
                setState(() {
                  _fontSize = newValue;
                });
              },
              label: _fontSize.toStringAsFixed(0),
            ),
          ],
        ),
      ),
    );
  }
}
