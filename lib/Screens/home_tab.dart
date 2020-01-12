import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:virtual_store/extensions.dart';
import 'package:virtual_store/helpers/home_tab_helper.dart';
import 'package:virtual_store/data/trend_image.dart';

class HomeTab extends StatelessWidget {
  final Color _backgroundColor;

  HomeTab(this._backgroundColor);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildLinearGradient(
            _backgroundColor,
            Colors.white, //colorRGB(253, 181, 168),
            Alignment.topLeft,
            Alignment.bottomRight),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Trending"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<List<TrendImage>>(
              future: getTrendImages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else {
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data
                        .map((trendImg) =>
                            StaggeredTile.count(trendImg.x, trendImg.y))
                        .toList(),
                    children: snapshot.data
                        .map((trendImg) => FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: trendImg.imageUrl,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }
}
