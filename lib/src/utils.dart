import 'areas/home/models/home_model.dart';

class Queue<T> {
  final _queue = [];

  void push(T item) {
    _queue.add(item);
  }

  T remove() {
    return _queue.removeAt(0);
  }

  bool get isEmpty => _queue.isEmpty;
}

class ShortestPathFinder {
  ShortestPathFinder(this.result);

  final Result result;

  List<List<String>> _field = [];

  List<Coordinate> findShortestPath() {
    _field = _convertToTwoDimensional(result.field);

    final visited = List.generate(
        _field.length, (index) => List<bool>.filled(_field[0].length, false));

    final Queue<List<Coordinate>> queue = Queue<List<Coordinate>>();
    queue.push([result.steps.first]);

    final directions = [
      const Coordinate(x: 0, y: 1),
      const Coordinate(x: 0, y: -1),
      const Coordinate(x: 1, y: 0),
      const Coordinate(x: -1, y: 0),
      const Coordinate(x: 1, y: 1),
      const Coordinate(x: 1, y: -1),
      const Coordinate(x: -1, y: 1),
      const Coordinate(x: -1, y: -1),
    ];

    while (!queue.isEmpty) {
      final path = queue.remove();
      final current = path.last;

      if (current == result.steps.last) {
        return path;
      }

      for (final dir in directions) {
        final next = Coordinate(x: current.x + dir.x, y: current.y + dir.y);

        if (_isValid(next) && !visited[next.x][next.y]) {
          visited[next.x][next.y] = true;
          final newPath = List<Coordinate>.from(path);
          newPath.add(next);
          queue.push(newPath);
        }
      }
    }

    return [];
  }

  List<List<String>> _convertToTwoDimensional(List<String> inputArray) {
    List<List<String>> twoDimensionalArray = [];

    for (String row in inputArray) {
      List<String> rowArray = [];
      for (int i = 0; i < row.length; i++) {
        rowArray.add(row[i]);
      }
      twoDimensionalArray.add(rowArray);
    }

    return twoDimensionalArray;
  }

  bool _isValid(Coordinate point) {
    if (point.x < 0 || point.x >= _field.length) return false;
    if (point.y < 0 || point.y >= _field[0].length) return false;
    if (_field[point.x][point.y] == 'X') return false;
    return true;
  }

  String getResult() =>
      findShortestPath().map((e) => '(${e.x},${e.y})').toList().join('->');
}
