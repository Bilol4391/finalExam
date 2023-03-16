import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_pay/controller/bloc/authController/user_cubit.dart';
import 'package:x_pay/controller/bloc/cubit/cards_cubit_page.dart';
import 'package:x_pay/controller/bloc/fireCards/cards_cubit.dart';
import 'package:x_pay/view/page/onboarding/splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(create:(_) => CardsCubitPage()),
              BlocProvider(create: (_)=>UserCubit()),
              BlocProvider(create: (_)=>CardsCubit()),
            ],

            child: const SplashScreen(),
          ),
        );
      },
    );
  }
}
