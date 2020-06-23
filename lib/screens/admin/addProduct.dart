
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/models/product.dart';
import 'package:flutterfirebase/services/store.dart';
import 'package:flutterfirebase/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';


// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _image,_location;
  File _imagee;
  String _url;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _price = value;
              },
              hint: 'Product Price',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _description = value;
              },
              hint: 'Product Description',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _category = value;
              },
              hint: 'Product Category',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _location = value;
              },
              hint: 'Product Location',
            ),
            SizedBox(
              height: 10,
            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: _imagee == null ? null : FileImage(_imagee),
                  radius: 80,
                ),

                GestureDetector(onTap: pickImageGallery , child: Icon(Icons.add_photo_alternate)),
                GestureDetector(onTap: pickImageCamera, child: Icon(Icons.add_a_photo))

              ],
            ),


            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                  _store.addProduct(Product(
                      pName: _name,
                      pPrice: _price,
                      pDescription: _description,
                      pCategory: _category,
                      pLocation: _location,
                      pImage: _image
                      ));
                }


              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }




  void pickImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _imagee = image;

    FirebaseStorage storage =
    FirebaseStorage(storageBucket: 'gs://flutterprojectfinal.appspot.com');
    StorageReference ref = storage.ref().child(_imagee.path);
    StorageUploadTask storageUploadTask = ref.putFile(_imagee);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();
    print('url $url');
    _image = url;


  }

  void pickImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _imagee = image;
    FirebaseStorage storage =
    FirebaseStorage(storageBucket: 'gs://flutterprojectfinal.appspot.com');
    StorageReference ref = storage.ref().child(_imagee.path);
    StorageUploadTask storageUploadTask = ref.putFile(_imagee);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();
    print('url $url');
    _image = url;


  }


}
