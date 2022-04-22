import 'package:flutter/material.dart';

import 'home_page.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      child: ListTile(
        leading: Text(todo.id.toString()),
        title: Text(todo.title),
        subtitle: Text(todo.completed ? 'Completed' : 'Pending'),
      ),
    );
  }
}
