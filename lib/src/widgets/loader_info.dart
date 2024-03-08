import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/areas/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class LoaderInfo extends StatefulWidget {
  const LoaderInfo({super.key});

  @override
  State<LoaderInfo> createState() => _LoaderInfoState();
}

class _LoaderInfoState extends State<LoaderInfo> with TickerProviderStateMixin {
  static const int duration = 3;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: duration),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 100).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.animateTo(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeController = Provider.of<HomeScreenController>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 170),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            homeController.path.connectionState == ConnectionState.done
                ? 'All calculations has finished, you can send your results to server'
                : 'Progress: ${animation.value.toStringAsFixed(0)}%',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              value: controller.value,
              strokeWidth: 7,
              color: theme.primaryColor,
              semanticsLabel: 'Circular progress indicator',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
