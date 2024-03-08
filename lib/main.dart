import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/app.dart';
import 'package:provider/provider.dart';

import 'src/areas/home/home.dart';

void main() {
// https://flutter.webspark.dev/flutter/api

  final Dio dio = Dio();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(
            service: HomeService(
              repository: HomeRepository(dio),
            ),
          ),
        ),
      ],
      child: const CalculatePathApp(),
    ),
  );
}
