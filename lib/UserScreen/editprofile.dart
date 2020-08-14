import 'package:flutter/material.dart';
import 'package:signinexample/models/user.dart';
import 'package:signinexample/services/user.dart';
import 'package:signinexample/widgets/custom_textfield.dart';

  

class EditUser extends StatelessWidget {
  static String id = 'EditUser';

  String _name, _number,_address ;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _user = Useredits();
  @override
  Widget build(BuildContext context) {
    Users users = ModalRoute.of(context).settings.arguments;
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
                  hint: 'Product Name',
                  onClick: (value) {
                    _name = value;
                  }, icon: null,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _number = value;
                  },
                  hint: 'Product Price', icon: null,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onClick: (value) {
                    _address = value;
                  },
                  hint: 'Product Description', icon: null,
                ),
              
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();

                      _user.editUser({
                        'name': _name,
                        'number': _number,
                        'address': _address,
                      
                      }, users.uId);
                    }
                     Navigator.pop(context);
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
}
