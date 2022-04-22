import 'package:flutter/material.dart';
import 'package:starting_app/gridview_demo.dart';
import 'package:starting_app/stream_demo.dart';

import 'home_page.dart';

void main() {
  streamDemo();
  // runApp(const MyDammiApp());
}

class MyDammiApp extends StatelessWidget {
  const MyDammiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => GridViewDemo(),
        "/homePage": (context) => HomePage(),
      },
    );
  }

  Widget demoWidgets() => Scaffold(
        appBar: AppBar(
          title: const Text("My info"),
        ),
        body: Column(
          children: [
            Image.asset(
              './images/notebook.jpeg',
              height: 60,
              width: 300,
              fit: BoxFit.cover,
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(12.0),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 24,
                    offset: Offset(12, 12),
                    spreadRadius: 12,
                  ),
                ],
              ),
              child: Row(
                children: const [
                  Text('asdf'),
                  Text('werwer'),
                ],
              ),
            ),
            const Text('This ')
          ],
        ),
      );
}

// abstract class MeroStatelessWidget {
//   Widget meroBuild();
// }

// class MeroDamiUi extends MeroStatelessWidget {
//   @override
//   Widget meroBuild() {
    // throw UnimplementedError();
//   }
// }

// void doThisFromFlutterSide(MeroStatelessWidget meroWidget) {
//   var wid = meroWidget.meroBuild();
// }

// void fromFlutterSide() {
//   doThis(MeroDamiUi());
// }
