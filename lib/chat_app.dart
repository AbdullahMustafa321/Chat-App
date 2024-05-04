import 'package:chat_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/view/screens/chat_screen.dart';
import 'package:chat_app/view/screens/login_screen.dart';
import 'package:chat_app/view/screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360, 690),
      builder: (_, context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=>AuthBloc()),
            BlocProvider(create: (context)=>ChatCubit())
          ],
          child: MaterialApp(
            routes: {
              LoginScreen.id: (context) => LoginScreen(),
              SignUpScreen.id: (context) => SignUpScreen(),
              ChatScreen.id: (context) => ChatScreen()
            },
            theme: ThemeData(
              colorScheme: const ColorScheme.dark()
                  .copyWith(primary: kPrimaryColor),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: LoginScreen.id,
          ),
        );
      },
    );
  }
}
