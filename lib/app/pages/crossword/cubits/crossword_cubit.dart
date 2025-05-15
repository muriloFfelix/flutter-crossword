import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matt/app/pages/crossword/cubits/crossword_states.dart';
import 'package:matt/app/pages/crossword/data/words_data.dart';
import 'package:matt/app/pages/crossword/data/grid_data.dart';

class CrosswordCubit extends Cubit<CrosswordState> {
  final List<Word> _words = wordsData;
  List<Word> get words => _words;

  final Grid _grid = gridData;
  Grid get grid => _grid;

  late LetterCell activeCell;
  late Word? activeWord;
  WordDirection activeDirection = WordDirection.across;

  Timer? timer;
  int timeElapsed = 0;

  CrosswordCubit() : super(InitialCrosswordState());

  handleCellSelection(LetterCell cell) {
    if (activeCell == cell) {
      toggleActiveDirection();
    } else {
      changeActiveCell(cell);
    }
    emit(InitialCrosswordState());
  }

  handleClueViewerAction(bool isForward) {
    int currentIndex = words.indexOf(activeWord!);

    if (isForward) {
      if (currentIndex + 1 >= words.length) {
        currentIndex = -1;
      }

      activeWord = words[currentIndex + 1];
    } else {
      if (currentIndex <= 0) {
        currentIndex = words.length;
      }

      activeWord = words[currentIndex - 1];
    }

    activeDirection = activeWord!.direction;
    changeActiveCellFromPosition(activeWord!.wordPostionsSpan.first);
  }

  handleKeyboardKeyInput(String letter) {
    if (timeElapsed != 0) return;

    bool hadLetter = activeCell.inputLetter != null;
    activeCell.inputLetter = letter;

    if (checkGridCompletion()) return;

    int currentLetterIndex =
        activeWord?.wordPostionsSpan.indexOf(activeCell.position) ?? -1;
    int currentWordIndex = words.indexOf(activeWord!);

    if (currentLetterIndex == -1) return;

    activeCell = getNextCell(currentLetterIndex, currentWordIndex, hadLetter);

    emit(InitialCrosswordState());
  }

  handleBackspaceInput() {
    if (timeElapsed != 0) return;

    if (activeCell.inputLetter == null) {
      int currentLetterIndex =
          activeWord?.wordPostionsSpan.indexOf(activeCell.position) ?? 0;
      if (currentLetterIndex != 0) currentLetterIndex--;

      changeActiveCellFromPosition(
          activeWord!.wordPostionsSpan[currentLetterIndex]);
    }

    activeCell.inputLetter = null;

    emit(InitialCrosswordState());
  }

  bool checkGridCompletion() {
    bool isSolved = true;

    for (GridRow row in grid.rows) {
      for (GridCell cell in row.cells) {
        if (cell is LetterCell) {
          if (cell.inputLetter == null) return false;
          if (cell.inputLetter?.toLowerCase() !=
              cell.rightLetter?.toLowerCase()) isSolved = false;
        }
      }
    }

    if (isSolved) emit(SolvedCrosswordState());
    if (!isSolved) emit(WrongCrosswordState());

    return true;
  }

// #region Helper functions

  toggleActiveDirection() {
    activeDirection = activeDirection == WordDirection.across
        ? WordDirection.down
        : WordDirection.across;

    changeActiveClue();
  }

  changeActiveCell(LetterCell cell) {
    activeCell = cell;
    changeActiveClue();
  }

  changeActiveCellFromPosition((int, int) position) {
    GridCell newCell = grid.rows[position.$1].cells[position.$2];

    if (newCell is! LetterCell) return;
    activeCell = newCell;

    changeActiveClue();
  }

  changeActiveClue() {
    activeWord = activeDirection == WordDirection.across
        ? activeCell.acrossWord
        : activeCell.downWord;

    emit(InitialCrosswordState());
  }

  LetterCell getNextCell(
      int currentLetterIndex, int currentWordIndex, bool hadLetter,
      [bool? wordChecked]) {
    if (currentLetterIndex >= (activeWord!.wordPostionsSpan.length - 1)) {
      currentLetterIndex = -1;

      if (wordChecked == true) {
        currentWordIndex + 1 >= words.length
            ? currentWordIndex = 0
            : currentWordIndex++;
        activeWord = words[currentWordIndex];
      }

      wordChecked = true;
    }

    GridCell nextCell = grid
        .rows[activeWord!.wordPostionsSpan[currentLetterIndex + 1].$1]
        .cells[activeWord!.wordPostionsSpan[currentLetterIndex + 1].$2];

    if (nextCell is! LetterCell ||
        (!hadLetter && nextCell.inputLetter != null)) {
      return getNextCell(
          currentLetterIndex + 1, currentWordIndex, hadLetter, wordChecked);
    } else {
      return nextCell;
    }
  }

  setElapsedTime(int time) {
    timeElapsed = time;
  }
}
