import 'package:flutter/material.dart';
import 'package:newzzie/views/article_view.dart';

class NewsTile extends StatelessWidget {
  final String? imgUrl, title, desc, content, posturl;

  NewsTile(
      {this.imgUrl,
      this.desc,
      this.title,
      this.content,
      @required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      postUrl: posturl ?? "",
                    )));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        imgUrl ??
                            //placeholder network image
                            "https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    title ?? "",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc?? "",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
