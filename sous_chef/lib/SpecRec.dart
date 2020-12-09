import 'package:flutter/material.dart';
import 'recipe.dart';
import 'createR.dart';
import 'setting.dart';
import 'home.dart';
import 'dart:math';
import 'list.dart';

class SpecRec extends StatefulWidget {
  //final String title;
  //final String directions;
  //final List<dynamic> ingredients;
  //SpecRec(this.title, this.directions, this.ingredients);

  @override
  _SpecRecState createState() => _SpecRecState();
}

class _SpecRecState extends State<SpecRec> {
  //String list
  List<dynamic> ingredients = [
    'Peanut butter (Smooth)',
    'Jelly',
    'Bread'
  ]; //Use DB to fill this

  final TextEditingController eCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //ingredients = widget.ingredients;
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          actionsIconTheme:
              IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
          //title: Text(widget.title),
          title: Text('Simple PB+J'),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
              child: GestureDetector(
                  onTap: () {
                    //Navigate to create recipe page with info about recipe
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateR()));
                  },
                  child: Icon(Icons.edit)),
            )
          ],
        ),
        body: Scrollbar(
          child: ListView(
            children: [
              //Call API to fill out information
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                    child:
                        Text('Directions', style: TextStyle(fontSize: 25.0))),
              ),
              SizedBox(height: 10.0),
              //Text(widget.directions),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                    'Spread PB on one slice of bread and jelly on another then put them together and enjoy.'),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Ingredients',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ingredients.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ListTile(
                        title: Text(ingredients[index]),
                        trailing: IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.blue,
                            onPressed: () {
                              _promptAddIngredient(ingredients[index]);
                              //Add ingredient to list
                            }));
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: RaisedButton(
                  onPressed: () {
                    _promptAddAllIngredient();
                  },
                  child: Text('Add All Ingredients'),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.cancel_rounded,
                  color: Colors.blue,
                ),
                onPressed: () {
                  _promptRemoveRecipe();
                },
              ),
            ],
          ),
        ),
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
                      }),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Recipes()),
                      );
                    },
                  ),
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

  void _promptAddAllIngredient() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Add all ingredients to shopping list?'),
              actions: <Widget>[
                FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                    child: Text('ADD'),
                    onPressed: () {
                      //Adds all ingredient to shopping list in DB
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  void _promptAddIngredient(String ingredient) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Add "$ingredient" to shopping list?'),
              actions: <Widget>[
                FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                    child: Text('ADD'),
                    onPressed: () {
                      //Adds ingredient to shopping list in DB
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  void _promptRemoveRecipe() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Delete "$widget.title"?'),
              actions: <Widget>[
                FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                    child: Text('REMOVE'),
                    onPressed: () {
                      _removeRecipe();
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  void _removeRecipe() {
    //Take recipe out of DB
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Recipes(),
      ),
    );
  }

  _showPopupMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(0.0, 500.0, 0.0,
          0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(child: const Text('Create Recipe'), value: '1'),
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        return;
      }
    });
  }
}
