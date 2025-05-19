import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:matt/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(const MyApp());
}
