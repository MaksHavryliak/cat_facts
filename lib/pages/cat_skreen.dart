import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import '../services/cat_service.dart';
import 'saved_facts_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _catFact = '';
  String _catImageUrl = '';
  String _randomDate = '';
  final CatService _catService = CatService();

  @override
  void initState() {
    super.initState();
    _fetchCatData();
  }

  Future<void> _fetchCatData() async {
    final fact = await _catService.fetchCatFact();
    final imageUrl = _catService.generateImageUrl();
    final randomDate = _catService.generateRandomDate();

    setState(() {
      _catFact = fact;
      _catImageUrl = imageUrl;
      _randomDate = randomDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Facts', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color.fromARGB(225, 11, 21, 59),
        actions: [
          IconButton(
            icon: Icon(Icons.watch_later, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedFactsPage()),
              );
            },
          ),
        ],
      ),
      body: _catFact.isEmpty || _catImageUrl.isEmpty
          ? Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.white,
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.white,
            ),
          ],
        ),
      )
          : Center(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: _catImageUrl,
              width: 300,
              height: 300,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(_catFact),
                  SizedBox(height: 10),
                  Text('Дата: $_randomDate'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _fetchCatData,
              child: Text('Ще один факт'),
            ),
            ElevatedButton(
              onPressed: () {
                final box = Hive.box('catFacts');
                box.add('$_catFact (Дата: $_randomDate)');
                Fluttertoast.showToast(
                  msg: "Факт збережено!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              },
              child: Text('Подобається'),
            ),
          ],
        ),
      ),
    );
  }
}