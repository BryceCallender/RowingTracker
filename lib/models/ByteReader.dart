import 'dart:typed_data';

class ByteReader {
  List<int> data;
  int index = 0;

  ByteReader(this.data);

  int readBytesAsInt(int length, { Endian endian = Endian.big }) {
    var byteData = getByteData(length);
    return byteData.getInt32(0, endian);
  }

  double readBytesAsDouble(int length, { Endian endian = Endian.big }) {
    var byteData = getByteData(length);
    return byteData.getFloat32(0, endian);
  }

  ByteData getByteData(int length) {
    var bytes = <int>[];

    for (; index < index + length; ++index) {
      bytes.add(data[index]);
    }

    var uintList = Uint8List.fromList(bytes);
    return ByteData.sublistView(uintList);
  }

  skip(int length) {

  }
}