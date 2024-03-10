import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/areas/home/models/home_model.dart';
import 'package:flutter_application_1/src/areas/home/services/home_service.dart';

class HomeScreenController with ChangeNotifier {
  HomeScreenController({
    required this.service,
    AsyncSnapshot<ResponsePathData?> path = const AsyncSnapshot.nothing(),
    List<CalculationResult> pathsList = const [],
    AsyncSnapshot calculationPath = const AsyncSnapshot.nothing(),
  })  : _path = path,
        _pathsList = pathsList,
        _calculationPath = calculationPath;

  final HomeService service;

  AsyncSnapshot<ResponsePathData?> get path => _path;
  AsyncSnapshot<ResponsePathData?> _path;

  Future<void> loadPath(String url) async {
    _path = const AsyncSnapshot.waiting();
    notifyListeners();

    final response = await service.getPath(url);

    if (response == null) {
      _path = const AsyncSnapshot.withData(ConnectionState.active, null);
    } else {
      _path = AsyncSnapshot.withData(ConnectionState.done, response);
    }

    notifyListeners();
  }

  AsyncSnapshot _calculationPath;
  AsyncSnapshot get calculationPath => _calculationPath;

  Future<void> loadCalculationResult(
    CalculationResult calculationResult,
    BuildContext context,
  ) async {
    _calculationPath = const AsyncSnapshot.waiting();
    notifyListeners();

    final response = await service.getCalculationResult(calculationResult);

    if (response == null) {
      _calculationPath =
          const AsyncSnapshot.withData(ConnectionState.active, null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: SizedBox(
            height: 50,
            child: Text(
              "Result was not sent, please try again later",
              style: TextStyle(fontSize: 18),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 153, 36, 27),
        ),
      );
    } else {
      _calculationPath = AsyncSnapshot.withData(ConnectionState.done, response);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: SizedBox(
            height: 50,
            child: Text(
              "Send result success!",
              style: TextStyle(fontSize: 18),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 96, 146, 32),
        ),
      );
    }

    notifyListeners();
  }

  List<CalculationResult> _pathsList;
  List<CalculationResult> get pathsList => _pathsList;

  void loadPathsList() {
    _pathsList = service.getListPaths(path.data!.data);
    notifyListeners();
  }

  void resetPath() {
    _path = const AsyncSnapshot.nothing();
    notifyListeners();
  }
}
