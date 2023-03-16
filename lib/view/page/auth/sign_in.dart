import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_pay/controller/bloc/authController/user_state.dart';
import 'package:x_pay/controller/bloc/authController/user_cubit.dart';
import 'package:x_pay/controller/bloc/fireCards/cards_cubit.dart';
import 'package:x_pay/view/components/custom/custom_button.dart';
import 'package:x_pay/view/components/custom/custom_text_form_fild_icon.dart';
import 'package:x_pay/view/components/style/style.dart';
import 'package:x_pay/view/page/auth/verify_page.dart';
import 'package:x_pay/view/page/home/home_page.dart';

class AddNumber extends StatefulWidget {
  const AddNumber({Key? key}) : super(key: key);

  @override
  State<AddNumber> createState() => _AddNumberState();
}

class _AddNumberState extends State<AddNumber> {
  GlobalKey error = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: Scaffold(
        body: Form(
          key: error,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  100.verticalSpace,
                  Text(
                    "Ro'yxatdan O'tish",
                    style: Style.primaryText(
                        textColor: Style.primaryColor,
                        size: 26,
                        weight: FontWeight.w700),
                  ),
                  20.verticalSpace,
                  CustomTextFomFieldIcon(
                    hint: "Ism Familya",
                    controller: nameController,
                    onChenged: (s) {},
                    icon: Icons.person,
                  ),
                  20.verticalSpace,
                  CustomTextFomFieldIcon(
                    onChenged: (s) {},
                    icon: Icons.phone,
                    controller: phoneController,
                    hint: "Telefon Raqam",
                    keyboard: TextInputType.phone,
                  ),
                  20.verticalSpace,
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return CustomTextFomFieldIcon(
                          onChenged: (s) {},
                          icon: Icons.lock,
                          controller: passwordController,
                          hint: "Parol");
                    },
                  ),
                  180.verticalSpace,
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return CustomButton(
                        onTap: () async {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: phoneController.text,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {
                              debugPrint(credential.toString());
                            },
                            verificationFailed: (FirebaseAuthException e) {
                              debugPrint(e.toString());
                            },
                            codeSent:
                                (String verificationId, int? resendToken) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => VerfyPage(
                                            id: verificationId,
                                          )));
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );

                          // context.read<UserCubit>().signIn(nameController.text, phoneController.text, passwordController.text);
                        },
                        text: "Keyingi",
                      );
                    },
                  ),
                  40.verticalSpace,
                  Text(
                    "Quydagilar bilan ro'yxatdan o'tish",
                    style: Style.primaryText(
                        size: 20, textColor: Style.primaryColor),
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        onTap: () {
                          context.read<UserCubit>().loginGoogle(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                          create: (context) => CardsCubit(),
                                          child:  const HomePage(),
                                        )));
                          });
                        },
                        text: "Google",
                        width: 150,
                      ),
                      CustomButton(
                        onTap: () {
                          context.read<UserCubit>().loginFacebook(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                          create: (context) => CardsCubit(),
                                          child: const HomePage(),
                                        )));
                          });
                        },
                        text: "Facebook",
                        width: 150,
                      ),
                      30.verticalSpace,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
