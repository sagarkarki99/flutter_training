import 'package:flutter/material.dart';
import 'package:starting_app/home_page.dart';

class GridViewDemo extends StatelessWidget {
  const GridViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gridview Demo"),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/homePage');
            },
            child: Container(
              color: Colors.red,
              child: Center(
                child: Text("Home"),
              ),
            ),
          ),
          Container(
            color: Colors.green,
            child: Center(
              child: Text("Settings"),
            ),
          ),
          Container(
            color: Colors.yellow,
            child: Center(
              child: Text("Options"),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child: Text("Home"),
            ),
          ),
          Container(
            color: Colors.orange,
          ),
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
