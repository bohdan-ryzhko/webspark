import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/areas/home/models/home_model.dart';
import 'package:flutter_application_1/src/areas/home/services/home_service.dart';

class HomeScreenController with ChangeNotifier {
  HomeScreenController({
    required this.service,
    AsyncSnapshot<ResponsePathData?> path = const AsyncSnapshot.nothing(),
    List<CalculationResult> pathsList = const [],
  })  : _path = path,
        _pathsList = pathsList;

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

  void resetPath() {
    _path = const AsyncSnapshot.nothing();
    notifyListeners();
  }

  List<CalculationResult> _pathsList;
  List<CalculationResult> get pathsList => _pathsList;

  void loadPathsList() {
    _pathsList = service.getListPaths(path.data!.data);
    notifyListeners();
  }
}
