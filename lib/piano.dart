import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

import 'piano_key.dart';

class Piano extends StatefulWidget {
  const Piano({Key? key}) : super(key: key);

  @override
  _PianoState createState() => _PianoState();
}

class _PianoState extends State<Piano> {
  final FlutterMidi flutterMidi = FlutterMidi();

  final octaveNumber = 3;

  get octaveStartingNote => (octaveNumber * 12) % 128;

  Future<void> _setupMIDIPlugin() async {
    flutterMidi.unmute();
    ByteData byte = await rootBundle.load("assets/piano.sf2");
    flutterMidi.prepare(sf2: byte);
  }

  _buildWhiteKeys(double whiteKeySize) {
    return Row(
      children: [
        PianoKey.white(
          width: whiteKeySize,
          midiNote: octaveStartingNote,
          flutterMidi: flutterMidi,
        ),
        PianoKey.white(
          width: whiteKeySize,
          midiNote: octaveStartingNote + 2,
          flutterMidi: flutterMidi,
        ),
        PianoKey.white(
          width: whiteKeySize,
          midiNote: octaveStartingNote + 4,
          flutterMidi: flutterMidi,
        ),
        PianoKey.white(
          width: whiteKeySize,
          midiNote: octaveStartingNote + 5,
          flutterMidi: flutterMidi,
        ),
        PianoKey.white(
          width: whiteKeySize,
          midiNote: octaveStartingNote + 7,
          flutterMidi: flutterMidi,
        ),
        PianoKey.white(
          width: whiteKeySize,
          midiNote: octaveStartingNote + 9,
          flutterMidi: flutterMidi,
        ),
        PianoKey.white(
          width: whiteKeySize,
          midiNote: octaveStartingNote + 11,
          flutterMidi: flutterMidi,
        )
      ],
    );
  }

  _buildBlackKeys(double pianoHeight, double blackKeySize, double whiteKeySize) {
    return Container(
      height: pianoHeight * 0.55,
      child: Row(
        children: [
          SizedBox(
            width: whiteKeySize - blackKeySize / 2,
          ),
          PianoKey.black(
            width: blackKeySize,
            midiNote: octaveStartingNote + 1,
            flutterMidi: flutterMidi,
          ),
          SizedBox(
            width: whiteKeySize - blackKeySize,
          ),
          PianoKey.black(
            width: blackKeySize,
            midiNote: octaveStartingNote + 3,
            flutterMidi: flutterMidi,
          ),
          SizedBox(
            width: whiteKeySize,
          ),
          SizedBox(
            width: whiteKeySize - blackKeySize,
          ),
          PianoKey.black(
            width: blackKeySize,
            midiNote: octaveStartingNote + 6,
            flutterMidi: flutterMidi,
          ),
          SizedBox(
            width: whiteKeySize - blackKeySize,
          ),
          PianoKey.black(
            width: blackKeySize,
            midiNote: octaveStartingNote + 8,
            flutterMidi: flutterMidi,
          ),
          SizedBox(
            width: whiteKeySize - blackKeySize,
          ),
          PianoKey.black(
            width: blackKeySize,
            midiNote: octaveStartingNote + 10,
            flutterMidi: flutterMidi,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _setupMIDIPlugin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final whiteKeySize = constraints.maxWidth / 7;
        final blackKeySize = whiteKeySize / 2;
        return Stack(
          children: [
            _buildWhiteKeys(whiteKeySize),
            _buildBlackKeys(constraints.maxHeight, blackKeySize, whiteKeySize),
          ],
        );
      },
    );
  }
}
