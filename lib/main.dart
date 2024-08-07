import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BmiCalculator(),
    );
  }
}

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmiResult = 0.0;
  String _bmiCategory = '';

  void _calculateBmi() {
    double? height = double.tryParse(_heightController.text);
    double? weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0 && weight > 0) {
      double bmi = weight / (height * height);
      setState(() {
        _bmiResult = bmi;
        if (bmi < 18.5) {
          _bmiCategory = 'Underweight';
        } else if (bmi < 25) {
          _bmiCategory = 'Normal weight';
        } else if (bmi < 30) {
          _bmiCategory = 'Overweight';
        } else {
          _bmiCategory = 'Obesity';
        }
      });
    } else {
      setState(() {
        _bmiResult = 0.0;
        _bmiCategory = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (meters)',
              ),
            ),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateBmi,
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 16.0),
            _bmiResult != null
                ? Column(
                    children: [
                      Text(
                        'BMI: ${_bmiResult.toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 24.0),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Category: $_bmiCategory',
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
