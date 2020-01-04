
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

typedef void VoicesParsed(List<dynamic> voices);
typedef void LanguagesParsed(List<dynamic> langs);
typedef void SpeakingStarted();
typedef void SpeakingEnded();

class TTS{
  static FlutterTts flutterTts = new FlutterTts();
  static bool _isSpeaking = false;
  static bool isSpeaking() => _isSpeaking;

  static SpeakingStarted speakingStarted;
  static SpeakingEnded speakingEnded;
  static VoicesParsed voicesParsed;
  static LanguagesParsed languagesParsed;

  static List<dynamic> languages;
  static List<dynamic> voices;

  static setLanguage(String lang) => flutterTts.setLanguage(lang).catchError((e) => print(e));
  static isLanguageAvailable(String lang) => flutterTts.isLanguageAvailable(lang).catchError((e) => print(e));
  static setVoice(String voice) => flutterTts.setVoice(voice).catchError((e) => print(e)); //"tr-tr-x-mfm-local"

  static double _speechRate = 1.0;
  static double _volume = 1.0;
  static double _pitch = 1.0;
  static double getSpeechRate() => _speechRate;
  static double getVolume() => _volume;
  static double getPitch() => _pitch;
  static setSpeechRate(double v) => flutterTts.setSpeechRate(v.clamp(0.0, 1.0)).then((dyn)=> _speechRate = v.clamp(0.0, 1.0)).catchError((e) => print(e));
  static setVolume(double v) => flutterTts.setVolume(v.clamp(0.0,1.0)).then((dyn)=> _volume = v.clamp(0.0,1.0)).catchError((e) => print(e));
  static setPitch(double v) => flutterTts.setPitch(v.clamp(0.5,2.0)).then((dyn)=> _pitch = v.clamp(0.5,2.0)).catchError((e) => print(e));


  static void init(){
    flutterTts.getLanguages.then((result)=> languages = result).then((r) => languagesParsed(languages));//.then((l)=>print(languages));
    flutterTts.getVoices.then((result)=> voices = result).then((r) => voicesParsed(voices));//.then((l)=>debugPrint(voices.toString(),wrapWidth:20));

    setLanguage("tr_TR");

    flutterTts.setStartHandler((){
      _isSpeaking = true;
      speakingStarted();
    });
    flutterTts.setCompletionHandler((){
      _isSpeaking = false;
      speakingEnded();
    });
    flutterTts.setErrorHandler((err){
      print(err);
      _isSpeaking = false;
      speakingEnded();
    });
  }

  static Future speak(String str){
    return flutterTts.speak(str).catchError((e)=>print(e));
  }

  static Future stop(){
    return flutterTts.stop().catchError((e)=>print(e));;
  }
}