import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:appscrip_task_management_app/Provider/AuthProvider.dart';
import '../conts/color.dart';
import 'LoginScreen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Palette.loginbackground,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.sp, vertical: 15.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Register Yourself...",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 25.sp,
                          ),
                        ),
                        Text(
                          "Organize your to-do list by workflow",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(
                          height: 30.sp,
                        ),
                        Center(
                          child: Lottie.asset(
                            'assets/animation/donate.json',
                            height: 310.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      SizedBox(
                        height: 20.sp,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28.sp),
                              topRight: Radius.circular(28.sp),
                            )),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.sp,
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20.sp,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200)),
                                      ),
                                      child: TextFormField(
                                        controller:
                                        provider.emailRegisterScreenController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 0.4.sp,
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(12.sp),
                                          ),
                                          hintText: 'Enter Username/Email',
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 14.sp),
                                          prefixIcon: Icon(
                                              Icons.perm_identity_outlined),
                                          prefixIconColor: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10.sp),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                  Colors.grey.shade200))),
                                      child: TextFormField(
                                        controller: provider
                                            .passwordRegisterScreenController,
                                        obscureText: provider.obscureTextlogin,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0.4.sp,
                                                color: Colors.black,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.sp),
                                            ),
                                            hintText: 'Enter Password',
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 14.sp),
                                            prefixIcon:
                                            Icon(Icons.lock_outline),
                                            prefixIconColor: Colors.grey,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                  provider.obscureTextlogin
                                                      ? Icons.visibility_off
                                                      : Icons.visibility),
                                              onPressed: () {
                                                provider.setObscureTextlogin(
                                                    !provider.obscureTextlogin);
                                              },
                                            ),
                                            suffixIconColor: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                      );
                                    },
                                    child: Text(
                                      "Have an account? Sign in",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  provider.submitRegisterInfo(context);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Palette.iconix,
                                        Palette.iconix
                                      ], // Example gradient colors
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Register..",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}





