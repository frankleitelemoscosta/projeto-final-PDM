import 'package:flutter/material.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Trabalho Final'), backgroundColor: Colors.blue,),
      body: TweenAnimationBuilder(
        duration: const Duration(),
        tween: Tween(),
        builder: (BuildContext context, dynamic value, Widget? child) {
          return Container(
            child: Center(
              child: Column(
                children: [],
              ),
            ),
          );
        },
      ),
    );
  }
}