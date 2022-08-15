import 'package:flutter/material.dart';

class Science extends StatelessWidget {
  const Science({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            color: Colors.red
        ),
        child: Center(child: Text('hello'))
    );
  }
}
