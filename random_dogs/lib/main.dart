import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_dogs/credits.dart';
import 'package:random_dogs/dogs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:random_dogs/dogs_by_breed.dart';

Future<Dog> fetchDog() async {
  final response = await http.get('https://dog.ceo/api/breeds/image/random');
  if (response.statusCode == 200) {
    print('$response.body');
    return Dog.fromJson(json.decode(response.body));
  } else {
    throw Exception('error');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Dogs',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
      home: MyHomePage(title: 'Random Dogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Dog> futureDog;

  @override
  void initState() {
    super.initState();
    futureDog = fetchDog();
    print('fetch run');
  }

  @override
  void setState(fn) {
    super.setState(fn);
    futureDog = fetchDog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4a3f35),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFff4301)),
        title: Text(
          widget.title,
          style: TextStyle(color: Color(0xFFff4301)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF2f2519),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(0xFF4a3f35)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFFCE020C)),
                    child: Container(
                      child: Image.asset(
                        'images/dog.jpg',
                        fit: BoxFit.cover,
                      ),
                    )),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                    //Navigator.pop(context);
                  },
                  title: Text(
                    'Random dogs',
                    style: TextStyle(color: Color(0xFFff4301)),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DogsByBreed()));
                  },
                  title: Text('Dogs by breed',
                      style: TextStyle(color: Color(0xFFff4301))),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreditsPage()));
                  },
                  title: Text('Credits',
                      style: TextStyle(color: Color(0xFFff4301))),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<Dog>(
                  future: futureDog,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          child: Image.network(
                        snapshot.data.message,
                        fit: BoxFit.cover,
                      ));
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(child: CircularProgressIndicator());
                  })),
          Container(
            color: Color(0xFF4a3f35),
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                fetchDog();
              });
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.3),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      'images/dog_icon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Press for dogs !',
                    style: TextStyle(color: Color(0xFFfa7d09)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
