import 'package:flutter/material.dart';
import 'package:matt/app/pages/crossword/cubits/crossword_cubit.dart';
import 'package:matt/app/pages/crossword/data/grid_data.dart';

class CrosswordGrid extends StatelessWidget {
  final CrosswordCubit cubit;

  const CrosswordGrid(
    this.cubit, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.grey,
          width: 1,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cubit.grid.rows
              .map(
                (row) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row.cells.map(
                    (cell) {
                      double size = (MediaQuery.sizeOf(context).width - 10) /
                          row.cells.length;
                      if (cell is LetterCell) {
                        return TapRegion(
                          onTapInside: (_) => cubit.handleCellSelection(cell),
                          child: Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                                color: cubit.activeCell == cell
                                    ? Colors.amber
                                    : cubit.activeWord != null &&
                                            cubit.activeWord!.wordPostionsSpan
                                                .contains(cell.position)
                                        ? Colors.blue[100]
                                        : cubit.activeWord?.references !=
                                                    null &&
                                                cubit.activeWord!.references!
                                                    .contains(cell.position)
                                            ? const Color.fromARGB(
                                                255, 255, 242, 220)
                                            : Colors.transparent,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                )),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -1,
                                  left: 0.5,
                                  child: Text(
                                    "${cell.clueNumber ?? ''}",
                                    style: const TextStyle(fontSize: 6),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    cell.inputLetter ?? '',
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              )),
                        );
                      }
                    },
                  ).toList(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
