import 'package:flutter/material.dart';
import 'recipe.dart';
import 'setting.dart';
import 'main.dart';
import 'lists.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  //String list
  List<String> _todoItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sous Chef')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(),
                  ),
                  maxLength: 30,
                ),
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
            _buildTodoList()
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed:
                _pushAddTodoScreen, // pressing this button now opens the new screen
            tooltip: 'Add task',
            child: Icon(Icons.add)),
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

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
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

  Widget _buildTodoList() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return ListTile(
        title: Text(todoText), onTap: () => _promptRemoveTodoItem(index));
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
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}
