import 'package:flutter/material.dart';

class GradientProgressBar extends StatefulWidget {
  

  GradientProgressBar({Key? key}) : super(key: key);


  @override
  _GradientProgressBarState createState() => _GradientProgressBarState();
}

class _GradientProgressBarState extends State<GradientProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:  const Duration(seconds:30),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientProgressPainter(
        progress: _animation.value,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple,
            Colors.blue, // dark purple
            Colors.red,
            Colors.pink // red
          ],
        ),
      ),
      child: const SizedBox(
        width: double.infinity,
        height: 10,
      ),
    );
  }
}

class GradientProgressPainter extends CustomPainter {
  GradientProgressPainter({required this.progress, required this.gradient});

  final double progress;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    Paint paint = Paint()..shader = gradient.createShader(rect);

    canvas.drawRect(
      Rect.fromPoints(
        rect.topLeft,
        Offset(rect.width * progress, rect.height),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
