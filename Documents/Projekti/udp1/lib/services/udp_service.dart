import 'dart:io';
import 'dart:typed_data';

class UdpService {
  final String broadcastAddress = '192.168.1.255';

  final int port = 4210;

  void sendMessage(String message) async {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
      socket.broadcastEnabled = true;
      final data = Uint8List.fromList(message.codeUnits);
      socket.send(data, InternetAddress(broadcastAddress), port);
      socket.close();
    });
  }
}
