import 'package:flutter/material.dart';
import 'package:virtual_store/data/store.dart';
import 'package:virtual_store/helpers/stores_tab_helper.dart';
import 'package:virtual_store/tiles/store_tile.dart';

class StoresTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Store>>(
      future: getStores(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasData) {
              return ListView(
                children:
                    snapshot.data.map((store) => StoreTile(store)).toList(),
              );
            } else {
              return Container();
            }
        }
      },
    );
  }
}
