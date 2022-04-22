import 'package:bloc/bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterEvent>((event, emit) {
      if (event is IncreaseCounter) {
        emit(state + 1);
        //throught a state increasing ther counter by 1
      }
    });
  }
}

class CounterEvent {}

class IncreaseCounter extends CounterEvent {}
