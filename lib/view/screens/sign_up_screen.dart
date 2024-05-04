import 'package:chat_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/view/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_form_text_field_widget.dart';
import '../helper/fail_snack_bar.dart';
import '../widgets/logo_text_widget.dart';
import '../helper/success_snack_bar.dart';


class SignUpScreen extends StatelessWidget {
  static String id = 'SignUpScreen';
  String? email,password;
  bool isLoading = false;
 static GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          successSnackBar(
              context, 'Your account has been successfully created');
          Navigator.pop(context);
          isLoading = false;
        } else if (state is RegisterFailuerState) {
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
                      }, icon: Icons.email,
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
                      }, icon: Icons.lock,
                    ),
                  ),
                  CustomButtonWidget(
                    text: 'Sign Up',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(RegisterEvent(email!, password!));
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
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
