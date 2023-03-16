import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_pay/controller/bloc/fireCards/card_state.dart';
import 'package:x_pay/controller/bloc/fireCards/cards_cubit.dart';
import 'package:x_pay/view/components/custom/custom_button.dart';
import 'package:x_pay/view/components/custom/custom_button_icon.dart';
import 'package:x_pay/view/components/custom/custom_text_form_field.dart';
import 'package:x_pay/view/components/style/style.dart';
import 'package:x_pay/view/page/transaction/qrcode.dart';

import 'contact.dart';

class TransactionPage extends StatefulWidget {

  const TransactionPage({Key? key,}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TextEditingController num1=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<CardsCubit, CardsState>(
  builder: (context, state) {
    return Column(
              children: [
                20.verticalSpace,
                CustomTextFomField(onChenged: (s){},
                  width: 320,
                  valid: (s){
                  if(s?.isEmpty ?? true ){
                    return "Raqamni kiriting";
                  }
                  else{
                    return null;
                  }
                  },
                  hint: "Karta yoki telefon raqam",
                  controller: num1,
                  keyboard: TextInputType.number,
                ),
                20.verticalSpace,
                CustomButton(
                  width: 320,
                    hight: 50,
                    gradient: Style.customGeadient(color: Style.primaryColo),
                    onTap: (){
                    context.read<CardsCubit>().updateMoney(num1.text);
                    }, text: "Jo'natish"),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonIcon(
                      gradient: Style.customGeadient(color: Style.primaryColor),
                        hight: 80,
                        width: 150,
                        iconSize: 50,
                        textSize: 20,

                        onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const FlutterContactsExample()));
                    }, text: "Kontaktlar", icon:Icons.person),
                    CustomButtonIcon(
                        gradient: Style.customGeadient(color: Style.primaryColor),
                        hight: 80,
                        width: 150,
                        iconSize: 50,
                        textSize: 20,
                        onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const QRViewExample()));
                    }, text: "QR kod", icon:Icons.qr_code)
                  ],
                ),

              ],
            );
  },
),
          ),
        ),
      ),
    );
  }
}
