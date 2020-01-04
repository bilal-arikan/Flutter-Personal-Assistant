
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frodit/Controllers/Brain/Frodit.dart';
import 'package:frodit/Controllers/STT.dart';
import 'package:frodit/Controllers/TTS.dart';
import 'package:frodit/Views/LeftDrawer.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {


  //String resultText = "";
  static final TextEditingController heardTxt = new TextEditingController();
  static final TextEditingController saidTxt = new TextEditingController();

  @override
  void initState() {
    super.initState();
    print("InitState");
    STT.init();
    STT.speechStarted = ()=> setState(updateState);
    STT.speechResultChanged = (speech) =>setState (()=> heardTxt.text = speech);
    STT.speechEnded = ()=> setState(updateState);

    TTS.init();
    TTS.speakingStarted = ()=> setState(updateState); 
    TTS.speakingEnded = ()=> setState(updateState);
    TTS.voicesParsed = (v)=> setState(()=>{});
    TTS.languagesParsed = (v)=> setState(()=>{});

    Frodit frodit = Frodit.instance();
  }

  void updateState(){
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //appBar: AppBar(
      //  title: new Text("Frodit"),
      //  ),
      drawer: Drawer(
        semanticLabel: "Settings",
        elevation: 20,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
              ),
              Text("Volume"),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.yellow,
                    child: Text("-"),
                    mini: true,
                    onPressed: ()=> setState((){
                      TTS.setVolume(TTS.getVolume() - 0.1);
                    })
                  ),
                  FittedBox(
                    child: Text(TTS.getVolume().toStringAsFixed(2)),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.yellow,
                    child: Text("+"),
                    mini: true,
                    onPressed: ()=> setState((){
                      TTS.setVolume(TTS.getVolume() + 0.1);
                    }),
                  )
                ],
              ),
              Text("Pitch"),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.orange,
                    child: Text("-"),
                    mini: true,
                    onPressed: ()=> setState((){
                      TTS.setPitch(TTS.getPitch() - 0.1);
                    })
                  ),
                  FittedBox(
                    child: Text(TTS.getPitch().toStringAsFixed(2)),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.orange,
                    child: Text("+"),
                    mini: true,
                    onPressed: ()=> setState((){
                      TTS.setPitch(TTS.getPitch() + 0.1);
                    }),
                  )
                ],
              ),
              Text("SpeechRate"),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Text("-"),
                    mini: true,
                    onPressed: ()=> setState((){
                      TTS.setSpeechRate(TTS.getSpeechRate() - 0.1);
                    })
                  ),
                  FittedBox(
                    child: Text(TTS.getSpeechRate().toStringAsFixed(2)),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Text("+"),
                    mini: true,
                    onPressed: ()=> setState((){
                      TTS.setSpeechRate(TTS.getSpeechRate() + 0.1);
                    }),
                  )
                ],
              ),
              Text("Speak Language"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PopupMenuButton<String>(
                    child: FloatingActionButton(
                        backgroundColor: Colors.purple,
                        child: Icon(Icons.language),
                      ),
                    onSelected: (String result) { TTS.setLanguage(result); },
                    elevation: 10,
                    itemBuilder: (s) => TTS.languages.map((dynamic v){
                      return PopupMenuItem<String>(
                        child: Text(v),
                        value: v,
                      );
                    }).toList(),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.purpleAccent,
                    child: Text("TR"),
                    onPressed: ()=>TTS.setLanguage("tr-tr-x-mfm-local"),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.purpleAccent,
                    child: Text("EN"),
                    onPressed: ()=>TTS.setLanguage("en-gb-x-gba-local"),
                  ),
                ],
              ),
            Text("Speak Voice"),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PopupMenuButton<String>(
                      child: FloatingActionButton(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.language),
                        ),
                      onSelected: (String result) { TTS.setVoice(result); },
                      elevation: 10,
                      itemBuilder: (s) => TTS.voices.map((dynamic v){
                        return PopupMenuItem<String>(
                          child: Text(v),
                          value: v,
                        );
                      }).toList(),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.lightBlue,
                    child: Text("TR"),
                    onPressed: ()=>TTS.setVoice("tr-tr-x-mfm-local"),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.lightBlue,
                    child: Text("EN"),
                    onPressed: ()=>TTS.setVoice("en-gb-x-gba-local"),
                  ),
                ],
              ),
            
            ],
          ),
        ) 
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTapDown: (tdd){
                    STT.startListening();
              },
              onTapUp: (tud){
                    STT.stopListening();
                    //STT.cancelListening();
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/697a515b9d.png"),
                    fit: BoxFit.cover,
                  )
                ),
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              alignment: Alignment.center,
              child: TextField(
                controller: heardTxt,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
                maxLines: null,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              alignment: Alignment.center,
              child: TextField(
                controller: heardTxt,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
                maxLines: null,
              ),
            ),
            FloatingActionButton(
              child: Icon(Icons.music_note),
              onPressed: () {
                TTS.speak(heardTxt.text);
              },
              backgroundColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}