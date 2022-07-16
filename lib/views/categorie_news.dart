import 'package:flutter/material.dart';
import 'package:newzzie/models/article.dart';
import 'package:newzzie/services/news_service.dart';
import 'package:newzzie/widgets/news_tile.dart';
import 'package:newzzie/widgets/widgets.dart';

class CategoryNews extends StatefulWidget {

  final String? newsCategory;

  CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  NewsCategoryService news = NewsCategoryService();
 Future<List<Article>>? _newsCategoryFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newsCategoryFuture = news.getNewsForCategory(widget.newsCategory.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, true),
      body:SingleChildScrollView(
        child: Container(
            child: Container(
              margin: EdgeInsets.only(top: 16),
              child: FutureBuilder<List<Article>>(
                future: _newsCategoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imgUrl: snapshot.data![index].urlToImage ?? "",
                          title: snapshot.data![index].title ?? "",
                          desc: snapshot.data![index].description ?? "",
                          content: snapshot.data![index].content ?? "",
                          posturl: snapshot.data![index].articleUrl ?? "",
                        );
                      });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
            ),
        ),
      ),
    );
  }
}
