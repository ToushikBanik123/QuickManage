import 'package:appscrip_task_management_app/Screens/Task%20Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Api/Models/TaskModel.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Color statusColor;
  final void Function() onEdit;

  const TaskItem({required this.task, required this.statusColor, required this.onEdit, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskCard(task: task, onEdit: onEdit,),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 16.sp),
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(16.sp),
          border: Border.all(
            color: Colors.grey.withOpacity(0.8),
            width: 1.sp,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        task.status,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        task.priority,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(
                  color: Colors.black,
                  width: 2.sp,
                ),
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.white, size: 20.sp),
                  onPressed: onEdit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
