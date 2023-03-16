import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/style.dart';

class CustomButtonIcon extends StatelessWidget {
  final IconData icon;
  final int iconSize;
  final LinearGradient gradient;
  final int hight;
  final int width;
  final Color color;
  final String text;
  final Color textColor;
  final Color iconColor;
  final double textSize;
  final VoidCallback onTap;
  const CustomButtonIcon({Key? key, this.hight=35,
    this.color=Style.primaryColor, required this.onTap,
    required this.text, this.textSize=16,  this.textColor=Style.whiteColor,
    required this.icon, this.iconColor=Style.whiteColor,  this.width=100,  this.iconSize=20, this.gradient=Style.linearGradient,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        width:width.w ,
        height: hight.h,
        decoration: BoxDecoration(
          gradient:gradient ,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: color,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon,color: iconColor,),
              Text(text,style:Style.primaryText(textColor: textColor,size: textSize)), //TextStyle(fontSize:textSize,color: textColor ),),
            ],
          ),
        ),
      ),
    );
  }
}