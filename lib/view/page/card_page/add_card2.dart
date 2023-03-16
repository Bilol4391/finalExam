import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:x_pay/controller/bloc/fireCards/cards_cubit.dart';
import 'package:x_pay/controller/func.dart';
import 'package:x_pay/controller/localeStore/userId.dart';
import 'package:x_pay/model/cards_model.dart';
import 'package:x_pay/view/components/custom/custom_button.dart';
import 'package:x_pay/view/components/custom/custom_text_form_field.dart';
import 'package:x_pay/view/components/style/style.dart';
import 'package:x_pay/view/page/home/home_page.dart';
import '../../../controller/bloc/cubit/add_card_cubit.dart';
import '../../../controller/bloc/state/add_card_state.dart';

class AddCard2 extends StatefulWidget {
  const AddCard2({Key? key}) : super(key: key);

  @override
  State<AddCard2> createState() => _AddCard2State();
}

class _AddCard2State extends State<AddCard2> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> vKey = GlobalKey<FormState>();
  var lastName = TextEditingController();
  final dateController = MaskedTextController(mask: '00/00');
  final numController = MaskedTextController(mask: '0000 0000 0000 0000');
  final svvController = MaskedTextController(mask: "000");
  List listOfColor = [
    Style.primaryColor,
    Style.greenColor,
    Style.primaryColor,
    Style.syncColor
  ];
  int selectColor = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: BlocProvider(
        create: (context) => AddCardCubit(),
        child: Scaffold(
          body: Form(
            key: vKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<AddCardCubit, AddCardsState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          10.verticalSpace,
                          Container(
                            // width: 400.w,
                            height: 200.h,
                            decoration: BoxDecoration(
                                gradient: Style.customGeadient(
                                    color: listOfColor[state.colorindex]),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24))),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          image: AssetImage("assets/card1.png"),
                                          fit: BoxFit.cover,
                                        )),
                                      ),
                                      10.horizontalSpace,
                                      Text(
                                        state.cardNum,
                                        style: Style.primaryText(
                                            textColor: Style.whiteColor,
                                            size: 20),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Func.isAlpha(name.text) == true
                                          ? Text(
                                              "Xato",
                                              style: Style.primaryText(
                                                  size: 16,
                                                  textColor: Style.redColor),
                                            )
                                          : Text(
                                              state.name.toUpperCase(),
                                              style: Style.primaryText(
                                                  textColor: Style.whiteColor,
                                                  size: 14,
                                                  weight: FontWeight.w400),
                                              maxLines: 1,
                                            ),
                                      7.horizontalSpace,
                                      if (Func.isAlpha(lastName.text) == true) Text(
                                              "Xato",
                                              style: Style.primaryText(
                                                  size: 16,
                                                  textColor: Style.redColor),
                                            ) else Text(
                                              state.lastName.toUpperCase(),
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
                                          child: Text(state.date,
                                              style: Style.primaryText(
                                                  size: 12,
                                                  textColor:
                                                      Style.whiteColor))),
                                      //:
                                      // Text("Xato",style:Style.primaryText(size: 16,textColor: Style.redColor),),
                                      30.horizontalSpace,
                                      SizedBox(
                                          child: Text(
                                        state.svv,
                                        style: Style.primaryText(
                                            textColor: Style.whiteColor,
                                            size: 12),
                                      )),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(Func.cardNum(numController.text).toString()),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          5.verticalSpace,
                          SizedBox(
                            width: 170.w,
                            height: 40.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: listOfColor.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: InkWell(
                                      onTap: () {
                                        context
                                            .read<AddCardCubit>()
                                            .movColor(index);
                                        selectColor = listOfColor[index];
                                      },
                                      child: Container(
                                        width: 40.w,
                                        height: 40.w,
                                        decoration: BoxDecoration(
                                          color: listOfColor[index],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          10.verticalSpace,
                          CustomTextFomField(
                            valid: (s) {
                              if (s?.isEmpty ?? true && s?.length == 16) {
                                return "Karta raqam kiritish majburiy";
                              } else {
                                return null;
                              }
                            },
                            hint: "Karta raqami",
                            keyboard: TextInputType.number,
                            width: 300,
                            controller: numController,
                            onChenged: (s) {
                              context
                                  .read<AddCardCubit>()
                                  .movCardNum(numController.text);
                            },
                          ),
                          10.verticalSpace,
                          CustomTextFomField(
                            hint: "Ism",
                            width: 300,
                            controller: name,
                            valid: (s) {
                              if (s?.isEmpty ?? true) {
                                return "Ismni kiritish majburiy";
                              } else {
                                return null;
                              }
                            },
                            onChenged: (s) {
                              context.read<AddCardCubit>().movName(name.text);
                            },
                          ),
                          10.verticalSpace,
                          CustomTextFomField(
                            valid: (s) {
                              if (s?.isEmpty ?? true) {
                                return "Familya kiritish majburiy";
                              } else {
                                return null;
                              }
                            },
                            hint: "Familya",
                            width: 300,
                            controller: lastName,
                            onChenged: (s) {
                              context
                                  .read<AddCardCubit>()
                                  .movLastName(lastName.text);
                            },
                          ),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextFomField(
                                hint: "Muddat",
                                width: 145,
                                keyboard: TextInputType.number,
                                controller: dateController,
                                valid: CardUtils.validateDate,
                                onChenged: (s) {
                                  context
                                      .read<AddCardCubit>()
                                      .movDate(dateController.text);
                                },
                              ),
                              10.horizontalSpace,
                              CustomTextFomField(
                                  obscure: true,
                                  hint: "SVV",
                                  controller: svvController,
                                  keyboard: TextInputType.number,
                                  valid: (s) {
                                    if (s?.isEmpty ?? true) {
                                      return "Muddatni to'g'ri kiriting";
                                    } else {
                                      return null;
                                    }
                                  },
                                  width: 145,
                                  onChenged: (s) {
                                    context
                                        .read<AddCardCubit>()
                                        .movSvv(svvController.text);
                                  })
                            ],
                          ),
                          100.verticalSpace,
                          CustomButton(
                              width: 300,
                              hight: 50,
                              gradient: Style.customGeadient(
                                  color: Style.primaryColor),
                              onTap: () async {
                                if (vKey.currentState?.validate() ?? false) {
                                  firestore
                                      .collection("cards")
                                      .add(CardsModel(
                                        name: name.text,
                                        lastName: lastName.text,
                                        date: dateController.text,
                                        cardNumber: numController.text,
                                        svv: svvController.text,
                                        colorIndex: selectColor,
                                    userId: await LocaleStore.getId()
                                      ).toJson())
                                      .then(
                                        (value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => BlocProvider(
                                                    create: (context) => CardsCubit(),
                                                    child: const HomePage(),
                                                  )),),
                                      );
                                }
                              },
                              text: "Qo'shish")
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
