import 'package:flutter/foundation.dart';

enum ExerciseType {
  pullUp,    // 单杠
  squat,     // 深蹲
  pushUp,    // 俯卧撑
  sitUp,     // 仰卧起坐
  // 可以继续添加更多运动类型
}

enum ExerciseMode {
  countBased,    // 按数量计时
  timeBased,     // 按时间计数
}

class Exercise {
  final String id;
  final String name;
  final ExerciseType type;
  final ExerciseMode mode;
  final int targetCount;    // 目标数量
  final int targetTime;     // 目标时间（秒）
  final bool useAutoCount;  // 是否使用自动计数

  Exercise({
    required this.id,
    required this.name,
    required this.type,
    required this.mode,
    required this.targetCount,
    required this.targetTime,
    this.useAutoCount = true,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      type: ExerciseType.values.firstWhere(
        (e) => e.toString() == 'ExerciseType.${json['type']}',
      ),
      mode: ExerciseMode.values.firstWhere(
        (e) => e.toString() == 'ExerciseMode.${json['mode']}',
      ),
      targetCount: json['targetCount'] as int,
      targetTime: json['targetTime'] as int,
      useAutoCount: json['useAutoCount'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.toString().split('.').last,
      'mode': mode.toString().split('.').last,
      'targetCount': targetCount,
      'targetTime': targetTime,
      'useAutoCount': useAutoCount,
    };
  }
} 