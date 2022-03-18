
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_project/nasa_refactor/presentation/presentationPackages.dart';
import '../../data/dataPackages.dart';
import '../../domain/domainPackages.dart';

class NasaRefactorHome extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: PlanetListView(),
    );
  }
}

class PlanetListView extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return PlanetStateView();
  }
}

class PlanetStateView extends ConsumerState<PlanetListView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(planetStateProvider).getPlanetData();
  }
  @override
  Widget build(BuildContext context) {
    //
    final result = ref.watch(planetStateProvider);
    //

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("nasa today's pictures refactoring"),
      ),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return createListCell(context, result.planets.elementAt(index));
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
              );
            }, itemCount: result.planets.length)

    );
  }


  Widget createListCell(BuildContext context, Planet planet) {
    return Container(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(planet.title),
          ),
          Expanded(
              child: Text(planet.date)
          )
        ],
      ),
    );
  }

}