import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:starting_app/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = 'https://jsonplaceholder.typicode.com/todos/';
  bool isLoading = false;
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _getRemoteData();
            },
            child: Text('Get Data'),
          ),
        ),
        Expanded(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : todos.isEmpty
                  ? Container()
                  : ListView.separated(
                      itemCount: 30,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 6.0,
                      ),
                      itemBuilder: (context, index) {
                        return TodoItem(todo: todos[index]);
                      },
                    ),
        ),
      ]),
    );
  }

  void _getRemoteData() async {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      final ourData = jsonDecode(response.body) as List<dynamic>;

      for (var i = 0; i < ourData.length; i++) {
        final todo = Todo(
          id: ourData[i]["id"] as int,
          userId: ourData[i]["userId"] as int,
          completed: ourData[i]["completed"] as bool,
          title: ourData[i]["title"] as String,
        );
        todos.add(todo);
      }
      print(todos);
    } else {
      print("Error Occured");
    }
    setState(() {
      isLoading = false;
    });
  }
}

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });
}
