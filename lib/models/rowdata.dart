import 'package:rowing_tracker/models/pm5-enums.dart';

class RowData {
  int? distance;
  double? speed;
  Duration? pace;
  int? heartRate;
  int? dragFactor;
  int? driveTime;
  int? strokeCount;
  int? strokeRate;
  double? driveLength;
  int? averageForce;
  double? driveSpeed;
  int? peakForce;
  int? projectedDistance;
  int? split;
  Duration? averagePace;

  Duration? elapsedTime;
  Duration? workoutDuration;

  ErgMachineType? ergMachineType;
  WorkoutType? workoutType;
  IntervalType? intervalType;
  WorkoutState? workoutState;
  RowingState? rowingState;
  StrokeState? strokeState;
}