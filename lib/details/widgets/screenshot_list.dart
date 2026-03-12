import 'package:flutter/material.dart';
import '../../../core/widgets/custom_image.dart';

class ScreenshotList extends StatelessWidget {
  final List<String> screenshots;
  const ScreenshotList({super.key, required this.screenshots});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: screenshots.map((path) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CustomImage(
              imagePath: path,
              width: 398,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}
