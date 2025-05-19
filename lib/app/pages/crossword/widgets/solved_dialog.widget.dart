import 'package:flutter/material.dart';
import 'package:matt/app/pages/crossword/cubits/crossword_cubit.dart';

class SolvedDialog extends StatelessWidget {
  final CrosswordCubit cubit;

  const SolvedDialog(
    this.cubit, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final minutes = (cubit.timeElapsed ~/ 60).toString().padLeft(2, '0');
    final seconds = (cubit.timeElapsed % 60).toString().padLeft(2, '0');

    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 200,
        width: 200,
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'You did it! \n :3',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              const Spacer(),
              const Text(
                'your time:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                '$minutes:$seconds',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Admire puzzle',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
