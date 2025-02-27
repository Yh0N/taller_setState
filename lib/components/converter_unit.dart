import 'package:flutter/material.dart';

class UnitConverter extends StatefulWidget {
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  String _selectedConversion = 'Temperatura';
  double _inputValue = 0.0;
  double _convertedValue = 0.0;
  Color _backgroundColor = Colors.lightBlue.shade100;

  void _convertValue(String input) {
    setState(() {
      _inputValue = double.tryParse(input) ?? 0.0;
      if (_selectedConversion == 'Temperatura') {
        _convertedValue = (_inputValue * 9 / 5) + 32;
      } else if (_selectedConversion == 'Longitud') {
        _convertedValue = _inputValue * 100;
      }
    });
  }

  void _changeConversion(String? newValue) {
    setState(() {
      _selectedConversion = newValue!;
      _inputValue = 0.0;
      _convertedValue = 0.0;

      if (_selectedConversion == 'Temperatura') {
        _backgroundColor = Colors.lightBlue.shade100;
      } else if (_selectedConversion == 'Longitud') {
        _backgroundColor = Colors.red.shade100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Unidades'),
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: _backgroundColor,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Seleccione el tipo de conversión:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedConversion,
              items: [
                DropdownMenuItem(
                  value: 'Temperatura',
                  child: Text('Celsius a Fahrenheit'),
                ),
                DropdownMenuItem(
                  value: 'Longitud',
                  child: Text('Metros a Centímetros'),
                ),
              ],
              onChanged: _changeConversion,
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _selectedConversion == 'Temperatura'
                    ? 'Ingrese la temperatura en Celsius'
                    : 'Ingrese la longitud en Metros',
                border: OutlineInputBorder(),
              ),
              onChanged: _convertValue,
            ),
            SizedBox(height: 20),
            Text(
              _selectedConversion == 'Temperatura'
                  ? 'Fahrenheit: ${_convertedValue.toStringAsFixed(2)}°F'
                  : 'Centímetros: ${_convertedValue.toStringAsFixed(2)} cm',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
