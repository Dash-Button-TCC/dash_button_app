import 'package:dash_button_app/screens/demo.dart';
import 'package:dash_button_app/util/const.dart';
import 'package:dash_button_app/util/demo_data.dart';
import 'package:dash_button_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:dash_button_app/widgets/icon_badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchControl = new TextEditingController();
  bool selected = false;
  bool selected1 = false;

  @override
  Widget build(BuildContext context) {

    Color iconColor = Theme.of(context).primaryColor == Constants.darkPrimary? Colors.black12:Colors.white12;
    Color boxColor = Theme.of(context).primaryColor  == Constants.darkPrimary? Colors.white12:Colors.white;

    return Scaffold(
      drawer: Drawer(
        child: new Material(
          color: Theme.of(context).primaryColor,
          child: new Container(
            padding: new EdgeInsets.symmetric(vertical: 30),
            decoration: new BoxDecoration(

            ),
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage("https://github.com/Calebe94.png")
                              )
                          )
                        ),
                      ),
                      Container(
                        child: Text("Edimar Calebe Castanho", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                  // Update the state of the app
                  // ...
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                  // Update the state of the app
                  // ...
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(
          Icons.add,
        ),
        onPressed: (){},
      ),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.menu,
        //   ),
        //   onPressed: (){
        //     print("SIDE MENU");
        //   },
        // ),
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications_none,
            ),
            onPressed: (){},
          ),
        ],
      ),

      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage("https://github.com/Calebe94.png")
                      )
                  )
                ),
              ),
              Container(
                child: Text("Edimar Calebe Castanho", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),),
              )
            ],
          ),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
            child: Text(
              "Meus Remédios",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap : true,
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(blurRadius: 1),
                  ],
                  color: boxColor,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => print("Manhã"), // handle your onTap here
                    child: Container(
                      // height: 160, width: 160,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Manhã", style: TextStyle(fontSize: 20)),
                            GridView.count(
                              crossAxisCount: 4,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap : true,
                              padding: EdgeInsets.all(10),
                              children: <Widget>[
                                SvgPicture.asset("assets/icons/pill.svg", height: 30, width: 30, color: Colors.grey,),
                                SvgPicture.asset("assets/icons/pill.svg", height: 30, width: 30, color: Colors.red,),
                                SvgPicture.asset("assets/icons/pill.svg", height: 30, width: 30, color: Colors.red,),
                                SvgPicture.asset("assets/icons/pill.svg", height: 30, width: 30, color: Colors.red,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              ],
                            )
                          ],
                        )
                      ) ,
                    ),
                  )
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(blurRadius: 1),
                  ],
                  color: boxColor,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => print("Tarde"), // handle your onTap here
                    child: Container(
                      height: 160, width: 160,
                      child: Center(child: Text("Tarde", style: TextStyle(fontSize: 20))) ,
                    ),
                  )
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(blurRadius: 1),
                  ],
                  color: boxColor,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => print("Noite"), // handle your onTap here
                    child: Container(
                      height: 160, width: 160,
                      child: Center(
                        child: Text("Noite", style: TextStyle(fontSize: 20))
                      ) ,
                    ),
                  )
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(blurRadius: 1),
                  ],
                  color: boxColor,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => print("Madrugada"), // handle your onTap here
                    child: Container(
                      height: 160, width: 160,
                      child: Center(child: Text("Madrugada", style: TextStyle(fontSize: 20))) ,
                    ),
                  )
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }

  Widget _buildCard(String name, String status, int cardIndex,String images) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            Stack(
                children: <Widget>[
                  Container(
                    height: 125.0,
                    width: 125.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blueGrey,
                        image: DecorationImage(
                            image: AssetImage(images)
                        )
                    ),
                  ),

                ]),
            SizedBox(height: 8.0),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              status,
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey
              ),
            ),


          ],
        ),
        margin: cardIndex.isEven? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0):EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0)
    );
  }
}
