import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Simply email,password, login button box that will be used for login screen mock 
class MockLogin extends ConsumerStatefulWidget {
  const MockLogin({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MockLoginState();
}

class _MockLoginState extends ConsumerState<MockLogin> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('FloShift'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () {

              },
              child: Text('Login'),

            ),
          ],
        ),
      ),

    );
  }
}