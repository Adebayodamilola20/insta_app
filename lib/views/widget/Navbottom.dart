import 'package:flutter/material.dart';
import 'package:insta_app/data/notifiers.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Navbottom extends StatefulWidget {
  const Navbottom({super.key});

  @override
  State<Navbottom> createState() => _NavbottomState();
}

class _NavbottomState extends State<Navbottom> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedValueNotifier,
      builder: (context, selectedvalue, child) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // Custom painted bottom nav with notch
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 85),
              painter: BottomNavPainter(),
              child: Container(
                height: 85,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Home
                        _buildNavItem(
                          icon: LucideIcons.home,
                          selectedIcon: LucideIcons.home,
                          label: 'Home',
                          index: 0,
                          isSelected: selectedvalue == 0,
                        ),
                        // Search
                        _buildNavItem(
                          icon: Icons.search,
                          selectedIcon: Icons.search,
                          label: 'Search',
                          index: 1,
                          isSelected: selectedvalue == 1,
                        ),
                        // Spacer for center button
                        const SizedBox(width: 60),
                        // Activities
                        _buildNavItem(
                          icon: LucideIcons.book,
                          selectedIcon: LucideIcons.bookDown,
                          label: 'Activities',
                          index: 3,
                          isSelected: selectedvalue == 3,
                        ),
                        // Profile
                        _buildNavItem(
                          icon: Icons.person_outline,
                          selectedIcon: Icons.person,
                          label: 'Profile',
                          index: 4,
                          isSelected: selectedvalue == 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Floating center button
            Positioned(
              bottom: 49, //seal team
              child: GestureDetector(
                onTap: () {
                  selectedValueNotifier.value = 2;
                },
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF14B8A6),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF14B8A6).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        selectedValueNotifier.value = index;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? Colors.black : Colors.grey.shade600,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the curved notch
class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Starting point
    path.lineTo(0, 0);
    
    // Left side of the notch
    path.lineTo(size.width * 0.32, 0);
    
    
    path.quadraticBezierTo(
      size.width * 0.37, 0,
      size.width * 0.40, 15,
    );
    
    path.quadraticBezierTo(
      size.width * 0.45, 35,
      size.width * 0.50, 35,
    );
    
    path.quadraticBezierTo(
      size.width * 0.55, 35,
      size.width * 0.60, 15,
    );
    
    path.quadraticBezierTo(
      size.width * 0.63, 0,
      size.width * 0.68, 0,
    );
    
    // Right side of the notch
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
    
    // Draw the curved border around the notch to make it visible
    final borderPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Left border
    final leftBorderPath = Path();
    leftBorderPath.moveTo(0, 0);
    leftBorderPath.lineTo(size.width * 0.32, 0);
    canvas.drawPath(leftBorderPath, borderPaint);
    
    // Curved notch border
    final curveBorderPath = Path();
    curveBorderPath.moveTo(size.width * 0.32, 0);
    
    curveBorderPath.quadraticBezierTo(
      size.width * 0.37, 0,
      size.width * 0.40, 15,
    );
    
    curveBorderPath.quadraticBezierTo(
      size.width * 0.45, 35,
      size.width * 0.50, 35,
    );
    
    curveBorderPath.quadraticBezierTo(
      size.width * 0.55, 35,
      size.width * 0.60, 15,
    );
    
    curveBorderPath.quadraticBezierTo(
      size.width * 0.63, 0,
      size.width * 0.68, 0,
    );
    
    canvas.drawPath(curveBorderPath, borderPaint);
    

    final rightBorderPath = Path();
    rightBorderPath.moveTo(size.width * 0.68, 0);
    rightBorderPath.lineTo(size.width, 0);
    canvas.drawPath(rightBorderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
