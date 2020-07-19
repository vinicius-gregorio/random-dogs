import 'package:flutter/material.dart';
import 'package:random_dogs/main.dart';
import 'package:random_dogs/dogs_by_breed.dart';

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4a3f35),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFff4301)),
        title: Text(
          'Credits',
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
          padding: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'images/dog.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  'image by Charles Deluvio',
                  style: TextStyle(color: Color(0Xfffa7d09)),
                ),
                trailing: Text(
                  '@charlesdeluvio',
                  style: TextStyle(color: Color(0xFFff4301)),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'images/dog_icon.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  'Icon made by Freepik',
                  style: TextStyle(color: Color(0Xfffa7d09)),
                ),
                trailing: Text(
                  'flaticon.com',
                  style: TextStyle(color: Color(0xFFff4301)),
                ),
              ),
            ],
          )),
    );
  }
}
