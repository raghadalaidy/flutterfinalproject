import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutterfirebase/provider/adminMode.dart';
import 'package:flutterfirebase/provider/cartItem.dart';
import 'package:flutterfirebase/provider/modelHud.dart';
import 'package:flutterfirebase/screens/admin/OrdersScreen.dart';
import 'package:flutterfirebase/screens/admin/addProduct.dart';
import 'package:flutterfirebase/screens/admin/adminHome.dart';
import 'package:flutterfirebase/screens/admin/editProduct.dart';
import 'package:flutterfirebase/screens/admin/manageProduct.dart';
import 'package:flutterfirebase/screens/admin/order_details.dart';
import 'package:flutterfirebase/screens/login_screen.dart';
import 'package:flutterfirebase/screens/signup_screen.dart';
import 'package:flutterfirebase/screens/user/CartScreen.dart';
import 'package:flutterfirebase/screens/user/homePage.dart';
import 'package:flutterfirebase/screens/user/productInfo.dart';


main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          OrderDetails.id: (context) => OrderDetails(),
          OrdersScreen.id: (context) => OrdersScreen(),
          CartScreen.id: (context) => CartScreen(),
          ProductInfo.id: (context) => ProductInfo(),
          EditProduct.id: (context) => EditProduct(),
          ManageProducts.id: (context) => ManageProducts(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePage.id: (context) => HomePage(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
        },
      ),
    );
  }
}