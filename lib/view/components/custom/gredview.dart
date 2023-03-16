import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_pay/view/components/style/style.dart';

class CustomGredview extends StatelessWidget {
  const CustomGredview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData> listOfIcon=[Icons.cached_sharp,Icons.savings_outlined,Icons.account_balance,Icons.insights];
    List<String> listText=["Keshbek","Jamg'arma","Omonat","Kreditlar"];
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
        itemCount: 4,
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 90.h),
        itemBuilder: (context,index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child:InkWell(
          onTap: (){},
          child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: Style.whiteColor,
      ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 60.h,
                    height: 80.h,
                    decoration: BoxDecoration(
                      gradient: Style.customGeadient(color: Style.primaryColor),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Icon(listOfIcon[index],color: Style.whiteColor,),
                    ),
                  ),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(listText[index],style: Style.primaryText(size: 12,weight: FontWeight.w600),),
                      Text("0",style: Style.primaryText(size: 16,weight: FontWeight.w700),),
                      Text("So'm",style: Style.primaryText(size: 12,weight: FontWeight.w600),)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
