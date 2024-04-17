import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/constant/strings.dart';
import 'package:chat_app/view/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/view/screens/sign_up_screen.dart';
import 'package:chat_app/view/helper/fail_snack_bar.dart';
import 'package:chat_app/view/widgets/logo_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_form_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
static String id = 'LoginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? email,password;
  bool isLoading=false;
  GlobalKey<FormState>formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Center(
          child: Form(
            key: formKey,
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: Image.asset(kLogo,width: 250.w,height: 250.h,),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: const LogoTextWidget(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CustomFormTextFieldWidget(
                  label: 'Email',
                  hintText: 'Enter Your Email',
                  onChange: (data) {
                    email = data;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CustomFormTextFieldWidget(
                  isPassword: true,
                  label: 'Password',
                  hintText: 'Enter Your Password',
                  onChange: (data) {
                    password = data;
                  },
                ),
              ),
              CustomButtonWidget(
                text: 'Sign In',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await loginUser();
                      Navigator.pushNamed(context, ChatScreen.id, arguments: email);
                    } on FirebaseAuthException catch (ex) {
                      if (ex.code == 'invalid-credential') {
                        failSnackBar(context, 'Invalid email or password!');
                      }
                    }
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email!, password: password!);
  }
}
