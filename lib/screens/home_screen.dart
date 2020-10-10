import 'package:clippy_flutter/arc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendsepisode/model/episode.dart';
import 'package:friendsepisode/networking/networking.dart';
import 'package:swipedetector/swipedetector.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _seasonNumber;
  int _episodeNumber;
  Map _map = Map();

  int _getRandomNumber(int min, int max) {
    Random r = new Random();
    int randomNumber = r.nextInt(max - min + 1) + min;
    return randomNumber;
  }

  void _initMap() {
    _map[1] = 24;
    _map[2] = 24;
    _map[3] = 25;
    _map[4] = 24;
    _map[5] = 24;
    _map[6] = 25;
    _map[7] = 24;
    _map[8] = 24;
    _map[9] = 24;
    _map[10] = 18;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _initMap();
      _seasonNumber = _getRandomNumber(1, 10);
      _episodeNumber = _getRandomNumber(1, _map[_seasonNumber]);
      print('season $_seasonNumber');
      print('episode $_episodeNumber');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FutureBuilder<Episode>(
          future: NetworkHelper.fetchEpisode(
              http.Client(), _seasonNumber, _episodeNumber),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            Episode _episode = snapshot.data;
            return snapshot.hasData
                ? SwipeDetector(
                    onSwipeLeft: () {
                      print((_episode.voteAverage * 5) / 10);
                      setState(() {
                        _seasonNumber = _getRandomNumber(1, 10);
                        _episodeNumber =
                            _getRandomNumber(1, _map[_seasonNumber]);
                        print('season $_seasonNumber');
                        print('episode $_episodeNumber');
                      });
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Arc(
                              edge: Edge.BOTTOM,
                              arcType: ArcType.CONVEX,
                              height: 45.0,
                              clipShadows: [
                                ClipShadow(color: Colors.grey, elevation: 15),
                              ],
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 2,
                                child: Image.network(
                                  'http://image.tmdb.org/t/p/original/${_episode.stillPath}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 3.0),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      (_episode.name).toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: 'Varela',
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      ('Season ${_episode.seasonNumber} Episode ${_episode.episodeNumber}')
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: 'Varela', fontSize: 18.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: RatingBarIndicator(
                                        rating: (_episode.voteAverage * 5) / 10,
                                        unratedColor: Colors.black,
                                        itemSize: 25.0,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.pink,
                                        ),
                                        direction: Axis.horizontal,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _episode.overview,
                                      style: TextStyle(
                                        fontFamily: 'Varela',
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: SpinKitWave(
                      color: Colors.grey,
                      size: 60.0,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
