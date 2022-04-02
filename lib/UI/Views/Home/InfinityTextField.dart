import 'package:flutter/material.dart';

class InfinityTextField extends StatefulWidget {
  const InfinityTextField({Key? key}) : super(key: key);

  @override
  State<InfinityTextField> createState() => _InfinityTextFieldState();
}

class _InfinityTextFieldState extends State<InfinityTextField> {
  final List<TextEditingController> _controllers = [];
  final List<TextField> _fields = [];
  final List<IconButton> _buttons = [];

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Dynamic Text Field"),
          ),
          body: Column(
            children: [
              _addTile(),
              Expanded(child: _listView()),
              _okButton(),
            ],
          )),
    );
  }

  Widget _addTile() {
    return ListTile(
      title: const Icon(Icons.add),
      onTap: () {
        final controller = TextEditingController();
        final field = TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "name${_controllers.length + 1}",
          ),
        );
        final deleteButton = IconButton(
            onPressed: () {
              setState(() {
                _controllers.removeAt(_controllers.length - 1);
                _fields.removeAt(_fields.length - 1);
              });
            },
            icon: const Icon(Icons.clear));

        setState(() {
          _controllers.add(controller);
          _fields.add(field);
          _buttons.add(deleteButton);
        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
              width: MediaQuery.of(context).size.width * 0.80,
              child: _fields[index],
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width * 0.20) - 10,
              child: _buttons[index],
            ),
          ],
        );
      },
    );
  }

  Widget _okButton() {
    return ElevatedButton(
      onPressed: () async {
        String text = _controllers
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");
        final alert = AlertDialog(
          title: Text("Count: ${_controllers.length}"),
          content: Text(text.trim()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
        await showDialog(
          context: context,
          builder: (BuildContext context) => alert,
        );
        setState(() {});
      },
      child: const Text("OK"),
    );
  }
}
