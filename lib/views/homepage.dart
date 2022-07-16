import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newzzie/helper/data.dart';
import 'package:newzzie/services/news_service.dart';
import 'package:newzzie/widgets/widgets.dart';
import 'package:newzzie/models/article.dart';
import 'package:newzzie/models/categorie_model.dart';
import 'package:newzzie/services/auth_service.dart';
import 'package:newzzie/views/categorie_news.dart';
import 'package:newzzie/views/login_view.dart';
import 'package:newzzie/views/settings_view.dart';
import 'package:newzzie/widgets/news_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';  
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategorieModel>? categories = <CategorieModel>[];
  Future<List<Article>>? _newsFuture;
  NewsService news = NewsService();
  User? currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!;
    categories = getCategories();
    _newsFuture = news.getListOfNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, true),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("NewzziE User"),
                accountEmail: Text(currentUser!.email.toString()),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.home),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.settings),
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsView()));
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.sign_out),
                leading: Icon(Icons.logout),
                onTap: () async {
                  Navigator.pop(context);
                  AuthService auth = AuthService();
                  await auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(milliseconds: 400)); 
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    /// Categories
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 70,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories?.length,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              imageAssetUrl: categories![index].imageAssetUrl,
                              categoryName: categories![index].categorieName,
                            );
                          }),
                    ),

                    /// NewsService Article
                    FutureBuilder<List<Article>>(
                        future: _newsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 16),
                                      child: ListView.builder(
                                          itemCount: snapshot.data?.length,
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return NewsTile(
                                              imgUrl: snapshot
                                                      .data?[index].urlToImage ??
                                                  "",
                                              title:
                                                  snapshot.data?[index].title ??
                                                      "",
                                              desc: snapshot.data?[index]
                                                      .description ??
                                                  "",
                                              content: snapshot
                                                      .data?[index].content ??
                                                  "",
                                              posturl: snapshot
                                                      .data?[index].articleUrl ??
                                                  "",
                                            );
                                          }),
                                    );
                                  }),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class CategoryCard extends StatelessWidget {
  final String? imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      newsCategory: categoryName?.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl.toString(),
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26),
              child: Text(
                categoryName.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
