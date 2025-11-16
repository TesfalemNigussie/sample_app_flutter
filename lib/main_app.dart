import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  double finalRestul = 0;

  void sum() {
    double num1 = double.parse(_controller1.text);
    double num2 = double.parse(_controller2.text);

    finalRestul = num1 + num2;
    setState(() {});
  }

  void sub() {
    double num1 = double.parse(_controller1.text);
    double num2 = double.parse(_controller2.text);

    finalRestul = num1 - num2;
    setState(() {});
  }

  void cal() {
    List<String> values = tokenize(_controller2.text);

    var result = double.parse(values[0]);
    var index = 0;

    if (values[0] == '/' || values[0] == '*' || values[0] == '+') {
      _controller2.text = '0';
    }

    for (var value in values) {
      if (index == 0) {
        index = index + 1;
        continue;
      }

      if (index == values.length) {
        continue;
      }

      if (value == '+') {
        result = result + double.parse(values[index + 1]);
      }

      if (value == '-') {
        result = result - double.parse(values[index + 1]);
      }

      if (value == '*') {
        result = result * double.parse(values[index + 1]);
      }

      if (value == '/') {
        result = result / double.parse(values[index + 1]);
      }

      index = index + 1;
    }

    finalRestul = result;
    setState(() {});
  }

  List<String> tokenize(String input) {
    final regex = RegExp(r'(\d+\.?\d*|\+|\-|\*|\/)');
    return regex.allMatches(input).map((m) => m.group(0)!).toList();
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
                  'Value is : $finalRestul',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(child: TextField(controller: _controller2)),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9oE3pYshr5glq8inya_1bHMy-Rzqy4mPjBg&s',
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (BuildContext context, int currentItemIndex) {
                      var text = '${currentItemIndex + 1}';

                      if (currentItemIndex == 3) {
                        text = '/';
                      }

                      if (currentItemIndex > 3 && currentItemIndex < 7) {
                        text = '$currentItemIndex';
                      }

                      if (currentItemIndex == 7) {
                        text = '*';
                      }

                      if (currentItemIndex > 7 && currentItemIndex < 11) {
                        text = '${currentItemIndex - 1}';
                      }

                      if (currentItemIndex == 11) {
                        text = '-';
                      }

                      if (currentItemIndex == 15) {
                        text = '+';
                      }

                      if (currentItemIndex == 12) {
                        text = 'C';
                      }

                      if (currentItemIndex == 13) {
                        text = '0';
                      }

                      if (currentItemIndex == 14) {
                        text = '=';
                      }

                      return GestureDetector(
                        onTap: () {
                          if (currentItemIndex == 14) {
                            cal();
                            return;
                          }

                          if (currentItemIndex == 12) {
                            _controller2.clear();
                            return;
                          }

                          _controller2.text = '${_controller2.text}$text';
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: currentItemIndex == 12
                              ? Icon(CupertinoIcons.clear_circled)
                              : Center(child: Text(text)),
                        ),
                      );
                    },
                    itemCount: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
