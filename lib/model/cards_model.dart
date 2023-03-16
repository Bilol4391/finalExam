
class CardsModel {
  final String? name;
  final String? lastName;
  final String? date;
  final String? cardNumber;
  final String? svv;
  final int colorIndex;
  final String? userId;
  String? docId;
  num money;

  CardsModel(
      {this.money = 500,
      this.name = "",
      this.lastName = "",
      this.date = "",
      this.cardNumber = "",
      this.svv = "",
      this.colorIndex = 0,
      this.userId = "",
      this.docId});

  factory CardsModel.fromJson({Map? data,required String docId}) {
    return CardsModel(
      name: data?["name"],
      lastName: data?["desc"],
      date: data?["date"],
      cardNumber: data?["cardNumber"],
      svv: data?["svv"],
      colorIndex: data?["colorindex"],
      userId: data?["userId"],
      money: data?["money"],
      docId: docId
    );
  }

  toJson() {
    return {
      "name": name,
      "lastName": lastName,
      "date": date,
      "cardNumber": cardNumber,
      "svv": svv,
      "colorindex": colorIndex,
      "userId": userId,
      "money": money,
    };
  }

  CardsModel copyWith({
    String? name,
    String? lastName,
    String? date,
    String? cardNumber,
    String? svv,
    int? colorIndex,
    String? cardId,
  }) {
    return CardsModel(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      date: date ?? this.date,
      cardNumber: cardNumber ?? this.cardNumber,
      svv: svv ?? this.svv,
      colorIndex: colorIndex ?? this.colorIndex,
      userId: cardId ?? userId,
    );
  }
}
