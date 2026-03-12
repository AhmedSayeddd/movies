import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  const CustomImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.alignment = Alignment.center,
  });
  @override
  Widget build(BuildContext context) {
    if (imagePath.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[900],
        child: const Icon(Icons.movie_outlined, color: Colors.white24),
      );
    }
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: Colors.grey[900],
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFFFFBB3B),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[900],
            child: const Icon(Icons.error_outline, color: Colors.white24),
          );
        },
      );
    } else {
      return Image.asset(
        imagePath,
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[900],
            child: const Icon(
              Icons.broken_image_rounded,
              color: Colors.white24,
            ),
          );
        },
      );
    }
  }
}
