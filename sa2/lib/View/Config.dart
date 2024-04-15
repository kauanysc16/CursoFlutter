import 'package:flutter/material.dart';
import 'package:sa2/View/Login.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _fontSize = 16.0; // Tamanho padrão da fonte
  bool _isDarkMode = false; // Estado do tema
  Color _backgroundColor = Colors.white; // Cor de fundo padrão

  // Função para aumentar o tamanho da fonte
  void _increaseFontSize() {
    setState(() {
      _fontSize += 1.0;
    });
  }

  // Função para diminuir o tamanho da fonte
  void _decreaseFontSize() {
    setState(() {
      _fontSize -= 1.0;
    });
  }

  // Função para alternar entre o modo claro e escuro
  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      // Alterar a cor de fundo com base no modo selecionado
      _backgroundColor = _isDarkMode ? Colors.grey[900]! : Colors.white;
      // Aqui você pode adicionar lógica adicional para alterar outras cores com base no modo selecionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        // Adiciona um botão de voltar na AppBar para voltar à página anterior
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // Adiciona um botão "Sair" na AppBar
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginPage() as String, (route) => false);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tamanho da Fonte:',
              style: TextStyle(fontSize: 20.0),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _decreaseFontSize,
                  icon: Icon(Icons.remove),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Text(
                    '$_fontSize',
                    style: TextStyle(fontSize: _fontSize),
                  ),
                ),
                IconButton(
                  onPressed: _increaseFontSize,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _toggleDarkMode,
              child: Text(_isDarkMode ? 'Modo Claro' : 'Modo Escuro'),
            ),
          ],
        ),
      ),
      backgroundColor: _backgroundColor,
    );
  }
}
