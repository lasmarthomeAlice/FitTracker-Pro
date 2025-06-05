import 'package:flutter/foundation.dart';
import 'exercise.dart';

class ExerciseRecord {
  final String id;
  final String exerciseId;
  final DateTime startTime;
  final DateTime? endTime;
  final int count;
  final int duration; // 持续时间（秒）
  final bool isCompleted;
  final Map<String, dynamic>? healthData; // 运动时的健康数据

  ExerciseRecord({
    required this.id,
    required this.exerciseId,
    required this.startTime,
    this.endTime,
    required this.count,
    required this.duration,
    this.isCompleted = false,
    this.healthData,
  });

  factory ExerciseRecord.fromJson(Map<String, dynamic> json) {
    return ExerciseRecord(
      id: json['id'] as String,
      exerciseId: json['exerciseId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'] as String)
          : null,
      count: json['count'] as int,
      duration: json['duration'] as int,
      isCompleted: json['isCompleted'] as bool,
      healthData: json['healthData'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exerciseId': exerciseId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'count': count,
      'duration': duration,
      'isCompleted': isCompleted,
      'healthData': healthData,
    };
  }

  ExerciseRecord copyWith({
    String? id,
    String? exerciseId,
    DateTime? startTime,
    DateTime? endTime,
    int? count,
    int? duration,
    bool? isCompleted,
    Map<String, dynamic>? healthData,
  }) {
    return ExerciseRecord(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      count: count ?? this.count,
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
      healthData: healthData ?? this.healthData,
    );
  }
}
