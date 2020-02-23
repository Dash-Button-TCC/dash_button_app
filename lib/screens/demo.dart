import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:dash_button_app/main.dart';
import 'package:dash_button_app/widgets/syles.dart';
import 'package:dash_button_app/util/demo_data.dart';
import 'package:dash_button_app/widgets/rounded_shadow.dart';
import 'package:dash_button_app/widgets/product_card.dart';

class DemoProductsList extends StatefulWidget {
  @override
  _DemoProductsListState createState() => _DemoProductsListState();
}

class _DemoProductsListState extends State<DemoProductsList> {
  double _listPadding = 20;
  ProductData _selectedProduct;
  // ScrollController _scrollController = ScrollController();
  List<ProductData>_products;
  int _earnedPoints;

  @override
  void initState() {
    var demoData = DemoData();
    _products = demoData.products;
    _earnedPoints = demoData.earnedPoints;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).size.aspectRatio > 1;
    double headerHeight = MediaQuery.of(context).size.height * (isLandscape? .25 : .2);

    return loadItens(headerHeight);

  }

  Widget loadItens(double headerHeight)
  {
    return ListView.builder(
      // padding: EdgeInsets.only(bottom: 40, top: headerHeight + 10),
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _products.length,
      scrollDirection: Axis.vertical,
      // controller: _scrollController,
      itemBuilder: (context, index) => _buildListItem(index),
    );
  }

  Widget _buildListItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: _listPadding / 2, horizontal: _listPadding),
      child: ProductListCard(
        earnedPoints: _earnedPoints,
        productData: _products[index],
        isOpen: _products[index] == _selectedProduct,
        onTap: _handleProductTapped,
      ),
    );
  }

  Widget _buildTopBg(double height) {
    return Container(
      alignment: Alignment.topCenter,
      height: height,
      child: RoundedShadow(
          topLeftRadius: 0,
          topRightRadius: 0,
          shadowColor: Color(0x0).withAlpha(65),
          child: Container(
            width: double.infinity,
            child: Image.asset("images/Header-Dark.png", fit: BoxFit.fill, package: MyApp.pkg,),
          )),
    );
  }

  Widget _buildTopContent(double height) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.all(height * .08),
          constraints: BoxConstraints(maxHeight: height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("My Rewards", style: Styles.text(height * .13, Colors.white, true)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star, color: AppColors.redAccent, size: height * .2),
                  SizedBox(width: 8),
                  Text("$_earnedPoints", style: Styles.text(height * .3, Colors.white, true)),
                ],
              ),
              Text("Your Points Balance", style: Styles.text(height * .1, Colors.white, false)),
            ],
          ),
        ),
      ),
    );
  }

  void _handleProductTapped(ProductData data) {
    setState(() {
      //If the same product was tapped twice, un-select it
      if (_selectedProduct == data) {
        _selectedProduct = null;
      }
      //Open tapped product card and scroll to it
      else {
        _selectedProduct = data;
        var selectedIndex = _products.indexOf(_selectedProduct);
        var closedHeight = ProductListCard.nominalHeightClosed;
        //Calculate scrollTo offset, subtract a bit so we don't end up perfectly at the top
        var offset = selectedIndex * (closedHeight + _listPadding) - closedHeight * .35;
        // _scrollController.animateTo(offset, duration: Duration(milliseconds: 700), curve: Curves.easeOutQuad);
      }
    });
  }
}
