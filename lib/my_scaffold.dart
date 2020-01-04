import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text('My Fancy Dress'),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.playlist_play),
            tooltip: 'Air it',
            onPressed: ()=> debugPrint("air_it"),
          ),
          IconButton(
            icon: Icon(Icons.playlist_add),
            tooltip: 'Restitch it',
            onPressed:()=> debugPrint("Restitch_it"),
          ),
          IconButton(
            icon: Icon(Icons.playlist_add_check),
            tooltip: 'Repair it',
            onPressed: ()=> debugPrint("Repair_it"),
          ),
        ],
      ),
      body: new Center(
        child: new Text("Hello Scaf"),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: Colors.yellow,
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.archive),
            title: new Text("Arc"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.adjust),
            title: new Text("ADJ"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.high_quality),
            title: new Text("Hq"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.high_quality),
            title: new Text("Hq2"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.high_quality),
            title: new Text("Hq3"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.high_quality),
            title: new Text("Hq3"),
          ),
        ],
        onTap: (int i) => debugPrint(i.toString()),
      ),
      drawer: new Drawer(
        child: new ListTile(
          leading: Icon(Icons.airline_seat_individual_suite),
          title: new Text("ŞĞ;İÇÜ"),
          onTap: () {
            Navigator.pop(context);
            
          },
        )
      ),
    );
  }

}