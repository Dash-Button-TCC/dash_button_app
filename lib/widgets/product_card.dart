import 'dart:math';
import 'package:flutter/material.dart';

import 'package:dash_button_app/main.dart';
import 'liquid_painter.dart';
import 'rounded_shadow.dart';
import 'syles.dart';
import 'package:dash_button_app/util/demo_data.dart';

class ProductListCard extends StatefulWidget {
  static double nominalHeightClosed = 96;
  static double nominalHeightOpen = 240;

  final Function(ProductData) onTap;

  final bool isOpen;
  final ProductData productData;
  final int earnedPoints;

  const ProductListCard({Key key, this.productData, this.onTap, this.isOpen = false, this.earnedPoints = 100}) : super(key: key);

  @override
  _ProductListCardState createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> with TickerProviderStateMixin {
  bool _wasOpen;
  Animation<double> _fillTween;
  Animation<double> _pointsTween;
  AnimationController _liquidSimController;

  //Create 2 simulations, that will be passed to the LiquidPainter to be drawn.
  LiquidSimulation _liquidSim1 = LiquidSimulation();
  LiquidSimulation _liquidSim2 = LiquidSimulation();

  @override
  void initState() {
    //Create a controller to drive the "fill" animations
    _liquidSimController = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    _liquidSimController.addListener(_rebuildIfOpen);
    //create tween to raise the fill level of the card
    _fillTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _liquidSimController, curve: Interval(.12, .45, curve: Curves.easeOut)),
    );
    //create tween to animate the 'points remaining' text
    _pointsTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _liquidSimController, curve: Interval(.1, .5, curve: Curves.easeOutQuart)),
    );
    super.initState();
  }

  @override
  void dispose() {
    _liquidSimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //If our open state has changed...
    if (widget.isOpen != _wasOpen) {
      //Kickoff the fill animations if we're opening up
      if (widget.isOpen) {
        //Start both of the liquid simulations, they will initialize to random values
        _liquidSim1.start(_liquidSimController, true);
        _liquidSim2.start(_liquidSimController, false);
        //Run the animation controller, kicking off all tweens
        _liquidSimController.forward(from: 0);
      }
      _wasOpen = widget.isOpen;
    }

    //Determine the points required text value, using the _pointsTween
    var pointsRequired = widget.productData.requiredPoints;
    var pointsValue = pointsRequired - _pointsTween.value * min(widget.earnedPoints, pointsRequired);
    //Determine current fill level, based on _fillTween
    double _maxFillLevel = min(1, widget.earnedPoints / widget.productData.requiredPoints);
    double fillLevel = _maxFillLevel; //_maxFillLevel * _fillTween.value;
    double cardHeight = widget.isOpen ? ProductListCard.nominalHeightOpen : ProductListCard.nominalHeightClosed;

    return GestureDetector(
      onTap: _handleTap,
      //Use an animated container so we can easily animate our widget height
      child: AnimatedContainer(
        curve: !_wasOpen ? ElasticOutCurve(.9) : Curves.elasticOut,
        duration: Duration(milliseconds: !_wasOpen ? 1200 : 1500),
        height: cardHeight,
        //Wrap content in a rounded shadow widget, so it will be rounded on the corners but also have a drop shadow
        child: RoundedShadow.fromRadius(
          12,
          child: Container(
            color: Color(0xff303238),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                //Background liquid layer
                AnimatedOpacity(
                  opacity: widget.isOpen ? 1 : 0,
                  duration: Duration(milliseconds: 500),
                  child: _buildLiquidBackground(_maxFillLevel, fillLevel),
                ),

                //Card Content
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  //Wrap content in a ScrollView, so there's no errors on over scroll.
                  child: SingleChildScrollView(
                    //We don't actually want the scrollview to scroll, disable it.
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        //Top Header Row
                        _buildTopContent(),
                        //Spacer
                        SizedBox(height: 12),
                        //Bottom Content, use AnimatedOpacity to fade
                        AnimatedOpacity(
                          duration: Duration(milliseconds: widget.isOpen ? 1000 : 500),
                          curve: Curves.easeOut,
                          opacity: widget.isOpen ? 1 : 0,
                          //Bottom Content
                          child: _buildBottomContent(pointsValue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack _buildLiquidBackground(double _maxFillLevel, double fillLevel) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Transform.translate(
          offset:
              Offset(0, ProductListCard.nominalHeightOpen * 1.2 - ProductListCard.nominalHeightOpen * _fillTween.value * _maxFillLevel * 1.2),
          child: CustomPaint(
            painter: LiquidPainter(fillLevel, _liquidSim1, _liquidSim2, waveHeight: 100),
          ),
        ),
      ],
    );
  }

  Row _buildTopContent() {
    return Row(
      children: <Widget>[
        //Icon
        Image.asset(
          widget.productData.iconImage,
          fit: BoxFit.fitWidth,
          width: 50,
          package: MyApp.pkg,
        ),
        SizedBox(width: 24),
        //Label
        Expanded(
          child: Text(
            widget.productData.title.toUpperCase(),
            style: Styles.text(18, Colors.white, true),
          ),
        ),
        //Star Icon
        Icon(Icons.star, size: 20, color: AppColors.orangeAccent),
        SizedBox(width: 4),
        //Points Text
        Text("${widget.productData.requiredPoints}", style: Styles.text(20, Colors.white, true))
      ],
    );
  }

  Column _buildBottomContent(double pointsValue) {
    bool isDisabled = widget.earnedPoints < widget.productData.requiredPoints;

    List<Widget> rowChildren = [];
    if (pointsValue == 0) {
      rowChildren.add(Text("Tudo pronto!", style: Styles.text(16, Colors.white, true)));
    } else {
      rowChildren.addAll([
        Text("You're only ", style: Styles.text(12, Colors.white, false)),
        Text(" ${pointsValue.round()} ", style: Styles.text(16, AppColors.orangeAccent, true)),
        Text(" points away", style: Styles.text(12, Colors.white, false)),
      ]);
    }

    return Column(
      children: [
        //Body Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ),
        SizedBox(height: 16),
        Text(
          "Este produto foi comprado com sucesso, e chagará na sua casa em até 15 minutos.",
          textAlign: TextAlign.center,
          style: Styles.text(14, Colors.white, false, height: 1.5),
        ),
        SizedBox(height: 16),
        //Main Button
        ButtonTheme(
          minWidth: 200,
          height: 40,
          child: Opacity(
            opacity: isDisabled ? .6 : 1,
            child: FlatButton(
              //Enable the button if we have enough points. Can do this by assigning a onPressed listener, or not.
              onPressed: isDisabled ? () {} : null,
              color: AppColors.orangeAccent,
              disabledColor: AppColors.orangeAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Text("Comprar", style: Styles.text(16, Colors.white, true)),
            ),
          ),
        )
      ],
    );
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap(widget.productData);
    }
  }

  void _rebuildIfOpen() {
    if (widget.isOpen) {
      setState(() {});
    }
  }
}
