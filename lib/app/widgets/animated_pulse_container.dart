import 'package:flutter/material.dart';

class AnimatedPulseContainer extends StatefulWidget {
  final Widget child;

  const AnimatedPulseContainer({Key? key, required this.child})
      : super(key: key);

  @override
  _AnimatedPulseContainerState createState() => _AnimatedPulseContainerState();
}

class _AnimatedPulseContainerState extends State<AnimatedPulseContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }
}
