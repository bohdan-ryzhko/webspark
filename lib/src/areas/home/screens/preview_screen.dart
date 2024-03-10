import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/areas/home/home.dart';
import 'package:flutter_application_1/src/areas/home/models/home_model.dart';
import 'package:flutter_application_1/src/utils.dart';
import 'package:flutter_application_1/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({
    super.key,
    required this.calculationResult,
  });

  final CalculationResult calculationResult;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeController = Provider.of<HomeScreenController>(context);

    final shortestPathFinder = ShortestPathFinder(calculationResult.result);
    final shortestPathData = shortestPathFinder.findShortestPath();
    final shortestPath = shortestPathFinder.getResult();

    final sizeCard = MediaQuery.of(context).size.width /
        calculationResult.result.field.first.length;

    final isLoading = homeController.calculationPath.connectionState ==
        ConnectionState.waiting;

    Color getColorCard({
      required int rowIndex,
      required int colIndex,
    }) =>
        (rowIndex == calculationResult.result.steps.first.x) &&
                (colIndex == calculationResult.result.steps.first.y)
            ? const Color(0XFF64FFDA)
            : (rowIndex == calculationResult.result.steps.last.x) &&
                    (colIndex == calculationResult.result.steps.last.y)
                ? const Color(0XFF009688)
                : shortestPathData
                        .contains(Coordinate(x: rowIndex, y: colIndex))
                    ? const Color(0xFF4CAF50)
                    : calculationResult.result.field[rowIndex][colIndex] == '.'
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
              itemCount: calculationResult.result.field.first.length,
              itemBuilder: (context, colIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    calculationResult.result.field.length,
                    (rowIndex) {
                      return Row(
                        children: [
                          Container(
                            width: sizeCard,
                            height: sizeCard,
                            decoration: BoxDecoration(
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
                                  color: calculationResult.result
                                              .field[rowIndex][colIndex] ==
                                          '.'
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
          isLoading
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: CircularProgressIndicator(color: theme.primaryColor),
                )
              : Button(
                  variant: Variant.primary,
                  text: 'Send resluts to server',
                  onPressed: isLoading
                      ? null
                      : () {
                          homeController.loadCalculationResult(
                              CalculationResult(
                                id: calculationResult.id,
                                result: Result(
                                  steps: shortestPathData,
                                  path: shortestPath,
                                  field: calculationResult.result.field,
                                ),
                              ),
                              context);
                        },
                ),
        ],
      ),
    );
  }
}
