import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'model/quote_model.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({
    Key? key,

    // required this.totalID
  }) : super(key: key);
  // final List<QuoteModel> totalID;

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<QuoteModel> favoriteCard = [];

  final box = GetStorage();
  @override
  void initState() {
    favoriteCard = box.read('favoriteList');
    final ids = favoriteCard.map((e) => e.id).toSet();

    print(ids);
    favoriteCard.retainWhere((x) => ids.remove(x.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Quotes"),
      ),
      body: SafeArea(
        child: favoriteCard.length == 0
            ? Center(
                child: Text("No favorite quotes found"),
              )
            : ListView.builder(
                itemCount: favoriteCard.length,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                itemBuilder: (BuildContext context, index) {
                  var data = favoriteCard[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            data.tag ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            data.quotes ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox.shrink(),
                              Text(
                                data.authorName ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
