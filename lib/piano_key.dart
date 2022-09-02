import 'package:flutter/material.dart';
import 'package:flutter_midi/flutter_midi.dart';

enum KeyColor { white, black }

class PianoKey extends StatelessWidget {
  final KeyColor color;
  final double width;
  final int midiNote;
  final FlutterMidi flutterMidi;

  const PianoKey.white({
    super.key,
    required this.width,
    required this.midiNote,
    required this.flutterMidi,
  }) : color = KeyColor.white;

  const PianoKey.black({
    super.key,
    required this.width,
    required this.midiNote,
    required this.flutterMidi,
  }) : color = KeyColor.black;

  /// Send a NOTE ON message
  playNote() {
    flutterMidi.playMidiNote(midi: midiNote);
  }

  /// Send a NOTE OFF message
  stopNote() {
    flutterMidi.stopMidiNote(midi: midiNote);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => playNote(),
      onTapUp: (_) => stopNote(),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: color == KeyColor.white ? Colors.white : Colors.black,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
      ),
    );
  }
}
