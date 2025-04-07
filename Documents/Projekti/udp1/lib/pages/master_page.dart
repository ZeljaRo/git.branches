import 'package:flutter/material.dart';
import '../services/udp_service.dart';

class MasterPage extends StatelessWidget {
  // maknuli smo const jer koristimo ne-const konstruktor unutar klase
  MasterPage({super.key});

  final UdpService udpService = UdpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MASTER - Odaberi pjesmu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                udpService.sendMessage('pjesma1.txt');
              },
              child: const Text('Pošalji pjesma1.txt'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                udpService.sendMessage('pjesma2.txt');
              },
              child: const Text('Pošalji pjesma2.txt'),
            ),
          ],
        ),
      ),
    );
  }
}
