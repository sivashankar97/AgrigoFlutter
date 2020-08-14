import 'package:flutter/material.dart';
// import 'package:signinexample/UserScreen/HomeMain/homepage.dart';
import 'package:signinexample/UserScreen/SignUp/ChildViews/signupform.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:signinexample/UserScreen/HomeMain/userscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signinexample/UserScreen/myHomePage.dart';


class SignUpMain extends StatefulWidget {
  final FirebaseUser firebaseUser;
  SignUpMain({Key key, @required this.firebaseUser}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpWithMail();
}

class _SignUpWithMail extends State<SignUpMain> {
  // Get user data. these controllers connected with childView ( signupform.dart )
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  // final _introduceTextController = TextEditingController();
  final _numTextController = TextEditingController();
  final _addTextController = TextEditingController();

  // pageController in view.
  // final PageController _pageController = PageController();
  // int _currentPage = 0;

  // save user data except textfield data like gender, images, birthday
  Map<String, dynamic> _userDataMap = Map<String, dynamic>();

  // the data from SNS ( facebook, google ). if using email, the value is null.
  FirebaseUser currentUser;

  // Editable values
  String _nextText = 'Create';
  Color _nextColor = Colors.green[800];

  // Save imageList from library
  // List<File> _imageList;

  // image URL String list from Firebase storage.
  List<String> _imageStringList = List<String>.generate(4, (i) => '');

  bool isWithSNS = false;
  bool isLoading = false;

  // update user data from child views ( signupform, signupimage, signupintroduce)
  // the 0 is key. 1 is value
  _updateUserData(List<dynamic> data) {
    setState(() {
      _userDataMap[data[0]] = data[1];
    });
  }

  @override
  void initState() {
  
    // set data from SNS
    setState(() {
      if (widget.firebaseUser != null) {
        isWithSNS = true;
        currentUser = widget.firebaseUser;
        _emailTextController.text = currentUser.email;
        _nameTextController.text = currentUser.displayName;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          WillPopScope(
            // blocking if the user cancel button, close the view.
            onWillPop: () {  },
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/intro_bg.png'),
                        fit: BoxFit.fill)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        // white bg with radius.
                        // margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[400]),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 4),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: 700,
                              height: 440,
                              child: PageView(
                               
                                children: <Widget>[
                                  SignUpForm(
                                      // pass controllers to get texts
                                      _emailTextController,
                                      _passwordTextController,
                                      _nameTextController,
                                      _updateUserData,
                                      _numTextController,
                                      _addTextController,
                                      isWithSNS),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(12.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Cancel',
                                            style: TextStyle(fontSize: 28),
                                          ),
                                        ],
                                      ),
                                      textColor: Colors.black,
                                      color: Colors.white,
                                      padding: EdgeInsets.all(10),
                                      onPressed: () {
                                        // move first page view when click 'cancel' button
                                        
                                          Navigator.pop(context);
                                        
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: RaisedButton(

                                      
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(12.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            _nextText,
                                            style: TextStyle(fontSize: 28),
                                          ),
                                        ],
                                      ),
                                      textColor: Colors.white,
                                      color: _nextColor,
                                      padding: EdgeInsets.all(10),
                                      onPressed: () {
                                     
                                          
                                          if (_validateUserData()) {
                                            print('last page');
                                            setState(() {
                                              isLoading = true;
                                            });
                                            if (currentUser == null) {
                                              _signUpToFirebaseAuth(); // if user use email, add email and password to Firebase Auth
                                            } else {
                                              _insertDataToLocalAndFirebaseDB(
                                                  currentUser); // if user use SNS, add data directly.
                                            }
                                          }
                                        
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            // onWillPop: onBackPress,
          ),
          Positioned(
            child: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
//                  valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                          ),
                    ),
                    color: Colors.white.withOpacity(0.7),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  bool _validateUserData() {
    String alertString = '';

    if (_emailTextController.text.trim() == '') {
      alertString = alertString + 'Please type your email';
    }

    if (!isWithSNS) {
      if (_passwordTextController.text.trim() == '') {
        if (alertString.trim() != '') {
          alertString = alertString + '\n\n';
        }
        alertString = alertString + 'Please type your password';
      }
    }

    if (_nameTextController.text.trim() == '') {
      if (alertString.trim() != '') {
        alertString = alertString + '\n\n';
      }
      alertString = alertString + 'Please type your name';
    }
    if (_numTextController.text.trim() == '') {
      if (alertString.trim() != '') {
        alertString = alertString + '\n\n';
      }
      alertString = alertString + 'Please type your number';
    }
     if (_addTextController.text.trim() == '') {
      if (alertString.trim() != '') {
        alertString = alertString + '\n\n';
      }
      alertString = alertString + 'Please type your address';
    }

   

    if (_userDataMap['term'] == false) {
      if (alertString.trim() != '') {
        alertString = alertString + '\n\n';
      }
      alertString = alertString + 'Please agree the term check box';
    }

    if (alertString.trim() != '') {
      showDialogWithText(alertString);
      return false;
    } else {
      return true;
    }
  }

  Future<void> _signUpToFirebaseAuth() async {
    try {
      final FirebaseUser firebaseUser = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emailTextController.text,
                  password: _passwordTextController.text))
          .user;
       _insertDataToLocalAndFirebaseDB(firebaseUser);
    } catch (e) {
      showDialogWithText(e.message);
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> _insertDataToLocalAndFirebaseDB(
      FirebaseUser firebaseUser) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result = await Firestore.instance
            .collection('users')
            .where('id', isEqualTo: firebaseUser.uid)
            .getDocuments();
        final List<DocumentSnapshot> documents = result.documents;
        if (documents.length == 0) {
          // Update data to server if new user
          Firestore.instance
              .collection('users')
              .document(firebaseUser.uid)
              .setData({
            'email': _emailTextController.text,
            'password': _passwordTextController.text,
            'name': _nameTextController.text,
            'number': _numTextController.text,
            'address':_addTextController.text,
            'id': firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          });

          // Write data to local
          currentUser = firebaseUser;
          await prefs.setString('id', currentUser.uid);
          await prefs.setString('email', _emailTextController.text);
          await prefs.setString('password', _passwordTextController.text);
          await prefs.setString('name', _nameTextController.text);
          await prefs.setString('number', _numTextController.text);
          await prefs.setString('address', _addTextController.text);

        } else {
          // Write Firebase data to local
          await prefs.setString('id', documents[0]['id']);
          await prefs.setString('email', documents[0]['email']);
          await prefs.setString('password', documents[0]['password']);
          await prefs.setString('name', documents[0]['name']);
          await prefs.setString('number', documents[0]['number']);
          await prefs.setString('address', documents[0]['address']);

          
        }
        setState(() {
          isLoading = false;
        });
      } else {
        showDialogWithText('Sign in fail');
        setState(() {
          isLoading = false;
        });
      }
      await prefs.setBool('isLogin', true);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } catch (e) {
      showDialogWithText(e.message);
      setState(() {
        isLoading = false;
      });
    }
  }

  showDialogWithText(String textMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(textMessage),
          );
        });
  }
}
