import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm(
      this.emailTextController,
      this.passwordTextController,
      this.nameTextController,
      this.parentAction,
      this.numTextController,
      this.addTextController,
      this.isWithSNS);

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController nameTextController;
  final TextEditingController numTextController;
  final TextEditingController addTextController;


  final ValueChanged<List<dynamic>> parentAction;

  bool isWithSNS = false;

  @override
  State<StatefulWidget> createState() => _SignUpForm();
}

// enum GenderEnum { man, woman }

class _SignUpForm extends State<SignUpForm>
    with AutomaticKeepAliveClientMixin<SignUpForm> {
  
  bool _agreedToTerm = false;

 

  void _setAgreedToTerm(bool newValue) {
    _passDataToParent('term', newValue);
    setState(() {
      _agreedToTerm = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(14.0, 1, 14, 10),
      padding: const EdgeInsets.fromLTRB(14.0, 0, 14, 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 360,
            child: TextFormField(
              enabled: !widget.isWithSNS,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.mail,
                    color: !widget.isWithSNS ? Colors.grey : Colors.grey[300],
                  ),
                  labelText: 'Email',
                  hintText: 'Type your email'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Email is required';
                } else {
                  return null;
                }
              },
              style: TextStyle(
                  color: !widget.isWithSNS ? Colors.black : Colors.grey[400]),
              controller: widget.emailTextController,
            ),
          ),
          SizedBox(
            width: 360,
            child: TextFormField(
              enabled: !widget.isWithSNS,
              obscureText: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.lock,
                    color: !widget.isWithSNS ? Colors.grey : Colors.grey[300],
                  ),
                  labelText:
                      !widget.isWithSNS ? 'Password' : 'Do not need a password',
                  hintText: 'Type password'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Password is required';
                } else {
                  return null;
                }
              },
              style: TextStyle(
                  color: !widget.isWithSNS ? Colors.black : Colors.grey[300]),
              controller: widget.passwordTextController,
            ),
          ),
          Divider(),
          SizedBox(
            width: 360,
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.account_circle),
                  labelText: 'Name',
                  hintText: 'Type Name'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Name is required';
                } else {
                  return null;
                }
              },
              controller: widget.nameTextController,
            ),
          ),
          Divider(),
          SizedBox(
            width: 360,
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.phone_iphone),
                  labelText: 'Number',
                  hintText: 'Type number'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Num  is required';
                } else {
                  return null;
                }
              },
              controller: widget.numTextController,
            ),
          ),
        
      
          Divider(),
            SizedBox(
            width: 360,
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.phone_iphone),
                  labelText: 'Address',
                  hintText: 'Type address'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'address  is required';
                } else {
                  return null;
                }
              },
              controller: widget.addTextController,
            ),
          ),
          // SizedBox(
          //   width: 360,
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
          //     child: Row(
          //       children: <Widget>[
          //         Checkbox(
          //           value: _agreedToTerm,
          //           onChanged: _setAgreedToTerm,
          //         ),
          //         GestureDetector(
          //           onTap: () {
          //             _agreedToTerm = !_agreedToTerm;
          //             _setAgreedToTerm(_agreedToTerm);
          //           },
          //           child: Text('I agree to '),
          //         ),
          //         GestureDetector(
          //           onTap: () => _showTermPolicy(),
          //           child: const Text(
          //             'Terms of Services',
          //             style: TextStyle(
          //                 color: Colors.blue, fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void _showTermPolicy() {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("SignInExample's Terms of Services, Privacy Policy"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Container(
            height: 360,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Terms of Services, Privacy Policy' * 100),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            )
          ],
        ));
  }

  void _passDataToParent(String key, dynamic value) {
    List<dynamic> addData = List<dynamic>();
    addData.add(key);
    addData.add(value);
    widget.parentAction(addData);
  }

  @override
  bool get wantKeepAlive => true;
}
