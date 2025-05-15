import 'package:flutter/material.dart';

class WrongSolutionDialog extends StatelessWidget {
  const WrongSolutionDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                'Something seems wrong \n :(',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              const Spacer(),
              TextButton(
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Go back',
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
