import 'package:CounterApp/bloc/counter_bloc.dart';
import 'package:CounterApp/bloc/counter_event.dart';
import 'package:CounterApp/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App BLoC'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: BlocProvider<CounterBloc>(
              create: (BuildContext context) =>
                  CounterBloc(InitiateCounterState()),
              child: BlocConsumer<CounterBloc, CounterStates>(
                  builder: (BuildContext context, CounterStates states) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Your Current Counter Value'),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      CounterBloc.get(context).count.toString(),
                      style: TextStyle(fontSize: 50),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton.icon(
                          icon: Icon(Icons.add),
                          label: Text('Increment'),
                          onPressed: () {
                            CounterBloc.get(context).add(IncrementEvent());
                          },
                        ),
                        RaisedButton.icon(
                          icon: Icon(Icons.remove),
                          label: Text('Decrement'),
                          onPressed: () {
                            CounterBloc.get(context).add(DecrementEvent());
                          },
                        ),
                      ],
                    )
                  ],
                );
              }, listener: (BuildContext context, CounterStates state) {
                SnackBar snackBar;
                if (state is SuccessCounterState) {
                  snackBar = SnackBar(
                      content:
                          Text(CounterBloc.get(context).message.toString()),
                      backgroundColor: Colors.green,
                      duration: Duration(milliseconds: 500));
                  return Scaffold.of(context).showSnackBar(snackBar);
                } else if (state is ErrorCounterState) {
                  snackBar = SnackBar(
                      content:
                          Text(CounterBloc.get(context).message.toString()),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1));
                  return Scaffold.of(context).showSnackBar(snackBar);
                }
              })),
        ),
      ),
    );
  }
}
