import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matt/app/pages/crossword/cubits/crossword_cubit.dart';
import 'package:matt/app/pages/crossword/crossword_page.dart';
import 'package:matt/app/pages/crossword/cubits/timer_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CrosswordCubit(),
        ),
        BlocProvider(
          create: (_) => TimerCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyCrosswordPage(title: 'Flutter Demo Crossword Page'),
      ),
    );
  }
}
