import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_pay/view/components/style/style.dart';

class CustomTextFomField extends StatelessWidget {
  final int width;
  final int hight;
  final String? hint;
  final TextInputType keyboard;
  final TextEditingController? controller;
  final ValueChanged<String> onChenged;
  final FormFieldValidator<String> valid;
  final Color filled;
  final Color hintColor;
  final bool obscure;

  const CustomTextFomField({Key? key,  this.hint, this.controller,required this.onChenged,
    this.width=130,  this.hight=50, this.keyboard=TextInputType.text,
    required this.valid,  this.filled=Style.whiteColor,  this.hintColor=Style.primaryColor,
     this.obscure=false, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: hight.h,
      child: TextFormField(
        obscureText:obscure ,
        controller: controller,
        onChanged: onChenged,
        keyboardType: keyboard,
        validator: valid,
        decoration: InputDecoration(
            filled: true,

            fillColor: filled,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Style.primaryColor)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Style.primaryColor)),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Style.primaryColor)),
            // prefixIcon: const Icon(
            //   Icons.search,
            //   color: Style.primaryColor,
            // ),
            hintText: hint,
            hintStyle:  TextStyle(color: hintColor, fontSize: 12)),
      ),
    );
  }
}
