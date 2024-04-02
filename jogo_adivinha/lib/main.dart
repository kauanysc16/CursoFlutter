import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  TextEditingController _controllerNumero1 = TextEditingController();
  String _resultado = '';
  int numeroSorteado = Random().nextInt(99) + 1;
  int cont = 0;

  void _adivinhar() {
    int numero = int.tryParse(_controllerNumero1.text) ?? 0;
    setState(() {
      if (numero == numeroSorteado) {
        _resultado = "Parabéns!!! Você acertou!!! Em $cont tentativas";
        cont = 0;
        numeroSorteado = Random().nextInt(99) + 1;
      } else if (numero > numeroSorteado) {
        _resultado = "Errou!!! Tente um Nº Menor";
        cont++;
      } else {
        _resultado = "Errou!!! Tente um Nº Maior";
        cont++;
      }
    });
  }

  void _resetGame() {
    setState(() {
      _resultado = '';
      _controllerNumero1.text = '';
      numeroSorteado = Random().nextInt(99) + 1;
      cont = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo Adivinhação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerNumero1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Informe um Nº'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => _adivinhar(),
              child: Text('Adivinhar'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => _resetGame(),
              child: Text('Reset'),
            ),
            SizedBox(height: 16.0),
            Text(_resultado,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            Text(
              'Tentativas: $cont',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
