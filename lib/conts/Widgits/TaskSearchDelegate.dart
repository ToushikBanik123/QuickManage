
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Api/Models/TaskModel.dart';
import '../../Provider/TaskProvider.dart';
import '../../Screens/UpdateTaskScreen.dart';
import 'TaskItem.dart';

class TaskSearchDelegate extends SearchDelegate<String?> {
  final TaskProvider taskProvider;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'To-Do':
        return Color.fromRGBO(252, 236, 170, 1); // Light yellow
      case 'In Progress':
        return Color.fromRGBO(197, 230, 239, 1); // Light blue
      case 'Done':
        return Color.fromRGBO(213, 232, 192, 1); // Light green
      default:
        return Colors.grey; // Default color
    }
  }

  TaskSearchDelegate({required this.taskProvider});

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, child) {
        // final suggestions = provider.filteredTasks;
        List<Task> suggestions = provider.tasks.where((task) =>
        task.title.toLowerCase().contains(query.toLowerCase()) ||
            task.description.toLowerCase().contains(query.toLowerCase())
        ).toList();
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final task = suggestions[index];
            return TaskItem(
              task: task,
              statusColor: _getStatusColor(task.status),
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateTaskScreen(task: task),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
}