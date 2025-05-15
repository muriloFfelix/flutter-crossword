import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:matt/app/pages/crossword/cubits/crossword_cubit.dart';

class CrosswordClueViewer extends StatelessWidget {
  const CrosswordClueViewer({
    super.key,
    required this.cubit,
  });

  final CrosswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[100],
      ),
      child: Row(
        children: [
          TapRegion(
              onTapInside: (_) => cubit.handleClueViewerAction(false),
              child: const SizedBox(
                width: 50,
                child: Icon(Icons.arrow_back),
              )),
          Expanded(
            child: TapRegion(
              onTapInside: (_) => cubit.toggleActiveDirection(),
              child: AutoSizeText(
                "${cubit.activeWord?.clueNumber}${cubit.activeDirection.abrv} - ${cubit.activeWord?.clue}",
                style: const TextStyle(fontSize: 24),
                maxLines: 2,
                minFontSize: 5,
                maxFontSize: 24,
              ),
            ),
          ),
          TapRegion(
              onTapInside: (_) => cubit.handleClueViewerAction(true),
              child: const SizedBox(
                width: 50,
                child: Icon(Icons.arrow_forward),
              )),
        ],
      ),
    );
  }
}
