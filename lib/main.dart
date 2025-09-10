import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CalculatorScreen());
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreen();
}

class _CalculatorScreen extends State<CalculatorScreen> {
  String output = '0';
  String _output = '0';
  double num1 = 0;
  double num2 = 0;
  String operand = '';

  buttonPresses(String buttonText) {
    if (buttonText == 'C') {
      _output = '0';
      num1 = 0;
      num2 = 0;
      operand = '';
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      num1 = double.parse(output);
      operand = buttonText;
      _output = '0';
    } else if (buttonText == '=') {
      num2 = double.parse(output);

      switch (operand) {
        case '+':
          _output = (num1 + num2).toString();
          break;

        case '-':
          _output = (num1 - num2).toString();
          break;

        case '*':
          _output = (num1 * num2).toString();
          break;

        case '/':
          _output = (num1 / num2).toString();
          break;
      }

      num1 = 0;
      num2 = 0;
      operand = '';
    } else {
      if (_output == '0' && buttonText != '.') {
        _output = buttonText;
      } else {
        _output = output + buttonText;
      }
    }

    setState(() {
      if (_output.isEmpty || _output == '.') {
        _output = _output;
      } else if (buttonText == '=' ||
          operand.isEmpty && _output.contains(RegExp(r'[+\-*/]'))) {
        output = double.parse(
          _output,
        ).toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
      } else {
        output = _output;
      }
      if (output.endsWith(".00")) {
        output = output.substring(0, output.length - 3);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[850],
      ),

      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48, color: Colors.white),
            ),
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      buildButtton('7', Colors.grey[800]!),
                      buildButtton('8', Colors.grey[800]!),
                      buildButtton('9', Colors.grey[800]!),
                      buildButtton('/', Colors.orange),
                    ],
                  ),

                  Row(
                    children: [
                      buildButtton('4', Colors.grey[800]!),
                      buildButtton('5', Colors.grey[800]!),
                      buildButtton('6', Colors.grey[800]!),
                      buildButtton('*', Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButtton('1', Colors.grey[800]!),
                      buildButtton('2', Colors.grey[800]!),
                      buildButtton('3', Colors.grey[800]!),
                      buildButtton('-', Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButtton('.', Colors.grey[800]!),
                      buildButtton('0', Colors.grey[800]!),
                      buildButtton('C', Colors.grey[800]!),
                      buildButtton('+', Colors.orange),
                    ],
                  ),
                  Row(children: [buildButtton("=", Colors.green)]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24),
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            buttonPresses(buttonText);
          },
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
