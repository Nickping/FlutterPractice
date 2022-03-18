

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_project/counter/view/CounterSecondScreen.dart';
import '../provider/Counter.dart';

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      // home: CounterScreen(),
      // home:
      // MultiProvider(
      //   providers: [
      //     Provider(create: (context) => Counter(),)
      //   ],
      //   child: CounterScreen(),
      // ),


      // home : ChangeNotifierProvider(
      //   create: ((context) => Counter()),
      //   child: CounterScreen(),
      // ),

      home: CounterScreen(),
    );

  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Provider Practice'),
      ),
      // child: ChangeNotifierProvider(
      //   create: ((context) => Counter()),
      //   child: Center(
      //     child: CounterFirstScreen(),
      //   )
      // ),

          child: Center(
            child: CounterFirstScreen(),
          )

    );

  }
}

class CounterFirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Provider<Counter>(
    //   create: (context) => Counter(),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text('currentCount : ${context.watch().count}'),
    //       ElevatedButton(
    //           onPressed: () {
    //             Navigator.push(context,
    //                 CupertinoPageRoute(builder: (context) => CounterSecondScreen(),)
    //             );
    //           },
    //           child: Text('go to second')
    //       )
    //     ],
    //   )
    // );

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('currentCount : ${context.watch<Counter>().count}'),
          ElevatedButton(
              onPressed: () {
                MyClass();
                Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => CounterSecondScreen(),)
                );
              },
              child: Text('go to second')
          )
        ],
      );
  }
}