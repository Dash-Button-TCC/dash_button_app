import 'package:dash_button_app/screens/demo.dart';
import 'package:flutter/material.dart';
import 'package:dash_button_app/widgets/icon_badge.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: (){},
        ),

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
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Botões Cadastrados",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blueGrey[300],
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Procure por um botão cadastrado.",
                  prefixIcon: Icon(
                    Icons.radio_button_checked,
                    color: Colors.blueGrey[300],
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueGrey[300],
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(1),
            child: DemoProductsList()
          ),

        ],
      ),

    );
  }
}
