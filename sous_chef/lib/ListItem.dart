import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  final UniqueKey key;
  final String initialValue;
  final String index;
  final Function(String x) onUpdate;
  final Function() onRemove;
  ListItem(
      this.key, this.initialValue, this.index, this.onUpdate, this.onRemove);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  TextEditingController _controller;

  //connect API
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        key: widget.key,
        title: TextField(
          controller: _controller,
          onChanged: (String value) async {
            widget.onUpdate(value);
          },
        ),
        trailing: IconButton(
            icon: Icon(Icons.cancel_rounded),
            onPressed: () {
              widget.onRemove();
            }));
  }
}
