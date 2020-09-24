import 'package:CounterApp/bloc/counter_event.dart';
import 'package:CounterApp/bloc/counter_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvents, CounterStates>
{  
  CounterBloc(CounterStates initialState) : super(initialState);

  int count = 0;
  String message = 'Your Initial Counter Value';
  static CounterBloc get(BuildContext context) => BlocProvider.of(context);

  @override
  Stream<CounterStates> mapEventToState(CounterEvents event) async*{
    
    if(event is IncrementEvent)
    {
      yield* _increaseValue();
    }
    else if(event is DecrementEvent)
    {
      yield* _decreaseValue();
    }
  }

  Stream<CounterStates> _increaseValue() async*
  {
      count++;
      message = 'Counter Increased Successfully!';
      yield SuccessCounterState();
  }
  
  Stream<CounterStates> _decreaseValue() async*
  {
    if(count == 0)
      {
        message = 'Can\'t Decrease The Counter When it\'s Value Equal to Zero';
        yield ErrorCounterState();
      }
      else
      {
        count --;
        message = 'Counter Decreased Successfully!';
        yield SuccessCounterState();
      }
  }  

}