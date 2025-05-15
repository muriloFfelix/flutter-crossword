import 'package:matt/app/pages/crossword/data/words_data.dart';

Grid gridData = Grid.generateGrid(13, 14, [
  (0, 0),
  (0, 6),
  (0, 13),
  (1, 0),
  (1, 6),
  (1, 13),
  (2, 6),
  (2, 13),
  (3, 7),
  (3, 8),
  (3, 9),
  (3, 10),
  (4, 3),
  (4, 4),
  (4, 5),
  (5, 5),
  (6, 0),
  (6, 1),
  (6, 6),
  (6, 12),
  (6, 13),
  (7, 7),
  (8, 7),
  (8, 8),
  (8, 9),
  (8, 10),
  (9, 3),
  (9, 4),
  (9, 5),
  (10, 0),
  (10, 6),
  (11, 0),
  (11, 6),
  (11, 13),
  (12, 0),
  (12, 6),
  (12, 13),
]);

// #region Class declarations

class Grid {
  List<GridRow> rows;

  Grid(this.rows);

  static Grid generateGrid(
    int rowsNumber,
    int columnsNumber, [
    List<(int, int)>? blocks,
  ]) {
    List<GridRow> rows = List.generate(rowsNumber, (indexY) {
      return GridRow(List.generate(columnsNumber, (indexZ) {
        final cellPosition = (indexY, indexZ);
        if (blocks != null && blocks.contains(cellPosition)) {
          return BlockCell();
        } else {
          if (getAcrossWord(cellPosition) != null) {
            return LetterCell.fromPosition(cellPosition);
          } else {
            return LetterCell(cellPosition);
          }
        }
      }));
    });

    return Grid(rows);
  }
}

class GridRow {
  List<GridCell> cells;

  GridRow(this.cells);
}

class GridCell {}

class LetterCell extends GridCell {
  (int, int) position;
  Word? acrossWord;
  Word? downWord;
  String? inputLetter;
  String? rightLetter;
  int? clueNumber;

  LetterCell(this.position,
      {this.acrossWord,
      this.downWord,
      this.clueNumber,
      this.inputLetter,
      this.rightLetter});

  static LetterCell fromPosition((int, int) position) {
    Word? acrossWord = getAcrossWord(position);
    Word? downWord = getDownWord(position);

    return LetterCell(
      position,
      acrossWord: acrossWord,
      downWord: downWord,
      clueNumber: position == acrossWord?.wordStartPosition
          ? acrossWord?.clueNumber
          : position == downWord?.wordStartPosition
              ? downWord?.clueNumber
              : null,
      rightLetter:
          acrossWord?.answer[position.$2 - acrossWord.wordStartPosition.$2],
    );
  }
}

class BlockCell extends GridCell {}

// #endregion

// #region Grid Functions

Word? getAcrossWord((int, int) position) {
  return wordsData
      .where(
        (word) =>
            word.direction == WordDirection.across &&
            position.$1 == word.wordStartPosition.$1 &&
            position.$2 >= word.wordStartPosition.$2 &&
            position.$2 < word.wordStartPosition.$2 + word.answer.length,
      )
      .toList()
      .firstOrNull;
}

Word? getDownWord((int, int) position) {
  return wordsData
      .where((word) =>
          word.direction == WordDirection.down &&
          position.$2 == word.wordStartPosition.$2 &&
          position.$1 >= word.wordStartPosition.$1 &&
          position.$1 <= word.wordStartPosition.$1 + word.answer.length)
      .toList()
      .firstOrNull;
}

// #endregion