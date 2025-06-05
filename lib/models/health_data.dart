import 'package:flutter/foundation.dart';

class HealthData {
  final double? height; // 身高（厘米）
  final double? weight; // 体重（千克）
  final int? bloodPressure; // 血压（收缩压）
  final int? bloodOxygen; // 血氧饱和度（%）
  final int? heartRate; // 心率（次/分）
  final List<String>? medicalHistory; // 病史
  final double? temperature; // 体温（摄氏度）
  final double? bloodSugar; // 血糖（mmol/L）

  HealthData({
    this.height,
    this.weight,
    this.bloodPressure,
    this.bloodOxygen,
    this.heartRate,
    this.medicalHistory,
    this.temperature,
    this.bloodSugar,
  });

  factory HealthData.fromJson(Map<String, dynamic> json) {
    return HealthData(
      height: json['height'] as double?,
      weight: json['weight'] as double?,
      bloodPressure: json['bloodPressure'] as int?,
      bloodOxygen: json['bloodOxygen'] as int?,
      heartRate: json['heartRate'] as int?,
      medicalHistory:
          (json['medicalHistory'] as List<dynamic>?)?.cast<String>(),
      temperature: json['temperature'] as double?,
      bloodSugar: json['bloodSugar'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
      'bloodPressure': bloodPressure,
      'bloodOxygen': bloodOxygen,
      'heartRate': heartRate,
      'medicalHistory': medicalHistory,
      'temperature': temperature,
      'bloodSugar': bloodSugar,
    };
  }

  HealthData copyWith({
    double? height,
    double? weight,
    int? bloodPressure,
    int? bloodOxygen,
    int? heartRate,
    List<String>? medicalHistory,
    double? temperature,
    double? bloodSugar,
  }) {
    return HealthData(
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      bloodOxygen: bloodOxygen ?? this.bloodOxygen,
      heartRate: heartRate ?? this.heartRate,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      temperature: temperature ?? this.temperature,
      bloodSugar: bloodSugar ?? this.bloodSugar,
    );
  }
}
