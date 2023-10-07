import 'package:flutter/material.dart';

class RadioBottom extends StatefulWidget {
  final void Function(String?) cambiar;

  RadioBottom({Key? key, required this.cambiar}) : super(key: key);

  @override
  State<RadioBottom> createState() => _RadioBottomState();
}

class _RadioBottomState extends State<RadioBottom> {
  String? _character = 'Amarillo';

  Widget RadioButton(String txt){
    return ListTile(
      title: Text(txt),
          leading: Radio<String>(
            value: txt,
            groupValue: _character,
            onChanged: (String? value) {
              setState(() {
                _character = value;
                widget.cambiar(value);
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioButton('Amarillo'),
        RadioButton('Azul'),
        RadioButton('Rojo'),
        RadioButton('Verde'),
        RadioButton('Naranja'),
      ],
    );
  }
}