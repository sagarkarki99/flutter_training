import 'package:flutter/material.dart';

//condition ? trueCase : falseCase;

class StackDemo extends StatefulWidget {
  const StackDemo({Key? key}) : super(key: key);

  @override
  State<StackDemo> createState() => _StackDemoState();
}

class _StackDemoState extends State<StackDemo> {
  bool isCleared = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack demo"),
      ),
      body: isCleared
          ? SizedBox()
          : Center(
              child: Stack(
                children: [
                  Container(
                    color: Colors.red,
                    height: 200,
                    width: 100,
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Image.asset(
                      './images/notebook.jpeg',
                      height: 100,
                      width: 80,
                    ),
                  ),
                  Positioned(
                    right: 8.0,
                    top: 4.0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isCleared = true;
                        });
                        print("Cross icon is pressed!");
                      },
                      child: Icon(
                        Icons.clear,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
