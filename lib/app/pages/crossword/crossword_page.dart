// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matt/app/pages/crossword/cubits/crossword_cubit.dart';
import 'package:matt/app/pages/crossword/cubits/crossword_states.dart';
import 'package:matt/app/pages/crossword/cubits/timer_cubit.dart';
import 'package:matt/app/pages/crossword/cubits/timer_states.dart';
import 'package:matt/app/pages/crossword/data/grid_data.dart';
import 'package:matt/app/pages/crossword/widgets/crossword_clue_viewer.widget.dart';
import 'package:matt/app/pages/crossword/widgets/crossword_grid.widget.dart';
import 'package:matt/app/pages/crossword/widgets/crossword_keyboard.widget.dart';
import 'package:matt/app/pages/crossword/widgets/solved_dialog.widget.dart';
import 'package:matt/app/pages/crossword/widgets/timer_display.widget.dart';
import 'package:matt/app/pages/crossword/widgets/wrong_solution_dialog.widget.dart';

class MyCrosswordPage extends StatefulWidget {
  const MyCrosswordPage({super.key, required this.title});

  final String title;

  @override
  State<MyCrosswordPage> createState() => _MyCrosswordPageState();
}

class _MyCrosswordPageState extends State<MyCrosswordPage> {
  late final CrosswordCubit crosswordCubit;
  late final TimerCubit timerCubit;

  @override
  void initState() {
    super.initState();

    crosswordCubit = BlocProvider.of<CrosswordCubit>(context);
    crosswordCubit.activeCell =
        crosswordCubit.grid.rows[0].cells.whereType<LetterCell>().first;
    crosswordCubit.changeActiveClue();

    crosswordCubit.stream.listen((state) {
      if (state is ErrorCrosswordState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
      if (state is WrongCrosswordState) {
        showDialog(
          context: context,
          builder: (context) {
            return const WrongSolutionDialog();
          },
        );
      }
      if (state is SolvedCrosswordState) {
        timerCubit.pauseTimer();
        showDialog(
          context: context,
          builder: (context) {
            return SolvedDialog(crosswordCubit);
          },
        );
      }
    });

    timerCubit = BlocProvider.of<TimerCubit>(context);
    timerCubit.startTimer();

    timerCubit.stream.listen((state) {
      if (state is TimerPaused) {
        crosswordCubit.setElapsedTime(state.seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Flexible(child: TimerDisplay()),
      ),
      body: BlocBuilder(
        bloc: crosswordCubit,
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  CrosswordGrid(crosswordCubit),
                  const Spacer(),
                  CrosswordClueViewer(cubit: crosswordCubit),
                  CrosswordKeyboard(crosswordCubit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
