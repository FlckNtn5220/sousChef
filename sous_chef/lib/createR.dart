import 'package:flutter/material.dart';
import 'recipe.dart';
import 'setting.dart';
import 'main.dart';
import 'lists.dart';
import 'dart:math';
import 'createS.dart';

//This is where recipes are edited/deleted

class CreateR extends StatefulWidget {
  @override
  _CreateRState createState() => _CreateRState();
}

class _CreateRState extends State<CreateR> {
  //String list
  List<String> ingredients = [];
  final TextEditingController eCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Recipe')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder(),
                ),
                maxLength: 30,
              ),
            ),

            Container(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 30,
                minLines: 1,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  labelText: 'Description',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              padding: EdgeInsets.all(32.0),
            ),

            TextField(
              controller: eCtrl,
              onSubmitted: (text) {
                ingredients.add(text);
                eCtrl.clear();
                setState(() {});
              },
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: ingredients.length,
                    itemBuilder: (BuildContext ctxt, int Index) {
                      return Text(ingredients[Index]);
                    })),
            //_buildTodoList(),
            RaisedButton(
              onPressed: _pushAddTodoScreen,
              child: Text('Add Ingredient'),
            ),
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Recipes(),
                  ),
                );
              },
            ),
          ],
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
                          MaterialPageRoute(builder: (context) => MyApp()),
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

  _showPopupMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(0.0, 400.0, 0.0,
          0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(child: const Text('Create Recipe'), value: '1'),
        PopupMenuItem<String>(
            child: const Text('Create Shopping List'), value: '2'),
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        return;
      } else if (itemSelected == "2") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateS()),
        );
      }
    });
  }

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if (task.length > 0) {
      setState(() => ingredients.add(task));
    }
  }

  Widget _buildTodoList() {
    return TextField();
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
        // MaterialPageRoute will automatically animate the screen entry, as well
        // as adding a back button to close it
        MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(title: Text('Add a new task')),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: InputDecoration(
                hintText: 'Enter an ingredient',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}
