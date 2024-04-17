import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/view/screens/chat_screen.dart';
import 'package:chat_app/view/screens/login_screen.dart';
import 'package:chat_app/view/screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360,690),
      builder: (_,context){
        return  MaterialApp(
          routes: {
            LoginScreen.id: (context)=>  LoginScreen(),
            SignUpScreen.id : (context)=>  SignUpScreen(),
            ChatScreen.id : (context)=> ChatScreen()
          },
          theme: ThemeData(
            colorScheme: const ColorScheme.dark()
                .copyWith(primary:kPrimaryColor),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.id,
        );
      },
    );
  }
}
