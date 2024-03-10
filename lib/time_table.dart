import 'package:flutter/material.dart';

class GridListExample extends StatefulWidget {
  const GridListExample({super.key});

  @override
  State<GridListExample> createState() => _GridListExampleState();
}

class _GridListExampleState extends State<GridListExample> {
  @override
  Widget build(BuildContext context) {
    int rowCount = 100;
    int columnCount = 30;
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Name $index'),
                );
              },
            ),
          ),
          Expanded(
            flex: 20,
            child: GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columnCount,
              ),
              itemCount: columnCount * rowCount,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Name $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}