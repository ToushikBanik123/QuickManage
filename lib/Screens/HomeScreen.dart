import 'package:appscrip_task_management_app/conts/Widgits/SearchTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Api/Models/TaskModel.dart';
import '../Provider/UserProvider.dart';
import '../Provider/AuthProvider.dart';
import '../Provider/TaskProvider.dart';
import '../conts/Widgits/DrawerHeaderWidget.dart';
import '../conts/Widgits/LogoutTile.dart';
import '../conts/Widgits/TaskItem.dart';
import '../conts/color.dart';
import 'TaskFormScreen.dart';
import 'UpdateTaskScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Screen'),
        actions: [
          Consumer<TaskProvider>(builder: (context,provider,child){
            return Switch(
              value: provider.showAssignedTasks,
              onChanged: (value) {
                provider.setShowAssignedTasks(value);
              },
              activeColor: Palette.iconix,
              inactiveTrackColor: Colors.grey,
              activeTrackColor: Colors.grey[300],
            );
          })
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeaderWidget(userProvider: userProvider),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SearchTile(),
                  LogoutTile(authProvider: authProvider),
                ],
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<void>(
        future: taskProvider.fetchTasks(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<TaskProvider>(
              builder: (context, provider, child) {
                List<Task> filteredTasks = provider.showAssignedTasks
                    ? provider.tasks.where((task) => task.userId == userProvider.user?.id).toList()
                    : provider.tasks;

                if (filteredTasks.isEmpty) {
                  return const Center(child: Text('No tasks available.'));
                }
                return ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return Dismissible(
                      key: Key(task.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      onDismissed: (direction) async {
                        await provider.deleteTask(task.id, context);
                        await provider.fetchTasks(context);
                      },
                      child: TaskItem(
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
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskFormScreen()),
          );
        },
        backgroundColor: Palette.iconix,
        tooltip: 'Add Task',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
