import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../Api/Models/TaskModel.dart';
import '../Api/Models/ApiUserModel.dart';
import '../Provider/TaskProvider.dart';
import 'package:provider/provider.dart';

import '../conts/color.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Task task;

  UpdateTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _dueDate;
  late String _title;
  late String _description;
  late String _priority;
  late String _status;
  late int _assignedUserId;
  List<ApiUserModel> _users = [];

  @override
  void initState() {
    super.initState();
    _dueDate = widget.task.dueDate;
    _title = widget.task.title;
    _description = widget.task.description;
    _priority = widget.task.priority;
    _status = widget.task.status;
    _assignedUserId = widget.task.userId;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUsers();
    });
  }

  Future<void> _fetchUsers() async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    await taskProvider.fetchUsers(context);
    setState(() {
      _users = taskProvider.users;
    });
  }

  void _selectDueDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _dueDate) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  void _updateTask(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider
          .updateTask(
            context,
            id: widget.task.id,
            title: _title,
            description: _description,
            dueDate: _dueDate,
            priority: _priority,
            status: _status,
            assignedUserId: _assignedUserId,
          )
          .then((_) => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    taskProvider.fetchUsers(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: Text('Update Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: _users
                  .isEmpty // Show a loading indicator if users are not loaded
              ? Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                      "Update Task...",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 25.sp,
                      ),
                    ),
                      Text(
                        "Transform your challenges into opportunities.",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 45.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.searchboxcolor,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: TextFormField(
                          initialValue: _title,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(17.sp),
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.4.sp,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            hintText: 'Task Title..',
                            hintStyle: const TextStyle(
                              color: Palette.hinttext,
                            ),
                            prefixIcon: Icon(Icons.title),
                            prefixIconColor: Palette.iconix,
                          ),
                          onSaved: (value) => _title = value!,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter a title' : null,
                        ),
                      ),
                      SizedBox(height: 27.sp),
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.searchboxcolor,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: TextFormField(
                          initialValue: _description,
                          maxLines: null,
                          minLines: 2,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(17.sp),
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.4.sp,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            hintText: 'Description..',
                            hintStyle: const TextStyle(
                              color: Palette.hinttext,
                            ),
                            prefixIcon: const Icon(Icons.description),
                            prefixIconColor: Palette.iconix,
                          ),
                          onSaved: (value) => _description = value!,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter a description'
                              : null,
                        ),
                      ),
                      SizedBox(height: 27.sp),
                      Material(
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Due Date:',
                              style: TextStyle(
                                color: Palette.iconix,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                                width:
                                37.sp), // Similar spacing as in the birthdayTile
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Palette.searchboxcolor,
                                  borderRadius: BorderRadius.circular(12.sp),
                                ),
                                child: GestureDetector(
                                  onTap: () => _selectDueDate(
                                      context), // Trigger date selection
                                  child: Padding(
                                    padding: EdgeInsets.all(12
                                        .sp), // Padding similar to CupertinoDateTextBox
                                    child: Text(
                                      DateFormat.yMd()
                                          .format(_dueDate), // Display selected date
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Palette
                                            .hinttext, // Use hint text color for consistency
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today, color: Palette.iconix),
                              onPressed: () => _selectDueDate(context),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 27.sp),
                      Row(
                        children: <Widget>[
                          Text(
                            'Priority:',
                            style: TextStyle(
                              color: Palette.iconix,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 37.sp), // Maintain consistent spacing
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.searchboxcolor,
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 5.sp), // Padding inside the container
                              child: DropdownButtonFormField<String>(
                                value: _priority,
                                decoration: InputDecoration(
                                  border: InputBorder.none, // Remove the default dropdown border
                                ),
                                dropdownColor: Palette.searchboxcolor, // Match dropdown color with the container
                                items: ['High', 'Medium', 'Low']
                                    .map((priority) => DropdownMenuItem(
                                  child: Text(priority),
                                  value: priority,
                                ))
                                    .toList(),
                                onChanged: (value) => _priority = value!,
                                onSaved: (value) => _priority = value!,
                                validator: (value) =>
                                value == null ? 'Please select a priority' : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 27.sp),
                      Row(
                        children: <Widget>[
                          Text(
                            'Status:',
                            style: TextStyle(
                              color: Palette.iconix,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 37.sp), // Consistent spacing
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.searchboxcolor,
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 5.sp), // Internal padding
                              child: DropdownButtonFormField<String>(
                                value: _status,
                                decoration: InputDecoration(
                                  border: InputBorder.none, // No default border
                                ),
                                dropdownColor: Palette.searchboxcolor, // Match dropdown color
                                items: ['To-Do', 'In Progress', 'Done']
                                    .map((status) => DropdownMenuItem<String>(
                                  child: Text(status),
                                  value: status,
                                ))
                                    .toList(),
                                onChanged: (value) => _status = value!,
                                onSaved: (value) => _status = value!,
                                validator: (value) => value == null ? 'Please select a status' : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 27.sp),
                      Row(
                        children: <Widget>[
                          Text(
                            'Assigned User:',
                            style: TextStyle(
                              color: Palette.iconix,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 37.sp), // Consistent spacing
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.searchboxcolor,
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 5.sp), // Internal padding
                              child: DropdownButtonFormField<int>(
                                value: _assignedUserId,
                                decoration: const InputDecoration(
                                  border: InputBorder.none, // No default border
                                ),
                                dropdownColor: Palette.searchboxcolor, // Match dropdown color
                                items: taskProvider.users.map((user) => DropdownMenuItem<int>(
                                  value: user.id,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(user.avatar),
                                        radius: 15.sp, // Adjust the size as needed
                                      ),
                                      SizedBox(width: 12.sp), // Space between image and text
                                      Text('${user.firstName} ${user.lastName}'),
                                    ],
                                  ),
                                )).toList(),
                                onChanged: (value) => _assignedUserId = value!,
                                onSaved: (value) => _assignedUserId = value!,
                                validator: (value) => value == null ? 'Please select an assigned user' : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 27.sp),
                      // DropdownButtonFormField<String>(
                      //   value: _status,
                      //   decoration: InputDecoration(labelText: 'Status'),
                      //   items: ['To-Do', 'In Progress', 'Done']
                      //       .map((status) => DropdownMenuItem(
                      //             child: Text(status),
                      //             value: status,
                      //           ))
                      //       .toList(),
                      //   onChanged: (value) => setState(() => _status = value!),
                      //   onSaved: (value) => _status = value!,
                      //   validator: (value) =>
                      //       value == null ? 'Please select a status' : null,
                      // ),
                      // DropdownButtonFormField<int>(
                      //   value: _assignedUserId,
                      //   decoration: InputDecoration(labelText: 'Assigned User'),
                      //   items: _users
                      //       .map((user) => DropdownMenuItem<int>(
                      //             child: Text(
                      //                 '${user.firstName} ${user.lastName}'),
                      //             value: user.id,
                      //           ))
                      //       .toList(),
                      //   onChanged: (value) =>
                      //       setState(() => _assignedUserId = value!),
                      //   onSaved: (value) => _assignedUserId = value!,
                      //   validator: (value) => value == null
                      //       ? 'Please select an assigned user'
                      //       : null,
                      // ),
                      // SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => _updateTask(context),
                        child: Container(
                          height: 50.sp,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Palette.iconix,
                                Palette.iconix
                              ], // Example gradient colors
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Update Task",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
