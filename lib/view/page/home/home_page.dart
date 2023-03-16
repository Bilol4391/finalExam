import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:x_pay/controller/bloc/fireCards/card_state.dart';
import 'package:x_pay/controller/bloc/fireCards/cards_cubit.dart';
import 'package:x_pay/view/components/custom/service_page.dart';
import 'package:x_pay/view/components/custom/gredview.dart';
import 'package:x_pay/view/components/style/style.dart';
import 'package:x_pay/view/page/home/nbu_page.dart';
import 'package:x_pay/view/page/settings_page.dart';

import '../card_page/cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController refreshController = RefreshController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {

    context.read<CardsCubit>()
      ..getUserInfo()
      ..getCards();
    super.initState();
  }

  List listOfColor = [
    Style.primaryColor,
    Style.greenColor,
    Style.primaryColor,
    Style.syncColor
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: Drawer(
          key: _key,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: Style.customGeadient(color: Style.primaryColor),
                ),
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage("");
                    // )
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const SettingsPage()));
                },
                child: Row(
                  children: [const Icon(Icons.settings), Text("Sozlamalar",style: Style.primaryText(),)],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Style.greyColor,
        body: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onLoading: () {},
          onRefresh: () {
            refreshController.loadComplete();
          },
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(0),
                    height: 400.h,
                    decoration: BoxDecoration(
                      gradient: Style.customGeadient(color: Style.primaryColor),
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.elliptical(150, 50)),
                      color: Style.primaryColor,
                    ),
                    child: BlocBuilder<CardsCubit, CardsState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _key.currentState?.openDrawer();
                                    },
                                    icon: const Icon(
                                      Icons.menu,
                                      color: Style.whiteColor,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.notifications_rounded,
                                      color: Style.whiteColor,
                                    ))
                              ],
                            ),
                            10.verticalSpace,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.horizontalSpace,
                                Text(
                                  "Umumiy hisob: ${state.listOfCard?.first.money ?? 0}",
                                  style: Style.primaryText(
                                      textColor: Style.whiteColor),
                                ),
                              ],
                            ),
                            20.verticalSpace,
                            CardsPage(
                              name: "${state.listOfCard?.first.name}",
                              date: state.listOfCard?.first.date ?? "",
                              num: state.listOfCard?.first.cardNumber ?? "",
                              color: state.listOfCard?.first.colorIndex ?? 0,
                              lastName: state.listOfCard?.first.lastName ?? "",
                            ),
                          ],
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      20.verticalSpace,
                      const CustomGredview(),
                      20.verticalSpace,
                      const ServicePage(),
                      20.verticalSpace,
                    ],
                  ),
                ),
                const NBUPage(),
                10.verticalSpace,
              ],
            ),
          )),
        ));
  }
}
