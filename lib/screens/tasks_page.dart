import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import 'month.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  double? _deviceHeight, _deviceWidth;
  String? content;
  Box? _box;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight! * 0.1,
        title: const Text("Todo List"),
      ),
      body: _tasksWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: displayTaskPop,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _todoList() {
    List tasks = _box!.values.toList();

    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          var task = Task.fromMap(tasks[index]);
          return ListTile(
            title: Text(
              task.todo,
              style: TextStyle(
                  decoration: task.done ? TextDecoration.lineThrough : null),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _box!.deleteAt(index);
                    setState(() {});
                  },
                ),
                task.done
                    ? const Icon(
                        Icons.check_box_outlined,
                        color: Colors.black,
                      )
                    : const Icon(Icons.check_box_outline_blank),
              ],
            ),
            onTap: () {
              task.done = !task.done;
              _box!.putAt(index, task.toMap());
              setState(() {});
            },
          );
        });
  }

  Widget _tasksWidget() {
    return FutureBuilder(
        future: Hive.openBox("tasks"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _box = snapshot.data;
            return _todoList();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void displayTaskPop() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add a Todo"),
            content: TextField(
              onSubmitted: (value) {
                if (content != null) {
                  var task = Task(
                      todo: content!, timeStamp: DateTime.now(), done: false);
                  _box!.add(task.toMap());
                  setState(() {
                    Navigator.pop(context);
                  });
                }
              },
              onChanged: (value) {
                setState(() {
                  content = value;
                });
              },
            ),
          );
        });
  }
}
