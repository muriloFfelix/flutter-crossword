abstract class TimerState {
  final int seconds;
  TimerState(this.seconds);
}

class TimerInitial extends TimerState {
  TimerInitial(super.seconds);
}

class TimerRunning extends TimerState {
  TimerRunning(super.seconds);
}

class TimerPaused extends TimerState {
  TimerPaused(super.seconds);
}
