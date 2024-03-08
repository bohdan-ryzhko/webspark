class CalculationResult {
  const CalculationResult({
    required this.id,
    required this.result,
  });

  final String id;
  final Result result;
}

class Result {
  const Result({
    required this.steps,
    required this.path,
    required this.field,
  });

  final List<Coordinate> steps;
  final String path;
  final List<String> field;
}

class ResponsePathData {
  const ResponsePathData({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool error;
  final String message;
  final List<PathData> data;
}

class PathData {
  const PathData({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  final String id;
  final List<String> field;
  final Coordinate start;
  final Coordinate end;

  factory PathData.fromJson(Map<String, dynamic> json) {
    return PathData(
      id: json['id'] ?? '',
      field: List<String>.from(json['field'] ?? []),
      start: Coordinate.fromJson(json['start'] ?? {}),
      end: Coordinate.fromJson(json['end'] ?? {}),
    );
  }
}

class Coordinate {
  const Coordinate({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      x: json['x'] ?? 0,
      y: json['y'] ?? 0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coordinate && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
