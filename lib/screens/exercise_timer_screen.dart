import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/exercise.dart';
import '../providers/exercise_provider.dart';

class ExerciseTimerScreen extends StatefulWidget {
  final ExerciseType exerciseType;
  final String exerciseName;

  const ExerciseTimerScreen({
    Key? key,
    required this.exerciseType,
    required this.exerciseName,
  }) : super(key: key);

  @override
  State<ExerciseTimerScreen> createState() => _ExerciseTimerScreenState();
}

class _ExerciseTimerScreenState extends State<ExerciseTimerScreen> {
  bool isRunning = false;
  bool isPaused = false;
  int seconds = 60; // 默认倒计时60秒
  late int remainingSeconds;
  late Stopwatch stopwatch;

  @override
  void initState() {
    super.initState();
    remainingSeconds = seconds;
    stopwatch = Stopwatch();
  }

  void start() {
    setState(() {
      isRunning = true;
      isPaused = false;
      stopwatch.start();
      Provider.of<ExerciseProvider>(context, listen: false)
          .start(widget.exerciseType);
      _tick();
    });
  }

  void pause() {
    setState(() {
      isPaused = true;
      stopwatch.stop();
      Provider.of<ExerciseProvider>(context, listen: false).pause();
    });
  }

  void resume() {
    setState(() {
      isPaused = false;
      stopwatch.start();
      Provider.of<ExerciseProvider>(context, listen: false)
          .resume(widget.exerciseType);
      _tick();
    });
  }

  void stop() {
    setState(() {
      isRunning = false;
      isPaused = false;
      stopwatch.reset();
      remainingSeconds = seconds;
      Provider.of<ExerciseProvider>(context, listen: false).stop();
    });
  }

  void _tick() async {
    while (isRunning && !isPaused && remainingSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        remainingSeconds--;
      });
      if (remainingSeconds == 0) {
        stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exerciseName),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<ExerciseProvider>(
          builder: (context, provider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '剩余时间: $remainingSeconds 秒',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 24),
                Text(
                  '当前计数: ${provider.count}',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 32),
                if (!isRunning)
                  ElevatedButton(
                    onPressed: start,
                    child: const Text('开始'),
                  ),
                if (isRunning && !isPaused)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: pause,
                        child: const Text('暂停'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: stop,
                        child: const Text('终止'),
                      ),
                    ],
                  ),
                if (isPaused)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: resume,
                        child: const Text('继续'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: stop,
                        child: const Text('终止'),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
