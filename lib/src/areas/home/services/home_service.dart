import 'package:flutter_application_1/src/areas/home/models/home_model.dart';
import 'package:flutter_application_1/src/areas/home/repository/home_repository.dart';

class HomeService {
  HomeService({
    required this.repository,
  });

  final HomeRepository repository;

  List<Map<String, dynamic>> _convertPathDataToJson(
      List<PathData> pathDataList) {
    return pathDataList.map((pathData) {
      return {
        "id": pathData.id,
        "result": {
          "steps": [
            {
              "x": pathData.start.x.toString(),
              "y": pathData.start.y.toString(),
            },
            {
              "x": pathData.end.x.toString(),
              "y": pathData.end.y.toString(),
            }
          ],
          "path":
              "(${pathData.start.x},${pathData.start.y})->(${pathData.end.x},${pathData.end.y})",
        },
      };
    }).toList();
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

  // Future<void> getCalculatePath(List<PathData> pathDataList) {
  //   await repository.getCalculatePath(_convertPathDataToJson(pathDataList));
  // }
}
