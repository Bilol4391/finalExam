import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_pay/controller/bloc/authController/user_cubit.dart';
import 'package:x_pay/controller/bloc/state/cards_state_page.dart';
import 'package:x_pay/view/components/style/style.dart';
import '../../../controller/bloc/cubit/cards_cubit_page.dart';

// ignore: must_be_immutable
class CardsPage extends StatelessWidget {
  final String name;
  final String date;
   final String num;
  final int color;
  final String lastName;

  CardsPage({Key? key, required this.name, required this.date, required this.num, required this.color, required this.lastName,}) : super(key: key);


  int? _selindex = 0;
  List listOfColor = [
    Style.primaryColor,
    Style.greenColor,
    Style.primaryColor,
    Style.syncColor
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CardsCubitPage()),
        BlocProvider(create: (_) => UserCubit()),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<CardsCubitPage, CardsStatePage>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  height: 200.h,
                  child: PageView.builder(
                      onPageChanged: (s) {
                        context.read<CardsCubitPage>().selectindex(s);
                        _selindex = s;
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: Style.whiteColor,
                            gradient:
                                Style.customGeadient(color: Style.primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                // width: 400.w,
                                height: 200.h,
                                decoration: BoxDecoration(
                                    gradient: Style.customGeadient(
                                        color: Style.primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24))),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 50.w,
                                            height: 40.h,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/card1.png"),
                                                    fit: BoxFit.cover)),
                                          ),
                                          10.horizontalSpace,
                                          Text(
                                            num.replaceRange(5, 14, "**** ****"),
                                            style: Style.primaryText(
                                                textColor: Style.whiteColor,
                                                size: 20),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            name.toUpperCase(),
                                            style: Style.primaryText(
                                                textColor: Style.whiteColor,
                                                size: 14,
                                                weight: FontWeight.w400),
                                            maxLines: 1,
                                          ),
                                          7.horizontalSpace,
                                          Text(
                                            lastName.toUpperCase(),
                                            style: Style.primaryText(
                                                textColor: Style.whiteColor,
                                                size: 14,
                                                weight: FontWeight.w400),
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // Func.date(dateController.text.substring(0,2)) ?
                                          SizedBox(
                                              child: Text(date,
                                                  style: Style.primaryText(
                                                      size: 12,
                                                      textColor:
                                                          Style.whiteColor))),
                                          //:
                                          // Text("Xato",style:Style.primaryText(size: 16,textColor: Style.redColor),),
                                          30.horizontalSpace,
                                          SizedBox(
                                              child: Text("...",
                                            style: Style.primaryText(
                                                textColor: Style.whiteColor,
                                                size: 25),
                                          )),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                      width: 110.w,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              width: index == _selindex ? 20.w : 10.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                  color: index == _selindex
                                      ? Style.primaryColor
                                      : Style.greyColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100))),
                            );
                          }),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
