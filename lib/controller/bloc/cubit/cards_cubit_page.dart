
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/cards_state_page.dart';

class CardsCubitPage extends Cubit<CardsStatePage>{
  CardsCubitPage(): super(CardsStatePage());

  selectindex(int? index){
    emit(state.copyWith(index: index));
  }

}