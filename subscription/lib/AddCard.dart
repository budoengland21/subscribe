import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,size: 30,),),

      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.red,
            child: Center(
              child: Container(
                
                height: 150,
                width: (MediaQuery.of(context).size.width)-100,
                //color: Colors.white,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
