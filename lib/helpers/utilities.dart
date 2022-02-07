import 'dart:typed_data';

class Utilities {
  static double readBytes(List<int> data, int start, int length, { Endian endian = Endian.big }) {
    var bytes = Uint8List.fromList(data.skip(start).take(length).toList());
    ByteData byteData = ByteData.sublistView(bytes);
    return byteData.getFloat32(0, endian);
  }
}