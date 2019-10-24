import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/imgs/big.png"), fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 180.0,
              height: 160.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/imgs/logo_charlotte.png"),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 200.0,
            )
          ],
        ),
      ),
    );
  }
}
