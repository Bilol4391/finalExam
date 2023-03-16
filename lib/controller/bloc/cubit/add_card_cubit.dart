import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/add_card_state.dart';

class AddCardCubit extends Cubit<AddCardsState>{
  AddCardCubit (): super(AddCardsState());

  movName(String name){
    emit(state.copyWith(name: name));
  }
  movLastName(String lastName){
    emit(state.copyWith(lastName:lastName ));
  }
  movCardNum(String numCard){
    emit(state.copyWith(cardNum: numCard));
  }
  movDate(String time){
    emit(state.copyWith(date: time));
  }
  movSvv(String svv){
    emit(state.copyWith(svv: svv));
  }
  movColor(int index){
    emit(state.copyWith(colorindex: index));
  }


}