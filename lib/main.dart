import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF1E1E1E),
        primaryColor: Color(0xFF2196F3),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2196F3),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF2C2C2C),
          labelStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  double? _resultado;
  String _operacion = '';
  bool _mostrarOperaciones = false;

  void _calcular(String operacion) {
    double num1 = double.tryParse(_controller1.text) ?? 0;
    double num2 = double.tryParse(_controller2.text) ?? 0;
    double res = 0;

    switch (operacion) {
      case 'Suma':
        res = num1 + num2;
        break;
      case 'Resta':
        res = num1 - num2;
        break;
      case 'Multiplicación':
        res = num1 * num2;
        break;
      case 'División':
        res = num2 != 0 ? num1 / num2 : double.nan;
        break;
      case 'Seno':
        res = sin(num1);
        break;
      case 'Coseno':
        res = cos(num1);
        break;
      case 'Tangente':
        res = tan(num1);
        break;
      case 'Potencia':
        res = pow(num1, num2).toDouble();
        break;
      case 'Raíz':
        res = num1 >= 0 ? sqrt(num1) : double.nan;
        break;
      case 'Logaritmo':
        res = num1 > 0 ? log(num1) : double.nan;
        break;
    }

    setState(() {
      _resultado = res;
      _operacion = operacion;
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora 10 Funciones'),
        backgroundColor: Color(0xFF121212),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _controller1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Número 1',
                    prefixIcon: Icon(Icons.looks_one, color: Colors.white70),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _controller2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Número 2',
                    prefixIcon: Icon(Icons.looks_two, color: Colors.white70),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _mostrarOperaciones = !_mostrarOperaciones;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calculate),
                      SizedBox(width: 8),
                      Text('Calculadora'),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                if (_mostrarOperaciones)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _calcButton('Suma'),
                          SizedBox(width: 8),
                          _calcButton('Resta'),
                          SizedBox(width: 8),
                          _calcButton('Multiplicación'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _calcButton('División'),
                          SizedBox(width: 8),
                          _calcButton('Potencia'),
                          SizedBox(width: 8),
                          _calcButton('Raíz'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _calcButton('Seno'),
                          SizedBox(width: 8),
                          _calcButton('Coseno'),
                          SizedBox(width: 8),
                          _calcButton('Tangente'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_calcButton('Logaritmo')],
                      ),
                    ],
                  ),
                SizedBox(height: 32),
                if (_resultado != null)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$_operacion: $_resultado',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper para los botones de operación
  Widget _calcButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: ElevatedButton(
          onPressed: () => _calcular(label),
          child: Text(
            label.contains('num1') ? label : label,
            style: TextStyle(fontSize: 14),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
