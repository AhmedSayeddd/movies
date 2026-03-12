import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Floating rounded bottom navigation bar with 4 SVG icons.
/// Active icon → Gold (#FFBB3B). Inactive → Gray.
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _icons = [
    'assets/icons/home.svg',
    'assets/icons/search.svg',
    'assets/icons/explore.svg',
    'assets/icons/Profiel.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFF232524),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_icons.length, (index) {
          final bool isActive = currentIndex == index;
          return _NavItem(
            iconPath: _icons[index],
            isActive: isActive,
            onTap: () => onTap(index),
          );
        }),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconPath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: SvgPicture.asset(
          iconPath,
          width: 26,
          height: 26,
          colorFilter: ColorFilter.mode(
            isActive ? const Color(0xFFFFBB3B) : Colors.grey.shade500,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
