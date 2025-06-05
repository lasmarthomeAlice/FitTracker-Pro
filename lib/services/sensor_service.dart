import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  StreamSubscription<AccelerometerEvent>? _accelSub;
  void Function(AccelerometerEvent event)? onData;

  void startListening(
      {required void Function(AccelerometerEvent event) onData}) {
    this.onData = onData;
    _accelSub = accelerometerEvents.listen((event) {
      onData(event);
    });
  }

  void stopListening() {
    _accelSub?.cancel();
    _accelSub = null;
    onData = null;
  }
}
