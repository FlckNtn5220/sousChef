import 'package:flutter/material.dart';
import 'recipe.dart';
import 'dart:math';
import 'setting.dart';
import 'createR.dart';
import 'ListItem.dart';
import 'home.dart';
import 'api.dart';

//This is where shopping lists are edited/deleted

class Lists extends StatefulWidget {
  final Sous_ChefApi api = Sous_ChefApi();
  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  //String list
  bool loading = true;
  List<String> _todoItems = [];
  @override
  void initState() {
    super.initState();
    widget.api.getRecipe().then((data) {
      setState(() {
        print(_todoItems[0]);
        loading = false;
      });
    });
  }

  final TextEditingController eCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List'),
          leading: Container(),
        ),
        body: Scrollbar(
          child: ListView(
            children: [
              _buildTodoList(),
              RaisedButton(
                onPressed: _addTodoItem,
                child: Text('Add Item'),
              ),
              IconButton(
                icon: Icon(
                  Icons.cancel_rounded,
                  color: Colors.blue,
                ),
                onPressed: () {
                  _promptClearTodoList();
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
      } else if (itemSelected == "2") {
        return;
      }
    });
  }

  // This will be called each time the add item button is pressed
  void _addTodoItem() {
    setState(() => _todoItems.add(''));
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

// Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Remove "${_todoItems[index]}"?'),
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

  void _promptClearTodoList() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: Text('Clear list?'), actions: <Widget>[
            FlatButton(
                child: Text('CANCEL'),
                onPressed: () => Navigator.of(context).pop()),
            FlatButton(
                child: Text('CLEAR'),
                onPressed: () {
                  setState(() {
                    _todoItems.clear();
                  });
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
        if (index < _todoItems.length) {
          return _buildTodoItem(index);
        }
      },
    );
  }

  Widget _buildTodoItem(int index) {
    return ListItem(UniqueKey(), _todoItems[index], '$index',
        (x) => _todoItems[index] = x, () => _promptRemoveTodoItem(index));
  }
}
