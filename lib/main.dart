import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HW02 - Calculator App',
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';
  String _operand = '';
  double? _firstNumber;
  double? _secondNumber;
  bool _isOperandPressed = false;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'CLEAR') {
        _display = '';
        _operand = '';
        _firstNumber = null;
        _secondNumber = null;
        _isOperandPressed = false;
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        if (_display.isNotEmpty && !_isOperandPressed) {
          _firstNumber = double.tryParse(_display);
          _operand = value;
          _isOperandPressed = true;
        }
      } else if (value == '=') {
        if (_firstNumber != null && _display.isNotEmpty) {
          _secondNumber = double.tryParse(_display);
          if (_secondNumber != null) {
            switch (_operand) {
              case '+':
                _display = (_firstNumber! + _secondNumber!).toString();
                break;
              case '-':
                _display = (_firstNumber! - _secondNumber!).toString();
                break;
              case '*':
                _display = (_firstNumber! * _secondNumber!).toString();
                break;
              case '/':
                _display = _secondNumber == 0
                    ? 'ERRORERRORERRORERRORERRORERRORERRORERROR'
                    : (_firstNumber! / _secondNumber!).toString();
                break;
            }
            _firstNumber = null;
            _secondNumber = null;
            _operand = '';
            _isOperandPressed = false;
          }
        }
      } else {
        if (_isOperandPressed) {
          _display = value;
          _isOperandPressed = false;
        } else {
          _display += value;
        }
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: InkWell(
        onTap: () => _onButtonPressed(value),
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 91, 160),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HW02 - My Trusty Calculator App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20.0),
              child: Text(
                _display,
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: ['7', '8', '9', '/'].map(_buildButton).toList(),
              ),
              Row(
                children: ['4', '5', '6', '*'].map(_buildButton).toList(),
              ),
              Row(
                children: ['1', '2', '3', '-'].map(_buildButton).toList(),
              ),
              Row(
                children: ['CLEAR', '0', '=', '+'].map(_buildButton).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
