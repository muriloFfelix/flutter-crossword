abstract class CrosswordState {}

class InitialCrosswordState extends CrosswordState {}

class WrongCrosswordState extends CrosswordState {}

class SolvedCrosswordState extends CrosswordState {}

class ErrorCrosswordState extends CrosswordState {
  String message;

  ErrorCrosswordState(this.message);
}
