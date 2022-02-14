import 'package:flutter/material.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:get/get.dart';

import 'dart:math' as math show sqrt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Microphone Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    my_global_init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextButton(
            //     onPressed: () async {
            //       await grpcController.test();
            //     },
            //     child: Text("click me to test")),
            Obx(() => Ripples(
                  color: Colors.blueAccent,
                  waveOn: microphoneAndSpeakerController.isReceiving.value,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (microphoneAndSpeakerController.isReceiving.value) {
                        microphoneAndSpeakerController.stopSpeaking();
                      } else {
                        await microphoneAndSpeakerController.startSpeaking();
                      }
                    },
                    child: const Icon(
                      Icons.speaker,
                      color: Colors.white,
                      size: 60.0,
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10.0),
                        shape: const CircleBorder(),
                        primary: Colors.black),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            Obx(() => Ripples(
                  color: Colors.blueAccent,
                  waveOn: microphoneAndSpeakerController.isRecording.value,
                  child: ElevatedButton(
                    onPressed: () {
                      if (microphoneAndSpeakerController.isRecording.value) {
                        microphoneAndSpeakerController.stopRecording();
                      } else {
                        microphoneAndSpeakerController.startRecording();
                      }
                    },
                    child: const Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 60.0,
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10.0),
                        shape: const CircleBorder(),
                        primary: Colors.purple),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class Ripples extends StatefulWidget {
  const Ripples({
    Key? key,
    this.size = 80.0,
    this.color = Colors.pink,
    required this.waveOn,
    required this.child,
  }) : super(key: key);

  final double size;
  final Color color;
  final Widget child;
  final bool waveOn;

  @override
  _RipplesState createState() => _RipplesState();
}

class _CirclePainter extends CustomPainter {
  _CirclePainter(
    this._animation, {
    required this.color,
  }) : super(repaint: _animation);

  final Color color;
  final Animation<double> _animation;

  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);

    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);

    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => true;
}

class _RipplesState extends State<Ripples> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Widget _button() {
    return Center(
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.waveOn == false) {
      return _button();
    }
    return CustomPaint(
      painter: _CirclePainter(
        _controller,
        color: widget.color,
      ),
      child: SizedBox(
        width: widget.size * 2.125,
        height: widget.size * 2.125,
        child: _button(),
      ),
    );
  }
}
