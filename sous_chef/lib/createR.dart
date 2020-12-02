import 'package:flutter/material.dart';
import 'recipe.dart';
import 'setting.dart';
import 'main.dart';
import 'dart:math';
import 'list.dart';
import 'ListItem.dart';

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
        appBar: AppBar(
          actionsIconTheme:
              IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
          title: Text('Recipe'),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
              child: GestureDetector(
                  onTap: () {
                    //Navigaate and send to database
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Recipes()));
                  },
                  child: Icon(Icons.check)),
            )
          ],
        ),
        body: Scrollbar(
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder(),
                ),
                maxLength: 30,
              ),
              TextField(
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
              _buildTodoList(),
              RaisedButton(
                onPressed: _addTodoItem,
                child: Text('Add Item'),
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
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        return;
      }
    });
  }

  void _addTodoItem() {
    setState(() => ingredients.add(''));
  }

  void _removeTodoItem(int index) {
    setState(() => ingredients.removeAt(index));
  }

// Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Remove "${ingredients[index]}"?'),
              actions: <Widget>[
                FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                    child: Text('REMOVE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  Widget _buildTodoList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index < ingredients.length) {
          return _buildTodoItem(index);
        }
      },
    );
  }

  Widget _buildTodoItem(int index) {
    return ListItem(UniqueKey(), ingredients[index], '$index',
        (x) => ingredients[index] = x, () => _promptRemoveTodoItem(index));
  }
}
