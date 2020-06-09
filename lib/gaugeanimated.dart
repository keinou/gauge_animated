library gaugeanimated;
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GaugeAnimated {
  static Widget build(
      {@required Driver driver,
        @required Widget centerWidget,
        @required Color fullColor,
        @required Color percentColor,
        @required double fullWidth,
        @required double percentWidth}) {
    return Center(
        child: AnimatedGauge(
            driver: driver,
            centerWidget: centerWidget,
            fullColor: fullColor,
            percentColor: percentColor,
            fullWidth: fullWidth,
            percentWidth: percentWidth
        ));
  }
}

class Driver {
  Driver() {
    _controller = StreamController.broadcast();
  }

  StreamController _controller;

  double _atual = 0.0;
  double _maximo = 100;

  bool get maxed => (_atual >= _maximo);

  double get getValue => (_atual);

  void listen(Function x) => _controller.stream.listen(x);

  void add(double x) {
    _atual = maxed ? 0 : (_atual + x);
    _controller.add(_atual);
  }
}

class AnimatedGauge extends StatefulWidget {
  AnimatedGauge(
      {Key key,
        @required this.driver,
        this.centerWidget,
        @required this.fullColor,
        @required this.percentColor,
        @required this.fullWidth,
        @required this.percentWidth})
      : super(key: key);

  final Driver driver;
  final Widget centerWidget;
  final Color fullColor;
  final Color percentColor;
  final double fullWidth;
  final double percentWidth;

  @override
  GaugeState createState() => GaugeState(centerWidget: centerWidget);
}

class GaugeState extends State<AnimatedGauge>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  GaugeState({Widget centerWidget});

  String get _readout => (_animation.value).toStringAsFixed(0) + '%';

  double begin = 0.0;
  double end = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 320));
    widget.driver.listen(on);
  }

  void on(dynamic x) => setState(() {
    begin = end;
    end = x;
  });

  @override
  Widget build(BuildContext context) {
    final double _diameter = (MediaQuery.of(context).size.width / 1.616);

    _controller.reset();
    _animation = Tween<double>(begin: begin, end: end).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        begin = end;
      }
    });

    _controller.forward();

    return AnimatedBuilder(
        animation: _animation,
        builder: (context, xWidget) {
          return CustomPaint(
              foregroundPainter: GaugePainter(
                  percent: _animation.value,
                  fullColor: widget.fullColor,
                  percentColor: widget.percentColor,
                  fullWidth: widget.fullWidth,
                  percentWidth: widget.percentWidth),
              child: Container(
                  constraints: BoxConstraints.expand(
                      height: _diameter, width: _diameter),
                  child: Align(
                    alignment: Alignment.center,
                    child: widget.centerWidget ?? Container(),
                  )));
        });
  }
}

class GaugePainter extends CustomPainter {
  GaugePainter(
      {@required this.percent,
        @required this.fullColor,
        @required this.percentColor,
        @required this.fullWidth,
        @required this.percentWidth})
      : super();

  final double percent;
  final Color fullColor;
  final Color percentColor;
  final double fullWidth;
  final double percentWidth;

  @override
  void paint(Canvas canvas, Size size) {

    Paint line = new Paint()
      ..color = fullColor
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = fullWidth;

    Paint elapsedBrush = new Paint()
      ..strokeWidth = percentWidth
      ..color = percentColor
      ..style = PaintingStyle.stroke;

    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2.2, size.height / 2.2);
    double angle = 2 * pi / 60; //2 * pi * percent;

    Rect rect = new Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(rect, 25 * angle, 40 * angle, false, line);

    canvas.drawArc(rect, 25 * angle + (40 * angle) * (percent / 100),
        (40 * angle) * (0 - (percent / 100)), false, elapsedBrush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
