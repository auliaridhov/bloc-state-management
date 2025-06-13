import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/time/time_bloc.dart';
import '../blocs/time/time_event.dart';
import '../blocs/time/time_state.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimeBloc()..add(StartClock()),
      child: BlocBuilder<TimeBloc, TimeState>(
        builder: (context, state) {
          if (state is TimeTick) {
            return Text('Time: ${state.currentTime}', style: const TextStyle(fontSize: 24));
          }
          return const Text('Loading time...');
        },
      ),
    );
  }
}
