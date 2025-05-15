import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matt/app/pages/crossword/cubits/timer_cubit.dart';
import 'package:matt/app/pages/crossword/cubits/timer_states.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        final minutes = (state.seconds ~/ 60).toString().padLeft(2, '0');
        final seconds = (state.seconds % 60).toString().padLeft(2, '0');

        return Text(
          '$minutes:$seconds',
          style: const TextStyle(
            fontSize: 24,
          ),
        );
      },
    );
  }
}
