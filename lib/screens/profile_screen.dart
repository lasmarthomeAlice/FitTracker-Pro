import 'package:flutter/material.dart';
import '../models/health_data.dart';

class ProfileScreen extends StatelessWidget {
  final HealthData healthData;

  const ProfileScreen({Key? key, required this.healthData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户资料'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基本资料',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('身高: ${healthData.height ?? '未设置'} 厘米'),
            Text('体重: ${healthData.weight ?? '未设置'} 千克'),
            Text('血压: ${healthData.bloodPressure ?? '未设置'} mmHg'),
            Text('血氧: ${healthData.bloodOxygen ?? '未设置'} %'),
            Text('心率: ${healthData.heartRate ?? '未设置'} 次/分'),
            Text('体温: ${healthData.temperature ?? '未设置'} °C'),
            Text('血糖: ${healthData.bloodSugar ?? '未设置'} mmol/L'),
            const SizedBox(height: 24),
            const Text('病史',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (healthData.medicalHistory != null &&
                healthData.medicalHistory!.isNotEmpty)
              ...healthData.medicalHistory!.map((item) => Text(item))
            else
              const Text('无病史记录'),
          ],
        ),
      ),
    );
  }
}
