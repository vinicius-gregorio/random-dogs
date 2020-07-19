import 'package:flutter/material.dart';
import 'package:random_dogs/dogs_breed.dart';
import 'main.dart';
import 'package:random_dogs/dogs.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:random_dogs/credits.dart';

class DogsByBreed extends StatefulWidget {
  @override
  _DogsByBreedState createState() => _DogsByBreedState();
}

class _DogsByBreedState extends State<DogsByBreed> {
  List<DogBreed> _breeds = DogBreed.getDogBreed();
  List<DropdownMenuItem<DogBreed>> _dropDownMenuItem;
  DogBreed _selectedBreed;
  String dogBreed = 'affenpinscher';
  Future<Dog> futureDog;

  @override
  void initState() {
    _dropDownMenuItem = buildDropDownMenuItem(_breeds);
    _selectedBreed = _dropDownMenuItem[0].value;
    super.initState();
    futureDog = fetchDog();
  }

  @override
  void setState(fn) {
    super.setState(fn);
    futureDog = fetchDog();
  }

  Future<Dog> fetchDog() async {
    final response =
        await http.get('https://dog.ceo/api/breed/$dogBreed/images/random');
    if (response.statusCode == 200) {
      print('$response.body');
      return Dog.fromJson(json.decode(response.body));
    } else {
      throw Exception('error');
    }
  }

  List<DropdownMenuItem<DogBreed>> buildDropDownMenuItem(List breeds) {
    List<DropdownMenuItem<DogBreed>> items = List();
    for (DogBreed dog in breeds) {
      items.add(DropdownMenuItem(
        value: dog,
        child: Text(dog.breedName),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4a3f35),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFff4301)),
        title: Text(
          'Random Dogs',
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
      body: Container(
        height: MediaQuery.of(context).size.height * .95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<Dog>(
                future: futureDog,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height * .4,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xFF4a3f35),
                      child: Image.network(
                        snapshot.data.message,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error : ${snapshot.error}');
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            DropdownButton(
                dropdownColor: Color(0xFF4a3f35),
                style: TextStyle(color: Color(0xFFfa7d09)),
                hint: Text(''),
                value: _selectedBreed,
                items: _dropDownMenuItem,
                onChanged: onChangedDropDownItem),
            //Text(_selectedBreed.breedName),
            SizedBox(
              height: 20,
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
      ),
    );
  }

  onChangedDropDownItem(DogBreed selectedBreed) {
    setState(() {
      _selectedBreed = selectedBreed;
      dogBreed = _selectedBreed.breedName.toString();
      fetchDog();
    });
  }
}
