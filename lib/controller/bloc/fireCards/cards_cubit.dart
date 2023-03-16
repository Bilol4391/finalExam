import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_pay/controller/localeStore/userId.dart';
import 'package:x_pay/model/cards_model.dart';
import '../../../model/user_model.dart';
import 'card_state.dart';
import 'package:http/http.dart' as http;

class CardsCubit extends Cubit<CardsState> {
  CardsCubit() : super(CardsState());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = true;

  getUserInfo() async {
    var id = await LocaleStore.getId();
    var res = await firestore.collection("users").doc(id).get();
    emit(state.copyWith(
        user: UserModel.fromJson(data: res.data(), docId: res.id)));
  }

  updateMoney(String price) async {
    sendMessage(price: price);
    price = price.replaceAll("\$", "");
    price = price.replaceAll(",", "");
    state.listOfCard?[0].money =
        ((state.listOfCard?[0].money ?? 0) - int.parse(price));

    await firestore
        .collection("cards")
        .doc(state.listOfCard?.first.docId)
        .update(state.listOfCard?.first.toJson());
    emit(state.copyWith(listOfCard: state.listOfCard));
  }

  sendMessage({required String price}) async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
    );
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    var res = await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: {
        "Content-Type": "application/json",
        'Authorization':
            'key=AAAAId9f2uY:APA91bHTIXdz8_SPg4wPf7dnMY729ebiFqdr8EHk9Dzfpnv7F7VAsV5yjU1ScGi9CwZGJFk-K8fflwRob-YGwxiFf8X0JKLUYaNxNlSRPTHBLS_owGQ5kbENNEeN1oAP_A3vXNI_5qhF'
      },
      body: jsonEncode(
        {
          "to": fcmToken,
          "data": {
            "body": "Muvofaqiyatli amalga oshirildi",
            "title": "${state.user?.name}"
          }
        },
      ),
    );
    debugPrint("${res.statusCode}");
  }

  getCards() async {
    var res = await firestore
        .collection("cards")
        .where("userId", isEqualTo: await LocaleStore.getId())
        .get();
    List<CardsModel> cards = [];
    for (var element in res.docs) {
      cards.add(CardsModel.fromJson(data: element.data(), docId: element.id));
    }
    emit(state.copyWith(listOfCard: cards));
  }

  setCard(String name, String lastName, String date, String cardNum,
      String userId, int colorIndex) async {
    firestore.collection("cards").add(CardsModel(
          money: 500,
          name: name,
          date: date,
          lastName: lastName,
          cardNumber: cardNum,
          colorIndex: colorIndex,
          userId: await LocaleStore.getId(),
        ).toJson());
  }
}
