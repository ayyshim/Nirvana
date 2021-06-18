import 'package:flutter/material.dart';
import 'package:nirvana/nirvana.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double beatFrequency = 50.0;
  double carrierFrequency = 450.0;
  double volume = 50;

  bool isPlaying = false;

  Nirvana nirvana = Nirvana();

  @override
  void initState() {
    super.initState();
    nirvana.setCarrierFrequency(carrierFrequency, isPlaying);
    nirvana.setBeatFrequency(beatFrequency, isPlaying);
    nirvana.setVolume(volume);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nirvana Test"),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            Text("Binaural Beat: $beatFrequency\Hz"),
            SizedBox(
              height: 12,
            ),
            Slider(
              value: beatFrequency,
              onChanged: (value) {
                beatFrequency = value.roundToDouble();
                setState(() {});
              },
              onChangeEnd: (_) {
                nirvana.setBeatFrequency(beatFrequency, isPlaying);
              },
              max: 100,
              min: 0,
            ),
            SizedBox(
              height: 12,
            ),
            Text("Carrier Frequency: $carrierFrequency\Hz"),
            SizedBox(
              height: 12,
            ),
            Slider(
              value: carrierFrequency,
              onChanged: (value) {
                carrierFrequency = value.roundToDouble();
                setState(() {});
              },
              onChangeEnd: (_) {
                nirvana.setCarrierFrequency(carrierFrequency, isPlaying);
              },
              max: 1000,
              min: 0,
            ),
            SizedBox(
              height: 12,
            ),
            Text("Volume: $volume"),
            SizedBox(
              height: 12,
            ),
            Slider(
              value: volume,
              onChanged: (value) {
                volume = value.roundToDouble();
                nirvana.setVolume(volume);
                setState(() {});
              },
              max: 100,
              min: 0,
              activeColor: Colors.deepOrange,
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (isPlaying) {
                    nirvana.stop();
                    isPlaying = false;
                  } else {
                    nirvana.play();
                    isPlaying = true;
                  }
                  setState(() {});
                },
                child: Text(isPlaying ? "Stop" : "Play"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
