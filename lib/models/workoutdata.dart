import 'rowdata.dart';

class WorkoutData {
  DateTime workoutDate = DateTime.now();
  Duration? duration;
  RowData? data;
  List<RowData> snapshots = [];

  void addSnapshot(RowData data) {
    snapshots.add(data);
  }
}