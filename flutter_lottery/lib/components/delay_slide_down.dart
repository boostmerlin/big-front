import 'package:flutter/cupertino.dart';

const kAniTime = 350;

class DelaySlideDown extends StatefulWidget {
  final Widget child;
  final int delayMills;

  const DelaySlideDown(
      {super.key, required this.child, required this.delayMills});

  @override
  State<StatefulWidget> createState() {
    return _DelaySlideDownState();
  }
}

class _DelaySlideDownState extends State<DelaySlideDown>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: kAniTime),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    end: Offset.zero,
    begin: const Offset(0.0, -600),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
    start();
  }

  void start() {
    Future.delayed(Duration(milliseconds: widget.delayMills), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _offsetAnimation.value,
      child: widget.child,
    );
  }
}
