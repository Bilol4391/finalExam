import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_pay/view/components/style/style.dart';

class CustomTextFomFieldIcon extends StatelessWidget {
  final int width;
  final int hight;
  final IconData icon;
  final String? hint;
  final TextInputType keyboard;
  final TextEditingController? controller;
  final ValueChanged<String> onChenged;

  const CustomTextFomFieldIcon({Key? key,  this.hint, this.controller,required this.onChenged,  this.width=130,  this.hight=40, this.keyboard=TextInputType.text, required this.icon, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: width.w,
      height: hight.h,
      child: TextFormField(
        controller: controller,
        onChanged: onChenged,
        keyboardType: keyboard,
        decoration: InputDecoration(
            filled: true,
            fillColor: Style.whiteColor,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: Style.primaryColor)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: Style.primaryColor)),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: Style.primaryColor)),
            prefixIcon:  Icon(
              icon,
              color: Style.primaryColor,
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Style.primaryColor, fontSize: 12)),
      ),
    );
  }
}
