import 'package:flutter/material.dart';
import 'dart:math';
import 'setting.dart';
import 'createR.dart';
import 'list.dart';
import 'SpecRec.dart';
import 'home.dart';
import 'api.dart';

//Holds the list of recipes

class Recipes extends StatefulWidget {
  final Sous_ChefApi api = Sous_ChefApi();

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  bool loading = true;
  List recipe = [];
  @override
  void initState() {
    super.initState();
    widget.api.getRecipe().then((data) {
      setState(() {
        recipe = data;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cook Book'),
          leading: Container(),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scrollbar(
                child: ListView(
                children: [
                  ...recipe.map<Widget>((recipe) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(
                          recipe['recipes']['name'],
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SpecRec(
                                    recipe['recipes']['name'],
                                    recipe['recipes']['description'],
                                    recipe['recipes']['items']),
                              ));
                        },
                      )))
                ],
              )),
        floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                _showPopupMenu();
              },
              child: Transform.rotate(
                angle: 315 * pi / 180,
                child: Icon(
                  Icons.restaurant_menu,
                ),
              ),
              //elevation: 5.0,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            //elevation: 20.0,
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 75,
              color: Colors.grey[800],
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    color: Colors.white,
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    color: Colors.white,
                    padding: EdgeInsets.only(right: 28.0),
                    icon: Icon(Icons.list),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Lists()),
                      );
                    },
                  ),
                  IconButton(
                      iconSize: 30.0,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 28.0),
                      icon: Icon(Icons.auto_awesome_motion),
                      onPressed: () {}),
                  IconButton(
                    iconSize: 30.0,
                    color: Colors.white,
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Settings()),
                      );
                    },
                  )
                ],
              ),
            )));
  }

  _showPopupMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(0.0, 400.0, 0.0,
          0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(child: const Text('Create Recipe'), value: '1'),
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateR()),
        );
      }
    });
  }
}
