class CardsStatePage{
  final int index;
  CardsStatePage({this.index=0});

  CardsStatePage copyWith({
    int? index,
  }){
    return CardsStatePage(
        index: index ?? this.index
    );
  }
}