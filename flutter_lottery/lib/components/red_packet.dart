import 'package:flutter/material.dart';
import 'package:flutter_lottery/model/index.dart';
import 'package:flutter_lottery/model/strings.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

const kPacketWidth = 130.0;
const kPacketHeight = 190.0;


typedef PrizeCallBack = void Function(Prize prize);

class RedPacket extends StatefulWidget {
  const RedPacket(
      {Key? key,
      required Prize prize,
      required PrizeCallBack onOpen,
      required bool active})
      : _onOpen = onOpen,
        _prize = prize,
        _active = active,
        super(key: key);

  final PrizeCallBack _onOpen;
  final Prize _prize;

  final bool _active;

  @override
  State<RedPacket> createState() => _RedPacketState();
}

class _RedPacketState extends State<RedPacket> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _shakeController;

  late Animation<double> lowerAnim;
  late Animation<double> upperAnim;
  late Animation<double> fadeAnim;
  late Animation<double> shake;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget._onOpen(widget._prize);
      }
    });

    _shakeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _shakeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shakeController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _shakeController.reset();
        _controller.forward();
      }
    });

    shake = TweenSequence<double>([
      ///TweenSequenceItem来组合其他的Tween
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 0.1), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: 0.1, end: 0), weight: 2),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: -0.1), weight: 3),
      TweenSequenceItem<double>(tween: Tween(begin: -0.1, end: 0), weight: 4),
    ]).animate(_shakeController);

    var curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    lowerAnim = Tween<double>(begin: 95, end: 0).animate(curve);
    upperAnim = Tween<double>(begin: 153, end: 0).animate(curve);
    fadeAnim = Tween<double>(begin: 1, end: 0).animate(curve);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _shakeController.dispose();
  }

  void _handleOpen() {
    //run the animation
    _shakeController.forward();
  }

  /**
      <div className={cx("redpacket", { shake: open })}>
      <div className="prize">
        <span>{props.prize.name}</span>
      </div>
      <div className={cx("redpacket-lower", { open })} />
      <div className={cx("redpacket-upper", { open })}>
        <div
          className={cx("redpacket-button", { fade: open })}
          onClick={props.active ? handleOpen : undefined}
        >
          {OPEN}
        </div>
      </div>
     </div>
   */
  @override
  Widget build(BuildContext context) {
    return ShakeAnimationBuilder(
      animation: shake,
      child: Container(
        width: kPacketWidth,
        height: kPacketHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color.fromARGB(255, 214, 207, 207),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(50, 23, 22, 22),
                offset: Offset(0.0, 0.2),
                blurRadius: 4.0,
                spreadRadius: 3.0),
            BoxShadow(
                color: Color.fromARGB(20, 0, 0, 0),
                offset: Offset(0.2, 0.1),
                blurRadius: 2.0,
                spreadRadius: 1.0),
          ],
        ),
        child: Stack(alignment: Alignment.center, children: [
          Center(
              child: Text(
            widget._prize.name!,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'serif',
              color: Color(0xffd8493b),
            ),
          )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0.1, //lower
            child: AnimatedBuilder(
              animation: lowerAnim,
              builder: (context, child) => Container(
                height: lowerAnim.value,
                decoration: BoxDecoration(
                  color: const Color(0xffc60000),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.1, //upper
            left: 0,
            right: 0,

            child: AnimatedBuilder(
              animation: lowerAnim,
              builder: (context, child) => Container(
                height: upperAnim.value,
                decoration: const BoxDecoration(
                  color: Color(0xffe62601),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(kPacketWidth * 0.4),
                      bottomLeft: Radius.circular(kPacketWidth * 0.4)),
                ),
              ),
            ),
          ),
          Positioned(
            top: kPacketWidth - 15,
            child: AnimatedBuilder(
              animation: lowerAnim,
              builder: (context, child) => Container(
                //open button
                alignment: Alignment.center,
                constraints:
                    const BoxConstraints.tightFor(width: 30, height: 30),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(253, 204, 3, fadeAnim.value),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: AnimatedBuilder(
                    animation: fadeAnim,
                    builder: (context, child) {
                      return TextButton(
                        onPressed: widget._active ? _handleOpen : null,
                        child: Text(
                          open,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'serif',
                            color:
                                Color.fromRGBO(255, 255, 255, fadeAnim.value),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
