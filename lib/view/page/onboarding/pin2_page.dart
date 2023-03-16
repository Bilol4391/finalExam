import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code_widget/flutter_pin_code_widget.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:x_pay/controller/bloc/fireCards/cards_cubit.dart';
import 'package:x_pay/controller/localeStore/userId.dart';
import 'package:x_pay/view/components/style/style.dart';
import 'package:x_pay/view/page/home/home_page.dart';

class TwoPinCodePage extends StatefulWidget {
  const TwoPinCodePage({Key? key}) : super(key: key);

  @override
  State<TwoPinCodePage> createState() => _TwoPinCodePageState();
}

class _TwoPinCodePageState extends State<TwoPinCodePage> {
  @override
  // bool _canVibrate = true;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'PIN kodni kiriting',
              style: Style.primaryText(textColor: Style.primaryColor),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 60),
            Expanded(
              child: PinCodeWidget(
                buttonColor: Style.whiteColor,
                borderSide: const BorderSide(color: Style.primaryColor),
                numbersStyle: const TextStyle(
                    color: Style.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
                filledIndicatorColor: Style.primaryColor,
                deleteIconColor: Style.primaryColor,
                deleteButtonColor: Style.whiteColor,
                onPressColorAnimation: Style.primaryColor,
                emptyIndicatorColor: Style.greyColor,
                onFullPin: (_, __) {
                  _ == LocaleStore.getPin()
                      ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (context) => CardsCubit(),
                            child: const HomePage(),
                          )))
                      : Vibrate.feedback(FeedbackType.warning);
                },
                initialPinLength: 4,
                onChangedPin: (_) {
                  Vibrate.feedback(FeedbackType.selection);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
