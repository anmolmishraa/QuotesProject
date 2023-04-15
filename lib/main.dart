import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import 'package:swipe_to/swipe_to.dart';

import 'Api_Call/Api.dart';
import 'favscreen.dart';
import 'model/quote_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final box = GetStorage();
  late Future<List<QuoteModel>> futureQuote;
  @override
  void initState() {
    super.initState();
    futureQuote = ApiQuote().fetchQuote();
  }

  String quoteText = "";
  String tagText = "";
  String authorText = "";
  String id = "";
  List<QuoteModel> totalID = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<QuoteModel>>(
          future: futureQuote,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return SwipeTo(
                                // iconOnRightSwipe: Icons.add_circle,
                                // iconOnLeftSwipe: Icons.remove_circle,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    height: 250,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          tagText == ""
                                              ? snapshot.data![0].tag.toString()
                                              : tagText,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          quoteText == ""
                                              ? snapshot.data![0].quotes
                                                  .toString()
                                              : quoteText,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                totalID.add(
                                                  QuoteModel(
                                                    authorName: authorText == ""
                                                        ? snapshot
                                                            .data![0].authorName
                                                            .toString()
                                                        : authorText,
                                                    id: id == ""
                                                        ? snapshot.data![1].id
                                                            .toString()
                                                        : id,
                                                    quotes: quoteText == ""
                                                        ? snapshot
                                                            .data![0].quotes
                                                            .toString()
                                                        : quoteText,
                                                    tag: tagText == ""
                                                        ? snapshot.data![0].tag
                                                            .toString()
                                                        : tagText,
                                                  ),
                                                );
                                                box.write('favoriteList', totalID
                                                );


                                                setState(() {});

                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Successfully, added to Favorite Quotes",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                ),
                                                child: Text(
                                                  "Add to Fav",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              authorText == ""
                                                  ? '- ${snapshot.data![0].authorName}'
                                                  : '- ${authorText}',
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
                                ),
                                onLeftSwipe: () {
                                  setState(() {
                                    index -= 1;
                                    quoteText =
                                        snapshot.data![index].quotes.toString();
                                    tagText =
                                        snapshot.data![index].tag.toString();
                                    authorText = snapshot
                                        .data![index].authorName
                                        .toString();

                                    id = id == ""
                                        ? snapshot.data![0].id.toString()
                                        : snapshot.data![index].id.toString();
                                    print(id);
                                    print("left");
                                  });
                                  ApiQuote().fetchQuote();
                                },
                                onRightSwipe: () {
                                  setState(() {
                                    index += 1;
                                    quoteText =
                                        snapshot.data![index].quotes.toString();
                                    tagText =
                                        snapshot.data![index].tag.toString();
                                    authorText = snapshot
                                        .data![index].authorName
                                        .toString();
                                    id = id == ""
                                        ? snapshot.data![0].id.toString()
                                        : snapshot.data![index].id.toString();
                                    print(id);
                                    print("right");
                                  });

                                  ApiQuote().fetchQuote();
                                  // printTasks();
                                  print("<<<<<<<<<<<<<<<${totalID.length}");
                                });
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FavScreen(
                                 // totalID: totalID

                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          child: Text(
                            "Show Favorite Quotes",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            // By default show a loading spinner.
            return Center(child: const CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
