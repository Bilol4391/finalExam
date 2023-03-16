import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_pay/controller/bloc/fireCards/card_state.dart';
import 'package:x_pay/controller/bloc/fireCards/cards_cubit.dart';
import 'package:x_pay/view/components/style/style.dart';

import '../page/card_page/cards.dart';

class MainContainer extends StatelessWidget {
  final Widget onKey;

  const MainContainer({Key? key, required this.onKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(0),
        height: 400.h,
        decoration: BoxDecoration(
          gradient: Style.customGeadient(color: Style.primaryColor),
          borderRadius: const BorderRadius.vertical(
              bottom: Radius.elliptical(150, 50)),
          color: Style.primaryColor,
        ),
        child: Column(
          children: [
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {
                  Widget;
                }, icon: const Icon(Icons.menu, color: Style.whiteColor,)),
                IconButton(onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_rounded, color: Style.whiteColor,))
              ],
            ),
            10.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.horizontalSpace,
                Text("Umumiy hisob: ",
                  style: Style.primaryText(textColor: Style.whiteColor),),
              ],
            ),
            20.verticalSpace,
            BlocBuilder<CardsCubit, CardsState>(
              builder: (context, state) {
                return CardsPage(name: state.listOfCard?.first.name ?? "",
                    date: state.listOfCard?.first.date ?? "",
                    num: state.listOfCard?.first.cardNumber ?? "",
                    color: state.listOfCard?.first.colorIndex ?? 0,
                    lastName: state.listOfCard?.first.lastName ?? "");
              },
            ),
          ],
        )
    );
  }
}
