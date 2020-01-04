
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'DecisionMaker.dart';

class Frodit{

  static Frodit _singleton;
  static Frodit instance(){
    if(_singleton == null)
      _singleton =  new Frodit._internal();
    return _singleton;
  }


  factory Frodit() => _singleton;

  IO.Socket socket;
  DecisionMaker decider;

  Frodit._internal()
  {
    print("Frodit Instantiated");
    //initSockeySystem();
    decider = new DecisionMaker();
  }

  void initSockeySystem(){

    socket = IO.io('http://192.168.1.37:8080');
    socket.on('connect', (_) {
      print('connected');
      //socket.emit('msg', '{"key":"test"}');
    });
    socket.on('connect_failed', (err) => print(err));
    socket.on('event', (data) => print(data));
    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    socket.connect();
    print('connecting...');
  }

  Future<String> send(String str) async{

  }

}