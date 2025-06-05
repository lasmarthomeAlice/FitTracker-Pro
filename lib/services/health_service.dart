import 'package:health/health.dart';
import '../models/health_data.dart';

class HealthService {
  final HealthFactory health = HealthFactory();

  // 请求健康数据权限
  Future<bool> requestAuthorization() async {
    final types = [
      HealthDataType.HEIGHT,
      HealthDataType.WEIGHT,
      HealthDataType.BLOOD_OXYGEN,
      HealthDataType.HEART_RATE,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.BODY_TEMPERATURE,
    ];

    try {
      return await health.requestAuthorization(types);
    } catch (e) {
      print('Error requesting health authorization: $e');
      return false;
    }
  }

  // 获取最新的健康数据
  Future<HealthData> getLatestHealthData() async {
    try {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      // 获取身高
      final height = await health.getLatestData(HealthDataType.HEIGHT);

      // 获取体重
      final weight = await health.getLatestData(HealthDataType.WEIGHT);

      // 获取血氧
      final bloodOxygen =
          await health.getLatestData(HealthDataType.BLOOD_OXYGEN);

      // 获取心率
      final heartRate = await health.getLatestData(HealthDataType.HEART_RATE);

      // 获取血压
      final bloodPressure =
          await health.getLatestData(HealthDataType.BLOOD_PRESSURE_SYSTOLIC);

      // 获取血糖
      final bloodSugar =
          await health.getLatestData(HealthDataType.BLOOD_GLUCOSE);

      // 获取体温
      final temperature =
          await health.getLatestData(HealthDataType.BODY_TEMPERATURE);

      return HealthData(
        height: height?.value as double?,
        weight: weight?.value as double?,
        bloodOxygen: bloodOxygen?.value as int?,
        heartRate: heartRate?.value as int?,
        bloodPressure: bloodPressure?.value as int?,
        bloodSugar: bloodSugar?.value as double?,
        temperature: temperature?.value as double?,
      );
    } catch (e) {
      print('Error getting health data: $e');
      return HealthData();
    }
  }

  // 获取特定时间段的健康数据
  Future<List<HealthDataPoint>> getHealthDataInRange(
    DateTime start,
    DateTime end,
    List<HealthDataType> types,
  ) async {
    try {
      return await health.getHealthDataFromTypes(start, end, types);
    } catch (e) {
      print('Error getting health data in range: $e');
      return [];
    }
  }
}
