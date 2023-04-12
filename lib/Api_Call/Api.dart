

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/quote_model.dart';

class ApiQuote{

  final String postsURL = "https://6411c6eb37c88aa434a151e5.mockapi.io/quotes/api/quotes";



  Future<List<QuoteModel>> fetchQuote() async {
    final response = await http
        .get(Uri.parse(postsURL));

    if (response.statusCode == 200) {

      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => QuoteModel.fromJson(data)).toList();
    } else {

      throw Exception('Failed to load album');
    }
  }
  }






