import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _is_obj_Near = false;
  late StreamSubscription<dynamic> check_supscrip_stream;

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  @override
  void dispose() {
    super.dispose();
    check_supscrip_stream.cancel();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    check_supscrip_stream = ProximitySensor.events.listen((int occur_event) {
      setState(() {
        _is_obj_Near = (occur_event > 0) ? true : false;
      });
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Object Detect Mario App'),
    ),
    body: Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: _is_obj_Near ? Colors.green : Colors.red,
        child: Container(
          width: 250,
          height: 150,
          alignment: Alignment.center,
          child: Text(
            _is_obj_Near ? 'Object Detected' : 'No Object',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}
}