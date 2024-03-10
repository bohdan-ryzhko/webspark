import 'package:flutter_application_1/src/areas/home/models/home_model.dart';
import 'package:flutter_application_1/src/areas/home/repository/home_repository.dart';

class HomeService {
  HomeService({
    required this.repository,
  });

  final HomeRepository repository;

  Map<String, dynamic> _convertPathDataToJson(
      CalculationResult calculationResult) {
    return {
      "id": calculationResult.id,
      "result": {
        "steps": calculationResult.result.steps
            .map((coordinate) => {
                  "x": coordinate.x,
                  "y": coordinate.y,
                })
            .toList(),
        "path": calculationResult.result.path,
      },
    };
  }

  List<CalculationResult> getListPaths(List<PathData> pathDataList) {
    return pathDataList.map((pathData) {
      return CalculationResult(
        id: pathData.id,
        result: Result(
          steps: [
            Coordinate(x: pathData.start.x, y: pathData.start.y),
            Coordinate(x: pathData.end.x, y: pathData.end.y),
          ],
          path:
              "(${pathData.start.x},${pathData.start.y})->(${pathData.end.x},${pathData.end.y})",
          field: pathData.field,
        ),
      );
    }).toList();
  }

  Future<ResponsePathData?> getPath(String url) async =>
      await repository.getPath(url);

  Future<CalculationResponse?> getCalculationResult(
      CalculationResult calculationResult) async {
    return await repository
        .sendCalculationResult(_convertPathDataToJson(calculationResult));
  }
}
