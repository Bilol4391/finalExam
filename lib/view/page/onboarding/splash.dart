import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_pay/controller/bloc/authController/user_cubit.dart';
import 'package:x_pay/controller/localeStore/userId.dart';
import 'package:x_pay/view/components/style/style.dart';
import 'package:x_pay/view/page/auth/sign_in.dart';
import 'package:x_pay/view/page/home/bottom_navigation_bar.dart';

import '../../../controller/bloc/fireCards/cards_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goNavigator();

    super.initState();
  }

  goNavigator() {
    Future.delayed(const Duration(seconds: 3), () async {
      if (await LocaleStore.getId() == null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => UserCubit(),
              child: const AddNumber(),
            )), (route) => false);
      }
      else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                BlocProvider(
                  create: (context) => CardsCubit(),
                  child: const BottomNB(),
                )),
                (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.whiteColor,
        body: Container(
          width: 600.w,
          height: 1000.h,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/spalsh.jpg")
              )
          ),
        )
    );
  }
}