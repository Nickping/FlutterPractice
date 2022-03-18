
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_project/nasa/view/planet_screen.dart';

import '../provider/Counter.dart';

class CounterSecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: BaseBackButton(
              title: 'back'
          ),
        ),
        // child: ChangeNotifierProvider(
        //   create: ((context) => Counter()),
        //   child: SecondScreenContainer()
        // )
      child: SecondScreenContainer(),

    );

  }
}

class SecondScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var counter = context.watch<Counter>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Container(
          height: 40,
          // padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
          child: Text('second screen'),
        ),
        Container(
          child: Text('current Count : ${context.watch<Counter>().count}'),
        ),
        Container(
          child: ElevatedButton(
              child: Text('increse'),
            onPressed: () {
                var testClass = MyClass();
                testClass();
              context.read<Counter>().increse();
            },
          )
        ),
        Container(
            child: ElevatedButton(
              child: Text('decrease'),
              onPressed: () {
                context.read<Counter>().decrease();
              },
            )
        ),
        Spacer()
      ],
    );
  }
}