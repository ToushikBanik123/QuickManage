import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Provider/UserProvider.dart';

class DrawerHeaderWidget extends StatelessWidget {
  final UserProvider userProvider;

  const DrawerHeaderWidget({required this.userProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Drawer background color
      padding: EdgeInsets.symmetric(vertical: 20.sp),
      child: UserAccountsDrawerHeader(
        accountEmail: Text(userProvider.user?.email ?? 'Not Available'),
        accountName: Text(
            '${userProvider.user?.firstName ?? 'Not Available'} ${userProvider.user?.lastName ?? 'Not Available'}'),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(userProvider.user?.avatar ??
              'https://reqres.in/img/faces/1-image.jpg'),
          radius: 30.sp,
        ),
      ),
    );
  }
}
