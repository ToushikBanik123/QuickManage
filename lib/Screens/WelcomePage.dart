import 'package:appscrip_task_management_app/Screens/LoginScreen.dart';
import 'package:appscrip_task_management_app/Screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../conts/color.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Container(
        color: Colors.white,
        padding:  EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.sp,),
            Row(
              children: [
                Text(
                  "Welco",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Palette.iconix,
                    fontSize: 27.sp,
                  ),
                ),
                Text(
                  "me To👋...",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 27.sp,
                  ),
                ),
              ],
            ),
            Text(
              "Quick manage!!",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 30.sp,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400.h,
              child: Lottie.asset(
                'assets/animation/welcome.json',
              ),
            ),
            Spacer(),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 18.sp),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Palette.iconix,
                    borderRadius: BorderRadius.circular(15.r),
                  ),

                  child: Center(
                    child: Text(
                      'Register..',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 18.sp),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Palette.iconix,
                    borderRadius: BorderRadius.circular(15.r),
                  ),

                  child: Center(
                    child: Text(
                      'Login..',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.sp,),
          ],
        ),
      ),
    );
  }
}
