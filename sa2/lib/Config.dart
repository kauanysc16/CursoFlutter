import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Tamanho de fonte padrão
  double _fontSize = 16.0;

  // Idioma padrão
  String _selectedLanguage = 'Português';

  // Lista de idiomas disponíveis
  static const List<String> _languages = ['Português', 'Inglês', 'Espanhol'];

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
            // Configurações de Fonte
            Text(
              'Configurações de Fonte',
              style: TextStyle(fontSize: _fontSize),
            ),
            SizedBox(height: 20),
            // Dropdown para selecionar o idioma
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              // Cria itens do dropdown com base na lista de idiomas disponíveis
              items: _languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
            ),
            // Slider para ajustar o tamanho da fonte
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
              // Exibe o valor do slider como um rótulo
              label: _fontSize.toStringAsFixed(0),
            ),
          ],
        ),
      ),
    );
  }
}
