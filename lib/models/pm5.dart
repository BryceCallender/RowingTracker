import 'package:flutter_blue/flutter_blue.dart';
import 'package:rowing_tracker/models/ByteReader.dart';
import 'package:rowing_tracker/models/pm5-enums.dart';
import 'package:rowing_tracker/models/workoutdata.dart';
import 'dart:typed_data';

class PM5 {
  late Map<Guid, Function> characteristicInfo;
  final BluetoothDevice device;
  late WorkoutData workoutData;

  PM5(this.device) {
    characteristicInfo = {
      Guid("CE060031-43E5-11E4-916C-0800200C9A66") : readCharacteristic31,
      Guid("CE060032-43E5-11E4-916C-0800200C9A66") : readCharacteristic32,
      Guid("CE060033-43E5-11E4-916C-0800200C9A66") : readCharacteristic33
    };
  }

  setup() async {
    await device.connect();
    await discoverServices();
  }

  discoverServices() async {
    var services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristicInfo.containsKey(characteristic.uuid)) {
          listenToCharacteristic(characteristic);
        }
      }
    }
  }

  listenToCharacteristic(BluetoothCharacteristic characteristic) {
    characteristic.setNotifyValue(true);
    characteristic.value.listen((data) {
      readCharacteristic(characteristic.uuid, data);
    });
  }

  readCharacteristic(Guid guid, List<int> value) {
    var characteristic = characteristicInfo[guid];
    characteristic!(value);
  }

  readCharacteristic31(List<int> streamData) {
    var byteReader = ByteReader(streamData);

    var rowData = workoutData.data;
    if (rowData == null) {
      return;
    }

    double elapsedMilliseconds = byteReader.readBytesAsDouble(3, endian: Endian.little) * 0.001;
    rowData.distance = (byteReader.readBytesAsDouble(3, endian: Endian.little) * 0.1) as int;
    rowData.workoutType = byteReader.readBytesAsInt(1) as WorkoutType;
    rowData.intervalType = byteReader.readBytesAsInt(1) as IntervalType;
    rowData.workoutState = byteReader.readBytesAsInt(1) as WorkoutState;
    rowData.rowingState = byteReader.readBytesAsInt(1) as RowingState;
    rowData.strokeState = byteReader.readBytesAsInt(1) as StrokeState;
    byteReader.skip(3); // work distance ignore for now and just advance reader
    double workoutMilliseconds = byteReader.readBytesAsDouble(3, endian: Endian.little) * 0.001;
    rowData.dragFactor = byteReader.readBytesAsInt(1);

    rowData.elapsedTime = Duration(milliseconds: elapsedMilliseconds.toInt());
    rowData.workoutDuration = Duration(milliseconds: workoutMilliseconds.toInt());
  }

  readCharacteristic32(List<int> streamData) {
    var byteReader = ByteReader(streamData);

    var rowData = workoutData.data;
    if (rowData == null) {
      return;
    }

    byteReader.skip(3); //elapsed time already read in 31
    rowData.speed = byteReader.readBytesAsDouble(3, endian: Endian.little) * 0.001;
    rowData.strokeRate = byteReader.readBytesAsInt(1);
    int heartRate = byteReader.readBytesAsInt(1); //255 is invalid
    double currentPaceMilliseconds = byteReader.readBytesAsDouble(2, endian: Endian.little) * 0.001;
    double averagePaceMilliseconds = byteReader.readBytesAsDouble(2, endian: Endian.little) * 0.001;
    byteReader.skip(2); //rest distance, skip for now
    byteReader.skip(3); //rest time skip for now
    rowData.ergMachineType = byteReader.readBytesAsInt(1) as ErgMachineType;

    rowData.pace = Duration(milliseconds: currentPaceMilliseconds.toInt());
    rowData.averagePace = Duration(milliseconds: averagePaceMilliseconds.toInt());
    rowData.heartRate = heartRate == 255 ? -1 : heartRate;
  }

  readCharacteristic33(List<int> streamData) {
    var byteReader = ByteReader(streamData);
  }
}