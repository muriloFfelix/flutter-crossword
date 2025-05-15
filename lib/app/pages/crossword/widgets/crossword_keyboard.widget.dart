import 'package:flutter/material.dart';
import 'package:matt/app/pages/crossword/cubits/crossword_cubit.dart';

class CrosswordKeyboard extends StatelessWidget {
  final CrosswordCubit cubit;

  const CrosswordKeyboard(
    this.cubit, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 12;

    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                keyboardKey('Q', size),
                keyboardKey('W', size),
                keyboardKey('E', size),
                keyboardKey('R', size),
                keyboardKey('T', size),
                keyboardKey('Y', size),
                keyboardKey('U', size),
                keyboardKey('I', size),
                keyboardKey('O', size),
                keyboardKey('P', size),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                keyboardKey('A', size),
                keyboardKey('S', size),
                keyboardKey('D', size),
                keyboardKey('F', size),
                keyboardKey('G', size),
                keyboardKey('H', size),
                keyboardKey('J', size),
                keyboardKey('K', size),
                keyboardKey('L', size),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 35,
                  height: 1,
                ),
                keyboardKey('Z', size),
                keyboardKey('X', size),
                keyboardKey('C', size),
                keyboardKey('V', size),
                keyboardKey('B', size),
                keyboardKey('N', size),
                keyboardKey('M', size),
                backspaceKey(size),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget keyboardKey(String value, double width) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: TapRegion(
        onTapInside: (_) => cubit.handleKeyboardKeyInput(value),
        child: Container(
          width: width,
          height: width * 1.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
              child: Text(
            value,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          )),
        ),
      ),
    );
  }

  Widget backspaceKey(double width) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: TapRegion(
        onTapInside: (_) => cubit.handleBackspaceInput(),
        child: Container(
          width: width * 1.8,
          height: width * 1.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(child: Icon(Icons.backspace_outlined)),
        ),
      ),
    );
  }
}
