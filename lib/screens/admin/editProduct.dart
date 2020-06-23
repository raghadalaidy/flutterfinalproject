
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/constants.dart';
import 'package:flutterfirebase/models/product.dart';
import 'package:flutterfirebase/services/store.dart';
import 'package:flutterfirebase/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  String _name, _price, _description, _category, _image,_location;
  File _imagee;
  String _url;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  initialValue: product.pName,
                  onClick: (value) {
                    _name = value;
                  },
                  hint: 'product Name',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  initialValue: product.pPrice,
                  onClick: (value) {
                    _price = value;
                  },
                  hint: 'product Price',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  initialValue: product.pDescription,
                  onClick: (value) {
                    _description = value;
                  },
                  hint: 'product Description',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  initialValue: product.pCategory,
                  onClick: (value) {
                    _category = value;
                  },
                  hint: 'product Category',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  initialValue: (product.pLocation).toString(),
                  onClick: (value) {
                    _location = value;
                  },
                  hint: 'product Location',
                ),
                SizedBox(
                  height: 20,
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
                      if (_image == null) {
                      _store.editProduct({
                        kProductName: _name,
                        kProductLocation: _location,
                        kProductCategory: _category,
                        kProductImage: product.pImage,
                        kProductDescription: _description,
                        kProductPrice: _price
                      }, product.pId);
                     }
                      else {
                        _store.editProduct({
                          kProductName: _name,
                          kProductLocation: _location,
                          kProductCategory: _category,
                          kProductImage: _image,
                          kProductDescription: _description,
                          kProductPrice: _price
                        }, product.pId);
                     }
                    }
                  },
                  child: Text('Edit Product'),
                )
              ],
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
