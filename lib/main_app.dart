import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  double result = 0;

  void sum() {
    double num1 = double.parse(_controller1.text);
    double num2 = double.parse(_controller2.text);

    result = num1 + num2;
    setState(() {

    });
  }

  void sub() {
    double num1 = double.parse(_controller1.text);
    double num2 = double.parse(_controller2.text);

    result = num1 - num2;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RepaintBoundary(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sample App',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
          
                Text(
                  'Value is : $result',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller1,
                        decoration: InputDecoration(hintText: 'Value 1'),
                      ),
                    ),
                    SizedBox(width: 50),
                    Expanded(
                      child: TextField(
                        controller: _controller2,
                        decoration: InputDecoration(hintText: 'Value 2'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        sum();
                      },
                      child: Text("+", style: TextStyle(fontSize: 30)),
                    ),
                    TextButton(
                      onPressed: () {
                        sub();
                      },
                      child: Text("-", style: TextStyle(fontSize: 30)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
