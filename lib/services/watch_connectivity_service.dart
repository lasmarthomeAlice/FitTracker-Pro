import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/exercise.dart';
import '../models/exercise_record.dart';
import '../models/health_data.dart';

class WatchConnectivityService {
  static final WatchConnectivityService _instance =
      WatchConnectivityService._internal();
  factory WatchConnectivityService() => _instance;
  WatchConnectivityService._internal();

  // 通信通道
  static const platform = MethodChannel('com.fittracker.watch');

  // 状态监听
  final _connectionStateController = StreamController<bool>.broadcast();
  Stream<bool> get connectionState => _connectionStateController.stream;

  // 运动数据监听
  final _exerciseDataController = StreamController<ExerciseRecord>.broadcast();
  Stream<ExerciseRecord> get exerciseData => _exerciseDataController.stream;

  // 健康数据监听
  final _healthDataController = StreamController<HealthData>.broadcast();
  Stream<HealthData> get healthData => _healthDataController.stream;

  // 初始化
  Future<void> initialize() async {
    try {
      // 设置方法调用处理器
      platform.setMethodCallHandler((call) async {
        switch (call.method) {
          case 'onConnectionStateChanged':
            _connectionStateController.add(call.arguments as bool);
            break;
          case 'onExerciseDataReceived':
            final data = jsonDecode(call.arguments as String);
            _exerciseDataController.add(ExerciseRecord.fromJson(data));
            break;
          case 'onHealthDataReceived':
            final data = jsonDecode(call.arguments as String);
            _healthDataController.add(HealthData.fromJson(data));
            break;
        }
      });

      // 初始化 watchOS 连接
      await platform.invokeMethod('initialize');
    } catch (e) {
      debugPrint('Watch connectivity initialization failed: $e');
    }
  }

  // 发送运动数据到 watchOS
  Future<void> sendExerciseData(ExerciseRecord record) async {
    try {
      await platform.invokeMethod('sendExerciseData', {
        'data': jsonEncode(record.toJson()),
      });
    } catch (e) {
      debugPrint('Failed to send exercise data: $e');
    }
  }

  // 发送健康数据到 watchOS
  Future<void> sendHealthData(HealthData data) async {
    try {
      await platform.invokeMethod('sendHealthData', {
        'data': jsonEncode(data.toJson()),
      });
    } catch (e) {
      debugPrint('Failed to send health data: $e');
    }
  }

  // 发送运动类型到 watchOS
  Future<void> sendExerciseType(ExerciseType type) async {
    try {
      await platform.invokeMethod('sendExerciseType', {
        'type': type.toString().split('.').last,
      });
    } catch (e) {
      debugPrint('Failed to send exercise type: $e');
    }
  }

  // 发送控制命令到 watchOS
  Future<void> sendControlCommand(String command) async {
    try {
      await platform.invokeMethod('sendControlCommand', {
        'command': command,
      });
    } catch (e) {
      debugPrint('Failed to send control command: $e');
    }
  }

  // 释放资源
  void dispose() {
    _connectionStateController.close();
    _exerciseDataController.close();
    _healthDataController.close();
  }
}
