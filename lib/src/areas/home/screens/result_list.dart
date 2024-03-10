import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/areas/home/home.dart';
import 'package:flutter_application_1/src/areas/home/screens/preview_screen.dart';
import 'package:provider/provider.dart';

class ResultList extends StatelessWidget {
  const ResultList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeScreenController>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result list',
          style: theme.textTheme.bodyMedium,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: theme.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: homeController.pathsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PreviewScreen(
                          calculationResult: homeController.pathsList[index],
                        ),
                      ),
                    );
                  },
                  title: Center(
                    child: Text(homeController.pathsList[index].result.path),
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
