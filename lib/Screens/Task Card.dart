import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Api/Models/TaskModel.dart'; // Import your Task model

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onEdit,
  }) : super(key: key);

  Color _getPriorityColor(String status) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Card(
        margin: EdgeInsets.symmetric(vertical: 100.sp, horizontal: 20.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
        elevation: 4.sp,
        child: Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: _getPriorityColor(task.status),
            borderRadius: BorderRadius.circular(16.sp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.orange, size: 24.sp),
                onPressed: onEdit,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.sp),
              Text(
                task.description,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.sp),
              Text(
                'Due Date: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.sp),
              Text(
                'Status: ${task.status}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.sp),
              Text(
                'Priority: ${task.priority}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.sp),
            ],
          ),
        ),
      ),
    );
  }
}
