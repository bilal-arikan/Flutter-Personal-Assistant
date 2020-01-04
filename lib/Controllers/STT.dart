
import 'package:speech_recognition/speech_recognition.dart';
//<uses-permission android:name="android.permission.RECORD_AUDIO" />

typedef void SpeechStarted();
typedef void SpeechResultChanged(String result);
typedef void SpeechEnded();

class STT{
  static SpeechRecognition _speechRecognition;
  static bool _isAvailable = false;
  static bool _isListening = false;
  static bool isListening() => _isListening;

  static String _deviceLocal = "tr_TR";

  static String currentSpeechResult;

  static SpeechStarted speechStarted;
  static SpeechResultChanged speechResultChanged;
  static SpeechEnded speechEnded;

  static init(){
     print("STT Initializing");
    
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setCurrentLocaleHandler(
      (String locale) => _deviceLocal = locale
    );

    _speechRecognition.setRecognitionStartedHandler(
      () { 
        _isListening = true;
        speechStarted();
        }
    );

    _speechRecognition.setRecognitionResultHandler(
      (result){
        currentSpeechResult = result;
        speechResultChanged(currentSpeechResult);
      }
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () { 
        _isListening = false;
        speechEnded();}
    );

    _speechRecognition.setAvailabilityHandler(  
      (bool result) { 
        _isAvailable = result;
        }
    );

    
    _speechRecognition.activate().then(
      (result) { 
        _isAvailable = result; 
      }
    );
  }

  /// Start
  static startListening(){
    /*if(!_isAvailable){
      return print("Not Available");
    }*/
    if(_isListening){
      return print("Already Listening");
    }
    _speechRecognition.listen(locale: _deviceLocal).then((result){
      print(result);
    });
  }
  //Stop
  static stopListening(){
    _speechRecognition.stop().then((result) {
      print(result);
    });
  }
  //Cancel
  static cancelListening(){
    _speechRecognition.cancel().then((result) {
      print(result);
    });
  }
}