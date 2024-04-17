import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/view/widgets/custom_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_form_text_field_widget.dart';
import '../helper/fail_snack_bar.dart';
import '../widgets/logo_text_widget.dart';
import '../helper/success_snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  static String id = 'SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? password;
  bool isLoading =  false;
  GlobalKey<FormState> formKey =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:isLoading ,
      child: Scaffold(
        body: Center(
          child: Form(
            key: formKey,
            child: ListView(children: [
              SizedBox(
                height: 200.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 20.h),
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
                text: 'Sign Up',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await registerUser();
                      successSnackBar(context,'Your account has been successfully created');
                      Navigator.pop(context);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        failSnackBar(context,'The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        failSnackBar(context, 'The account already exists for that email.');
                      }
                    } catch (ex) {
                      failSnackBar(context, 'The account already exists for that email.');
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
                  const Text('Already have an account '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email!, password: password!);
  }
}
