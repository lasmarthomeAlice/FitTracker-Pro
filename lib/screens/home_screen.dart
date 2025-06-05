import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../widgets/exercise_card.dart';
import 'exercise_timer_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<ExerciseType> exerciseTypes = [
    ExerciseType.pullUp,
    ExerciseType.squat,
    ExerciseType.pushUp,
    ExerciseType.sitUp,
  ];

  final Map<ExerciseType, String> exerciseNames = {
    ExerciseType.pullUp: '单杠',
    ExerciseType.squat: '深蹲',
    ExerciseType.pushUp: '俯卧撑',
    ExerciseType.sitUp: '仰卧起坐',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择运动'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: exerciseTypes.length,
        itemBuilder: (context, index) {
          final type = exerciseTypes[index];
          return ExerciseCard(
            name: exerciseNames[type]!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExerciseTimerScreen(
                    exerciseType: type,
                    exerciseName: exerciseNames[type]!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
