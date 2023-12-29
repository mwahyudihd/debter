import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '0';
  String output = '0';
  String operand = '';
  int num1 = 0;
  int num2 = 0;

  void _onDigitPress(String digit) {
    setState(() {
      if (input == '0' || input == 'Error') {
        input = digit;
      } else {
        input += digit;
      }
    });
  }

  void _onOperatorPress(String newOperand) {
    setState(() {
      operand = newOperand;
      num1 = int.parse(input);
      input = '0';
    });
  }

  void _onEqualPress() {
    setState(() {
      num2 = int.parse(input);
      if (operand == '+') {
        output = (num1 + num2).toString();
      } else if (operand == '-') {
        output = (num1 - num2).toString();
      } else if (operand == 'x') {
        output = (num1 * num2).toString();
      } else if (operand == '/') {
        if (num2 != 0) {
          output = (num1 / num2).toString();
        } else {
          output = 'Error';
        }
      }
      input = output;
      operand = '';
    });
  }

  void _onClearPress() {
    setState(() {
      input = '0';
      output = '0';
      operand = '';
      num1 = 0;
      num2 = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: const Text('Kalkulator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.brown[500],
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                input,
                style: TextStyle(fontSize: 40.0, color: Colors.yellowAccent),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.yellowAccent,
              child: Column(
                children: <Widget>[
                  _buildRow(
                    ['7', '8', '9', '/'],
                  ),
                  _buildRow(
                    ['4', '5', '6', 'x']
                    ),
                  _buildRow(
                    ['1', '2', '3', '-']
                    ),
                  _buildRow(
                    ['0', 'C', '=', '+']
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((button) {
          return Expanded(
            child: _buildButton(button),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildButton(String label) {
    return TextButton(
      onPressed: () {
        if (label == 'C') {
          _onClearPress();
        } else if (label == '=') {
          _onEqualPress();
        } else if (['+', '-', 'x', '/'].contains(label)) {
          _onOperatorPress(label);
        } else {
          _onDigitPress(label);
        }
      },
      child: Text(
        label,
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CalculatorPage(),
  ));
}
