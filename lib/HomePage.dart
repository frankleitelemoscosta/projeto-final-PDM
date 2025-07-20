import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trabalho Final'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      return;
                    },
                    child: Text('Open your contacts'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      return;
                    },
                    child: Text('Add a new contact'),
                  ),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*TweenAnimationBuilder(
        duration: const Duration(),
        tween: Tween(begin: Accumulator(0),end: Accumulator(0)),
        builder: (BuildContext context, dynamic value, Widget? child) {
          return Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Center(
              child: Column(
                children: [
                  Text('teste')
                ],
              ),
            ),
          );
        },
      ),*/
