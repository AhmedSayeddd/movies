
import 'package:flutter/material.dart';

class LanguageToggle extends StatefulWidget {
  final Color activeColor;
  const LanguageToggle({super.key, required this.activeColor});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isEnglish = !isEnglish),
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: widget.activeColor, width: 2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isEnglish
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: widget.activeColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFlag('assets/images/US.png'),
                _buildFlag('assets/images/EG.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlag(String path) {
    return Image.asset(
      path,
      width: 24,
      errorBuilder: (context, error, stackTrace) =>
      const Icon(Icons.flag, size: 18, color: Colors.white),
    );
  }
}
