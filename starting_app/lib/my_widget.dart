import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class MeroWidget extends StatefulWidget {
  const MeroWidget({Key? key}) : super(key: key);

  @override
  State<MeroWidget> createState() {
    return _MeroWidgetState();
  }
}

class _MeroWidgetState extends State<MeroWidget> {
  int index = 0;

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "home",
      activeIcon: Icon(
        Icons.home,
        color: Colors.blue,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.ac_unit_outlined),
      label: "Shorts",
      backgroundColor: Colors.black,
      activeIcon: Icon(
        Icons.home,
        color: Colors.blue,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.access_alarms),
      label: "News",
      activeIcon: Icon(
        Icons.access_alarms,
        color: Colors.blue,
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
      activeIcon: Icon(
        Icons.settings,
        color: Colors.blue,
      ),
    ),
  ];
  List<Widget> views = [
    Scaffold(
      body: Center(child: Text("THis is home")),
    ),
    Scaffold(
      body: Center(child: Text("THis is shorts")),
    ),
    Scaffold(
      body: Center(child: Text("THis is news")),
    ),
    Scaffold(
      body: Center(child: Text("THis is settings")),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    print("Building");
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful demo"),
      ),
      body: views[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: items,
        currentIndex: index,
        onTap: (ind) {
          setState(() {
            index = ind;
          });
        },
      ),
    );
  }
}
