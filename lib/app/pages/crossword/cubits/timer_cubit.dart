import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matt/app/pages/crossword/cubits/timer_states.dart';

class TimerCubit extends Cubit<TimerState> {
  Timer? _timer;
  int _secondsElapsed = 0;

  TimerCubit() : super(TimerInitial(0));

  void startTimer() {
    _secondsElapsed = 0;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _secondsElapsed++;
      emit(TimerRunning(_secondsElapsed));
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    emit(TimerPaused(_secondsElapsed));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
