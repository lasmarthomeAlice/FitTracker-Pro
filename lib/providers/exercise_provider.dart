import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../services/sensor_service.dart';
import '../models/exercise.dart';

class ExerciseProvider extends ChangeNotifier {
  final SensorService _sensorService = SensorService();
  int count = 0;
  bool isRunning = false;
  double? lastZ;
  bool _peakDetected = false;

  void start(ExerciseType type) {
    count = 0;
    isRunning = true;
    if (type == ExerciseType.pushUp) {
      _sensorService.startListening(onData: _pushUpCountLogic);
    }
    // 其他运动类型可扩展
    notifyListeners();
  }

  void pause() {
    isRunning = false;
    _sensorService.stopListening();
    notifyListeners();
  }

  void resume(ExerciseType type) {
    isRunning = true;
    if (type == ExerciseType.pushUp) {
      _sensorService.startListening(onData: _pushUpCountLogic);
    }
    notifyListeners();
  }

  void stop() {
    isRunning = false;
    _sensorService.stopListening();
    count = 0;
    notifyListeners();
  }

  // 俯卧撑计数逻辑：检测Z轴峰值
  void _pushUpCountLogic(AccelerometerEvent event) {
    // 简单阈值法：Z轴大于某个值时计一次
    const double downThreshold = 7.0; // 向下最大值
    const double upThreshold = 9.8; // 静止/向上
    if (lastZ == null) {
      lastZ = event.z;
      return;
    }
    // 检测下压动作
    if (!_peakDetected && event.z < downThreshold) {
      _peakDetected = true;
    }
    // 检测回到上方，完成一次
    if (_peakDetected && event.z > upThreshold) {
      count++;
      _peakDetected = false;
      notifyListeners();
    }
    lastZ = event.z;
  }
}
