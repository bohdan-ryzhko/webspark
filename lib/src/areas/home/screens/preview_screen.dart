import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/areas/home/models/home_model.dart';
import 'package:flutter_application_1/src/utils.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({
    super.key,
    required this.result,
  });

  final Result result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final shortestPathFinder = ShortestPathFinder(result);
    final shortestPathData = shortestPathFinder.findShortestPath();
    final shortestPath = shortestPathFinder.getResult();

    final sizeCard =
        MediaQuery.of(context).size.width / result.field.first.length;

    Color getColorCard({
      required int rowIndex,
      required int colIndex,
    }) =>
        (rowIndex == result.steps.first.x) && (colIndex == result.steps.first.y)
            ? const Color(0XFF64FFDA)
            : (rowIndex == result.steps.last.x) &&
                    (colIndex == result.steps.last.y)
                ? const Color(0XFF009688)
                : shortestPathData
                        .contains(Coordinate(x: rowIndex, y: colIndex))
                    ? const Color(0xFF4CAF50)
                    : result.field[rowIndex][colIndex] == '.'
                        ? Colors.white
                        : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Preview screen',
          style: theme.textTheme.bodyMedium,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: theme.primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(
            child: Text(
              shortestPath,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: result.field.first.length,
              itemBuilder: (context, colIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    result.field.length,
                    (rowIndex) {
                      return Row(
                        children: [
                          Container(
                            width: sizeCard,
                            height: sizeCard,
                            decoration: BoxDecoration(
                              // color: result.field[rowIndex][colIndex] == '.'
                              //     ? Colors.white
                              //     : Colors.black,

                              color: getColorCard(
                                rowIndex: rowIndex,
                                colIndex: colIndex,
                              ),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$rowIndex.$colIndex',
                                style: TextStyle(
                                  color: result.field[rowIndex][colIndex] == '.'
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
