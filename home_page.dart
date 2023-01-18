
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:lab5/domain/ProductE.dart';
import 'package:lab5/presentation/home/CategoryController.dart';
import 'package:lab5/presentation/home/ProductController.dart';

import '../../constant.dart';
import '../../domain/Category.dart';
import '../details/detail_page.dart';
import 'components/_build_category_card.dart';
import 'components/_categories.dart';
import 'components/_product_category.dart';

class HomePage extends StatefulWidget {
  /* clasa HomePage moștenește clasa StatelessWidget
   extends = moștenire: principiu OOP ce reprezintă posibilitatea de a prelua
   funcționalitatea existentă într-o clasă și de a adăuga una nouă sau de
   a o modela pe cea existentă
   StatelessWidget = widget fără stare care descrie o parte a interfeței cu  utilizatorul
   prin construirea unei constelații de alte widget-uri care descriu interfața cu utilizatorul
   widget = descrie configurația pentru un element. Un widget este descrierea unei părți a unei interfețe cu utilizatorul */
  const HomePage({Key key}) : super(key: key);
/* constructorul HomePage folosește o cheie ca parametru. Cheile sunt cele care păstrează starea widget-urilor.
     super = exact ca this cuvântul cheie care indică clasa părinte
     odată ce folosim moștenirea cu extends constructorul clasei copil va fi executat după executarea constructorului părintelui */

  @override
  /* @override subliniază că funcția este definită și într-o clasă părinte, dar este redefinită pentru a face altceva în
     clasa curentă. De asemenea, este folosit pentru a adnota implementarea unei metode abstracte
     Recomandat deoarece îmbunătățește lizibilitatea (care poate fi citit cu ușurință) */
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //listele goale pentru produse si categorii
  List<ProductE> productList = [];
  List<Category> categoryList = [];
  int _pageNumber;
  bool _loading;
  bool _isLastPage = false;
  int _pageSize = 10;
  int _lastTotalItems = 0;
  ScrollController _scrollController;

  //future - asteptam un raspuns dar nu stim daca va veni
  //async await pentru ca anuntam intentia de a primi un raspuns
  //se initializeaza controlerele
  //din fisierul json /assets/shop.json fiecare controller citeste lista de categorii si lista de produse
  //returneaza controllerele aceste liste catre initialfetch
  //!important set state permite schimbarea starii acestor liste goale si popularea lor
  Future<void> initialFetch() async {
    //final - final este un modificator de non-acces folosit pentru clase, atribute si metode, ceea ce le face neschimbate,
    // singura diferenta dintre final si const este ca const face ca variabila constanta numai in timpul de compilare
    final ProductController productController = Get.put(ProductController());
    final CategoryController categoryController = Get.put(CategoryController());
    List<Category> listCategoryFromRequest = await categoryController.query(1);
    List<ProductE> listProductsFromRequest = await productController.query(_pageNumber);
    setState(() {
      _isLastPage = listProductsFromRequest.length < _pageSize;
      categoryList.addAll(listCategoryFromRequest);
      productList.addAll(listProductsFromRequest);
      _loading = false;
      _pageNumber += 1;
    });
  }

  Future<void> fetchData() async {
    _loading = true;
    final ProductController productController = Get.put(ProductController());
    List<ProductE> listProductsFromRequest = await productController.query(_pageNumber);
    _lastTotalItems = productList.length;
    setState(() {
      _isLastPage = listProductsFromRequest.length < _pageSize;
      productList.addAll(listProductsFromRequest);
      _loading = false;
      _pageNumber += 1;
      print(_lastTotalItems);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo((_lastTotalItems + (_pageNumber - 1))/2*210, duration: const Duration(microseconds: 1), curve: Curves.ease);
      });
      //print(_scrollController.offset);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageNumber = 1;
    productList = [];
    _loading = true;
    initialFetch();
    _scrollController = ScrollController(initialScrollOffset: 5.0, keepScrollOffset: true)..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    //var productsE = Res.fetchProducts();
    //initialFetch();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: detailBody(categoryList, context),
        ),
      ),
    );
  }

  Column detailBody(List<Category> categories, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        section('Categories', ''),
        const SizedBox(height: kSpace),
        Container(
          height: 120,
          child: category(categories),
        ),
        const SizedBox(height: kSpace),
        section('Best Selling', 'See all'),
        const SizedBox(height: kSpace),
        Expanded(
            child: mostPopularCategory(context))
      ],
    );
  }

  Widget mostPopularCategory(context) {
    if (_loading) {
      return const Center(
        child: Padding(padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),),
      );
    }
    return GridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      childAspectRatio: 0.62,
      physics: const AlwaysScrollableScrollPhysics(),
      children: List.generate(productList.length, (index) {
        /*if ((index == productList.length - _nextPageTrigger) && !_isLastPage) {
          print('fetch $index');
          fetchData();
        }*/
        return GestureDetector(
          onTap: () => Get.to(() => ProductDetail(index: productList[index].id)),
          child: buildCard(productList[index]),
        );
      }),
    );
  }
  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        print("comes to bottom $_loading");
        if (!_isLastPage) {
          _loading = true;
          if (_loading) {
            print("RUNNING LOAD MORE");
            fetchData();
            //print(_scrollController.offset);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
