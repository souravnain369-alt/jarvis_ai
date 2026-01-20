lib/main.drt
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const JarvisApp());
}

class JarvisApp extends StatefulWidget {
  const JarvisApp({super.key});

  @override
  State<JarvisApp> createState() => _JarvisAppState();
}

class _JarvisAppState extends State<JarvisApp> {
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();
  String text = "Hello, I am Jarvis. How can I help you?";

  void listen() async {
    bool available = await _speech.initialize();
    if (available) {
      await _speech.listen(onResult: (result) {
        setState(() {
          text = result.recognizedWords;
        });
        speak("You said $text");
      });
    }
  }

  void speak(String msg) async {
    await _tts.setLanguage("en-US");
    await _tts.speak(msg);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Jarvis AI")),
        body: Center(child: Text(text, style: const TextStyle(fontSize: 18))),
        floatingActionButton: FloatingActionButton(
          onPressed: listen,
          child: const Icon(Icons.mic),
        ),
      ),
    );
  }
}
