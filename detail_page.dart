import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab5/domain/ProductReview.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../constant.dart';
import '../../domain/Review.dart';
import '../home/ProductController.dart';
import 'component/_build_app_bar.dart';


class ProductDetail extends StatefulWidget {
 /* Un "StatefulWidget" înseamnă că acest widget poate menține propria sa starea, sau datele,
  care pot fi modificate în timp. Acest lucru este în contrast cu un "stateless widget",
  care nu poate menține propria sa stare și se afișează mereu la fel, dat fiind aceleași date.
  Cuvantul cheie extends este utilizat pentru a indica faptul că această clasă este o subclasă
  a clasei StatefulWidget și, prin urmare, moștenește toate proprietățile și metodele acelei clase.
 Implementarea propriu-zisă a comportamentului și a aspectului widget-ului ar fi definite în cadrul clasei,
 utilizând metodele și proprietățile furnizate de către clasa StatefulWidget și orice alte clase relevante.*/
  ProductDetail({Key key, this.index}) : super(key: key);
  /*este o declarație de constructor pentru clasa "ProductDetail".
  Constructorul acceptă doi parametri: "Key key" este o cheie care este utilizată pentru identificarea unică
  a widget-ului în arborele de widget-uri. "this.index" este un parametru personalizat care poate fi utilizat
  pentru a stoca un index sau o altă informație relevantă pentru widget-ul ProductDetail.
  Urmatoarea instrucțiune " : super(key: key);" apelează constructorul din clasa de bază "StatefulWidget" și
  pasează cheia "key" ca parametru pentru a-l utiliza în clasa de bază. Acest constructor este utilizat pentru
  a inițializa și configura widget-ul ProductDetail, atribuind valori pentru parametrii săi și utilizând metodele
  din clasa de bază.*/
  int index;

  @override
  /* @override subliniază că funcția este definită și într-o clasă părinte, dar este redefinită pentru a face altceva în
     clasa curentă. De asemenea, este folosit pentru a adnota implementarea unei metode abstracte
     Recomandat deoarece îmbunătățește lizibilitatea (care poate fi citit cu ușurință) */
  State<ProductDetail> createState() => _ProductDetailState(index: this.index);
}

class _ProductDetailState extends State<ProductDetail> {
  _ProductDetailState({Key key, this.index});
  int index;
  ProductReview product;

  @override
  initState() {
    super.initState();
    final ProductController productController = Get.put(ProductController());
    productController.findOne(index).then((value) => {
      setState(() {
        product = value;
      })
    });
  }

  Future<void> fetchProduct(int index) async {
    final ProductController productController = Get.put(ProductController());
    product = await productController.findOne(index);
  }

  @override
  Widget build(BuildContext context) {
    //fetchProduct(widget.index);
    if (product == null) {
      return FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 1,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ),
          )
        ),
      );
    } else {
      return Scaffold(
        appBar: detailAppBar(product),
        body: SafeArea(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    product.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: sizeAndColor(product),
              ),
              Padding(padding: EdgeInsets.all(15),
                child: detailsSection(product),),
              // Padding(padding: EdgeInsets.all(15),
              //     child: reviewSection(product))
              Padding(padding: EdgeInsets.only(left: 15, right: 15),
              child: _staticText('Review', Colors.black, FontWeight.bold, 20)),
              const SizedBox(height: kSpace),
              Padding(padding: EdgeInsets.only(left: 15, right: 15),
              child: _staticText('Write your', kGreen, FontWeight.normal, 15)),
              const SizedBox(height: kSpace),
              reviewList(product.reviews),

            ],
          ),
        ),
        bottomNavigationBar: bottomAppBar(product),
      );
    }
  }

  BottomAppBar bottomAppBar(ProductReview product) {
    return BottomAppBar(
      color: Colors.white,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.primary),
        child: Row(
          children: [
            Container(height: 60,child: Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text('PRICE',
              style: TextStyle(
                color: kGrey
              ),),
              Padding(padding: EdgeInsets.only(top: 3),
                child: Text('\$ ${product.price}',
                  style: const TextStyle(
                      color: kGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),))
              ],
            ),
            ),),
            Spacer(),
            Container(height: 60,child: Padding(
              padding: EdgeInsets.only(right: 25, top: 10, bottom: 10),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    color: kGreen,
                  ),
                alignment: Alignment.center,
                width: 150,
                child: const Padding(padding: EdgeInsets.all(10),
                child: Text('ADD',
                  style: TextStyle(
                      color: Colors.white),
                ))
              ),
            ),)
          ],
        ),
      ),
    );
  }

  Column detailsSection(ProductReview productReview) {
    return Column(
      children: [
        _staticText('Details', Colors.black, FontWeight.bold, 20),
        const SizedBox(height: ksSpace),
        Text(
          product.details,
          textAlign: TextAlign.left,
          maxLines: 3,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15
          ),
        ),
        const SizedBox(height: kSpace),
        _staticText('Read More', kGreen, FontWeight.normal, 15),
      ],
    );
  }

  Expanded reviewList(List<Review> reviews) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: reviews.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: _test(reviews[index])
            )
          );
        },
      ),
    );
  }

  Row _singleReview(Review review) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.network(defaultPhoto),
        Column(
          children: [
            Row(
              children: [
                Text(review.first_name + review.last_name),
                Spacer(),
                _starRating(review.rating)
              ],
            ),
            Text(review.message)
          ],
        ),
      ],
    );
  }

  Stack _test(Review review) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(55),
          child: Image.network(defaultPhoto, height: 45, width: 45, ),
        ),
        Positioned(left: 70,
          width: 300,
          height: 20,child:
          Row(
            children: [
              //const SizedBox(width: 10),
              Text(review.first_name + review.last_name),
              Spacer(),
              _starRating(review.rating),
            ],
          ),
        ),
        Positioned(child: Text(review.message, textAlign: TextAlign.left,),
        left: 70,
        top: 30)
      ],
    );
  }

  SmoothStarRating _starRating(rating) {
      return SmoothStarRating(
          allowHalfRating: false,
          onRated: (v) {},
          starCount: rating,
          rating: rating.toDouble(),
          size: 20.0,
          isReadOnly: true,
          color: Colors.amberAccent,
          filledIconData: Icons.star,
          borderColor: Colors.amberAccent,
          spacing: 0.0);
  }

  Row _staticText(String text, Color color, FontWeight fontWeight, double size) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: fontWeight,
              fontSize: size,
              color: color
          ),
        ),
        Spacer()
      ],
    );
  }

  Row sizeAndColor(ProductReview product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 1,child: detailSize(product.size),),
        Expanded(flex: 1,child: detailColor(product.colour),),
      ],
    );
  }

  Padding detail(Padding row) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          //elevation: 0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(55),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10
                )
              ]
          ),
          child: GridTile(
              child: row
          ),
        )
    );
  }
  
  Padding detailSize(String size) {
    Row row = Row(
      children: [
        Text('Size',
        style: TextStyle(
          fontSize: 18
        )),
        Spacer(),
        Text((size.length > 14) ? 'Universal' : size)
      ],
    );
    Padding padding = Padding(padding: EdgeInsets.all(15),
    child: row);
    return detail(padding);
  }

  Padding detailColor(Color color) {
    Row row = Row(
      children: [
        Text('Color',
            style: TextStyle(
                fontSize: 18
            )),
        Spacer(),
        Icon(
          Icons.square_rounded,
          color: color,
        )
      ],
    );
    Padding padding = Padding(padding: EdgeInsets.all(15),
        child: row);
    return detail(padding);
  }


}
