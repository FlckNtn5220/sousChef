import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';

class CreateUser extends StatefulWidget {
  @override
  CreateUserState createState() => CreateUserState();
}

class CreateUserState extends State<CreateUser> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final TextEditingController _usercontroller = new TextEditingController();
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usernameField = TextField(
      controller: _usercontroller,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: _controller,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField2 = TextField(
      controller: _controller2,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final doneButon = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.green,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            print(_usercontroller.text);
            print(_controller.text);
            //TODO create condition if username is taken
            _controller.text != _controller2.text || _controller.text == null
                ? _promptWrongPass()
                : _usercontroller.text == null //TODO || username is taken
                    ? _promptUserTaken()
                    : Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
          },
          child: Text("Done!",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ));

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 45.0),
                usernameField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                passwordField2,
                SizedBox(
                  height: 35.0,
                ),
                doneButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usercontroller.dispose();
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _promptWrongPass() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Password did not match the confirmation password'),
              actions: <Widget>[
                FlatButton(
                    child: Text('RETRY'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  void _promptUserTaken() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Username has already been taken or was left blank'),
              actions: <Widget>[
                FlatButton(
                    child: Text('RETRY'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}
