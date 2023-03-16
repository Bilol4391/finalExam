
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/style.dart';

class CustomButton extends StatelessWidget {

  final int width;
  final int hight;
  final Color color;
  final Color borderColor;
  final String text;
  final Color textColor;
  final double textSize;
  final LinearGradient gradient;
  final VoidCallback onTap;
  const CustomButton({Key? key, this.width=100,this.hight=40,
    this.color=Style.primaryColor, required this.onTap, required this.text,
    this.textSize=16,  this.textColor=Style.whiteColor, this.borderColor=Style.primaryColor,
     this.gradient=Style.linearGradient,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        width:width.w ,
        height: hight.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          //border: Border.all(color:borderColor ),
          gradient: Style.linearGradient,
          color: color,
        ),
        child: Center(
          child:
          Text(text,style: TextStyle(fontSize:textSize,color: textColor ),),
        ),
      ),
    );
  }
}
