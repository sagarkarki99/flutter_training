import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starting_app/counter/bloc/counter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const _CounterBody(),
    );
  }
}

class _CounterBody extends StatelessWidget {
  const _CounterBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CounterText(),
          const SizedBox(height: 12.0),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(IncreaseCounter());
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, state) {
        return Text(state.toString());
      },
    );
  }
}
