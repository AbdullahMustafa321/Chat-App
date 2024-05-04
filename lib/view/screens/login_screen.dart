import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/constant/strings.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/view/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/view/screens/sign_up_screen.dart';
import 'package:chat_app/view/helper/fail_snack_bar.dart';
import 'package:chat_app/view/widgets/logo_text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_form_text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String? email, password;
  bool isLoading = false;

  static GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatScreen.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailuer) {
          failSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: Center(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: ListView(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: Image.asset(
                      kLogo,
                      width: 250.w,
                      height: 250.h,
                    ),
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
                      icon: Icons.email,
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
                      icon: Icons.lock,
                    ),
                  ),
                  CustomButtonWidget(
                      text: 'Sign In',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).loginUser(
                              email: email.toString().trim(),
                              password: password.toString().trim());
                        }
                      }),
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
      },
    );
  }
}
