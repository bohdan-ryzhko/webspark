import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/areas/home/home.dart';
import 'package:flutter_application_1/src/areas/home/screens/result_list.dart';
import 'package:flutter_application_1/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeScreenController>(context);
    final theme = Theme.of(context);

    final linkController = TextEditingController();
    final isLoad =
        homeController.path.connectionState == ConnectionState.waiting;
    final isDone = homeController.path.connectionState == ConnectionState.done;

    return UnfocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          title: Text(
            'Home screen',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        body: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoad || isDone
                  ? const Center(child: LoaderInfo())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Text(
                            homeController.path.connectionState ==
                                    ConnectionState.active
                                ? 'Set valid API base URL in order to continue'
                                : 'Enter a link',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.link),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Input(
                                  controller: linkController,
                                  hintText: 'Link...',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              const Expanded(child: Text('')),
              isDone
                  ? Column(
                      children: [
                        Button(
                          margin: const EdgeInsets.only(
                              right: 20, left: 20, bottom: 10),
                          variant: Variant.secondary,
                          text: 'Reset data',
                          onPressed: () {
                            homeController.resetPath();
                          },
                        ),
                        Button(
                          variant: Variant.primary,
                          text: 'To list points',
                          onPressed: () {
                            homeController.loadPathsList();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ResultList(),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : Button(
                      variant: Variant.primary,
                      text: 'Start counting process',
                      onPressed: isLoad
                          ? null
                          : () => homeController.loadPath(linkController.text),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
