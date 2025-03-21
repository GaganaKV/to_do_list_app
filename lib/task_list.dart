import 'package:flutter/material.dart';
import 'task.dart'; // ✅ Ensure this is imported

class TaskScreen extends StatefulWidget {
  // ✅ This class must exist
  const TaskScreen({super.key});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<Task> tasks = [];
  final TextEditingController taskController = TextEditingController();

  void addTask(String taskTitle) {
    if (taskTitle.isNotEmpty) {
      setState(() {
        tasks.add(Task(title: taskTitle));
      });
      taskController.clear();
    }
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: "Enter a new task",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: () {
                    addTask(taskController.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Checkbox(
                        value: tasks[index].isCompleted,
                        onChanged: (value) {
                          toggleTask(index);
                        },
                        activeColor: Colors.green,
                      ),
                      title: Text(
                        tasks[index].title,
                        style: TextStyle(
                          fontSize: 18,
                          decoration:
                              tasks[index].isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deleteTask(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Task deleted"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
