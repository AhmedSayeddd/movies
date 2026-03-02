import 'package:flutter/material.dart';
import 'package:movies/core/app_color.dart';
import 'package:movies/core/app_style.dart';
class Onbordingcard extends StatelessWidget {
  const Onbordingcard({
    super.key,
    required this.title,
    required this.description,
    required this.onNext,
    required this.onBack,
    required this.buttonText,
    this.showBackButton = true,
  });

  final String title;
  final String description;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final String buttonText;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Color(AppColor.black),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppStyle.titletext
                .copyWith(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppStyle.subtitletext,
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: 398,
            height: 55,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(AppColor.gold),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(buttonText,
                  style: AppStyle.subtitletext.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black)),
            ),
          ),
          if (showBackButton) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: 398,
              height: 55,
              child: ElevatedButton(
                onPressed: onBack,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  side: BorderSide(color: Color(AppColor.gold)),
                ),
                child: Text("Back",
                    style: AppStyle.subtitletext.copyWith(
                        fontWeight: FontWeight.w600, color: Color(AppColor.gold))),
              ),
            ),
          ],
        ],
      ),
    );
  }
}