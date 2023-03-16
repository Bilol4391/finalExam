import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart' show BoxLooseDecoration, Cursor, FixedColorBuilder, PinFieldAutoFill;
import 'package:x_pay/controller/bloc/fireCards/cards_cubit.dart';
import 'package:x_pay/view/components/custom/custom_button.dart';
import 'package:x_pay/view/page/home/bottom_navigation_bar.dart';



class VerfyPage extends StatefulWidget {
  final String id;

  const VerfyPage({Key? key, required this.id}) : super(key: key);

  @override
  State<VerfyPage> createState() => _VerfyPageState();
}

class _VerfyPageState extends State<VerfyPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          100.verticalSpace,
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: PinFieldAutoFill(
                controller: controller,
                cursor: Cursor(color: Colors.black, enabled: true, width: 2),
                decoration: BoxLooseDecoration(
                  gapSpace: 10,
                  bgColorBuilder: const FixedColorBuilder(
                    Colors.white,
                  ),
                  strokeColorBuilder: const FixedColorBuilder(
                    Colors.black,
                  ),
                ),
                onCodeSubmitted: (s) {},
                onCodeChanged: (s) {},
                currentCode: "",
              ),
            ),
          ),
          CustomButton(
              onTap: () async {
                try {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      BlocProvider(
                        create: (context) => CardsCubit(),
                        child: const BottomNB(),
                      )));
                } catch (e) {
                  debugPrint("$e");
                }
                // Create a PhoneAuthCredential with the code

              },
              text:  "Tasdiqlash"
          ),
        ],
      ),
    );
  }
}