class AddCardsState{
 final String name;
 final String date;
 final String cardNum;
 final String lastName;
 final String svv;
 final int colorindex;
 AddCardsState({ this.colorindex=0, this.svv="", this.lastName="", this.name="",this.date="",this.cardNum=""});

 AddCardsState copyWith({
  String? name,
  String? lastName,
  String? date,
  String? cardNum,
  String? svv,
   int? colorindex,
}){
  return AddCardsState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      date: date ?? this.date,
      cardNum: cardNum ?? this.cardNum,
      svv: svv ?? this.svv,
    colorindex: colorindex ?? this.colorindex,
  );
 }
}