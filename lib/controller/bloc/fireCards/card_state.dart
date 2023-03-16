// class FireCardsState{
//   final String? name;
//   final String? lastName;
//   final String? date;
//   final String? cardNumber;
//   final String? svv;
//   final int colorindex;
//   FireCardsState({ this.name="", this.lastName="", this.date="",this.cardNumber="",this.svv="", this.colorindex=0, });
//
//   factory FireCardsState.fromJson(Map? data) {
//     return FireCardsState(
//       name: data?["name"],
//       lastName: data?["desc"],
//       date: data?["date"],
//       cardNumber: data?["cardNumber"],
//       svv: data?["svv"],
//       colorindex: data?["colorindex"] ?? false,
//
//     );
//   }
//
//   toJson() {
//     return {
//       "name": name,
//       "lastName": lastName,
//       "date": date,
//       "cardNumber": cardNumber,
//       "svv": svv,
//       "colorindex": colorindex,
//     };
//   }
//
//   FireCardsState copyWith({
//   String? name,
//    String? lastName,
//    String? date,
//    String? cardNumber,
//    String? svv,
//    int? colorindex,
// }){
//     return FireCardsState(
//       name: name ?? this.name,
//       lastName: lastName ?? this.lastName,
//       date:date ?? this.date,
//       cardNumber: cardNumber ?? this.cardNumber,
//       svv: svv ?? this.svv,
//       colorindex: colorindex ?? this.colorindex,
//     );
//   }
//
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:x_pay/model/cards_model.dart';
import 'package:x_pay/model/user_model.dart';

class CardsState{
  bool loading=true;
  CardsModel? fireCardsModel;
  List<CardsModel>? listOfCard;
  UserModel? user;
  QueryDocumentSnapshot? data;

  CardsState({this.fireCardsModel,this.listOfCard,this.data,this.user,this.loading=true});


 CardsState copyWith({
  CardsModel? fireCardsModel,
   List<CardsModel>? listOfCard,
   QueryDocumentSnapshot? data,
   UserModel? user,
}){
   return CardsState(
     fireCardsModel: fireCardsModel ?? CardsModel(),
     listOfCard: listOfCard ?? this.listOfCard,
     data: data ?? this.data,
     user: user ?? this.user,
   );
 }

}