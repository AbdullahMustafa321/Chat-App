import 'package:chat_app/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomFormTextFieldWidget extends StatelessWidget {
   CustomFormTextFieldWidget({
    super.key,   this.isPassword=false, required this.hintText, required this.label,this.onChange, required this.icon
  });
   bool? isPassword;
  final String hintText;
  final String label;
  Function(String)? onChange;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
      child: TextFormField(
        validator: (data){
          if(data!.isEmpty){
            return 'Please enter your $label';
          }
        },
       onChanged: onChange,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        obscureText: isPassword!,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon),
          filled: true,
          label: Text(label),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: kPrimaryColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: kPrimaryColor)),
        ),
      ),
    );
  }
}
