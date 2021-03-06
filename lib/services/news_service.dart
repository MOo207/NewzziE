import 'package:http/http.dart' as http;
import 'package:newzzie/models/article.dart';
import 'dart:convert';

import 'package:newzzie/secret.dart';

class NewsService {
  List<Article> news = [];

  Future<List<Article>> getListOfNews() async {
    Uri url = Uri.parse(
        "http://newsapi.org/v2/top-headlines?country=eg&excludeDomains=stackoverflow.com&sortBy=publishedAt&apiKey=${apiKey}");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
    return news;
  }

  Future<void> getNews() async {
    Uri url = Uri.parse(
        "http://newsapi.org/v2/top-headlines?country=eg&excludeDomains=stackoverflow.com&sortBy=publishedAt&apiKey=${apiKey}");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

class NewsCategoryService {
  List<Article> news = [];

  Future<List<Article>> getNewsForCategory(String category) async {
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    Uri url = Uri.parse(
        "http://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=${apiKey}");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
    return news;
  }
}
