import 'package:flutter/material.dart';
import 'package:sa2/model/ConfigModel.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsModel _settings = SettingsModel();

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
              style: TextStyle(fontSize: _settings.fontSize),
            ),
            SizedBox(height: 20),
            // Dropdown para selecionar o idioma
            DropdownButton<String>(
              value: _settings.selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  _settings.selectedLanguage = newValue!;
                });
              },
              // Cria itens do dropdown com base na lista de idiomas disponíveis
              items: SettingsModel.languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
            ),
            // Slider para ajustar o tamanho da fonte
            Slider(
              value: _settings.fontSize,
              min: 10,
              max: 30,
              divisions: 4,
              onChanged: (newValue) {
                setState(() {
                  _settings.fontSize = newValue;
                });
              },
              // Exibe o valor do slider como um rótulo
              label: _settings.fontSize.toStringAsFixed(0),
            ),
          ],
        ),
      ),
    );
  }
}
