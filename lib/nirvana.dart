
import 'dart:async';

import 'package:flutter/services.dart';

class Nirvana {
  MethodChannel _channel;


   Nirvana() {
     _channel = MethodChannel('nirvana');
   }

   Future<void> setCarrierFrequency(double frequency, bool isPlaying) async {
     print("Hello carrier");
    await _channel.invokeMethod("setCarrierFrequency", {"carrierFrequency": frequency, "isPlaying": isPlaying});
  }

   Future<void> setBeatFrequency(double frequency, bool isPlaying) async {
    await _channel.invokeMethod("setBeatFrequency", {"beatFrequency": frequency, "isPlaying": isPlaying});
  }

   Future setVolume(double volume) async {
    await _channel.invokeMethod("setVolume", {"volume": volume});

  }

   Future play() async {
    await _channel.invokeMethod("play");
  }

   Future stop() async {
    await _channel.invokeMethod("stop");
  }

}
