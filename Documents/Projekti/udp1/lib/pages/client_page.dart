import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/file_loader.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  String displayedText = 'Čekam poruku...';
  RawDatagramSocket? _socket;

  @override
  void initState() {
    super.initState();
    startListening();
  }

  void startListening() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210);
    _socket!.listen((event) async {
      if (event == RawSocketEvent.read) {
        Datagram? dg = _socket!.receive();
        if (dg != null) {
          String message = String.fromCharCodes(dg.data);
          debugPrint('Primljena poruka: $message');
          final content = await FileLoader.loadSongText(message);
          if (!mounted) return;
          setState(() {
            displayedText = content;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _socket?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KLIJENT - Prikaz pjesme')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            displayedText,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
