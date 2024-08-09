import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Api/Models/TaskModel.dart';
import '../../Provider/TaskProvider.dart';
import '../../Screens/UpdateTaskScreen.dart';
import 'TaskItem.dart';
import 'TaskSearchDelegate.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 16.sp),
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.sp),
        border: Border.all(
          color: Colors.grey.withOpacity(0.8),
          width: 1.sp,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4.sp,
            offset: Offset(0, 2.sp),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          showSearch(
            context: context,
            delegate: TaskSearchDelegate(taskProvider: taskProvider),
          );
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 16.sp),
        title: Text('Search Tasks', style: TextStyle(fontSize: 16.sp)),
        trailing: Container(
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
              icon: Icon(Icons.search_rounded, color: Colors.white, size: 20.sp),
              onPressed: () {
                    showSearch(
                      context: context,
                      delegate: TaskSearchDelegate(taskProvider: taskProvider),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}

