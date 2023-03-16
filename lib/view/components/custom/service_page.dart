import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_pay/view/components/style/style.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<IconData> listOfIcon=[Icons.public,Icons.phone_android,Icons.car_repair_outlined,Icons.home_outlined,Icons.tv,Icons.diversity_2_outlined];
    List<String> listOfTxt=["Internet","Mobil operator","Transport","komunal","Telvedinya","Xayriya",];
    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 130.w,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius:const  BorderRadius.all(Radius.circular(20)),
              gradient: Style.customGeadient(color: Style.primaryColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(listOfIcon[index],color: Style.whiteColor,size: 60,),
                Text(listOfTxt[index],style: Style.primaryText(size: 16,weight: FontWeight.w700,textColor: Style.whiteColor),)
              ],
            ),
          ),
        );
      }),
    );
  }
}
