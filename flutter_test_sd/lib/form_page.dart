import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test_sd/data/directory/root_directory.dart';
import 'package:flutter_test_sd/data/entity/form_entity.dart';
import 'package:flutter_test_sd/router/page.dart';
import 'package:logging/logging.dart';
import 'package:toast/toast.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  Logger logger;

  final FormEntity formEntity = FormEntity();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<NavigatorState> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController;
  TextEditingController nameController;
  TextEditingController desController;
  FocusNode nameFocus;
  FocusNode emailFocus;
  FocusNode desFocus;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    emailController = TextEditingController();
    desController = TextEditingController();

    nameFocus = FocusNode();
    emailFocus = FocusNode();
    desFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            'Forms',
          ),
          backgroundColor: Colors.deepOrange,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Toast.show('on click add button', context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              },
            )
          ],
        ),
        body: _buildBody(),
      ),
      onWillPop: () => onWillPop()
    );
  }

  Future<bool> onWillPop() async {
    // Navigator.of(context).maybePop();
    Navigator.of(scaffoldKey.currentContext).pushNamedAndRemoveUntil(Pages.home, (Route<dynamic> route) => false);
    return false;
  }

  Widget _buildBody() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  focusNode: nameFocus,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: onNameSubmitted,
                  onEditingComplete: onEditingComplete,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                    controller: emailController,
                    focusNode: emailFocus,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: onEmailSubmitted,
                    onEditingComplete: onEditingComplete,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    )),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                    controller: desController,
                    focusNode: desFocus,
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: onDescriptionSubmitted,
                    onEditingComplete: onEditingComplete,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: RaisedButton(
                      child: Text(
                        'บันทึก',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.deepOrange,
                      onPressed: () {
                        saveData();
                      }),
                )
              ]),
        ));
  }

  void onNameSubmitted(dynamic _) {
    nameFocus.unfocus();
    FocusScope.of(context).requestFocus(nameFocus);
  }

  void onEmailSubmitted(dynamic _) {
    emailFocus.unfocus();
    FocusScope.of(context).requestFocus(emailFocus);
  }

  void onDescriptionSubmitted(dynamic _) {
    desFocus.unfocus();
    FocusScope.of(context).requestFocus(desFocus);
  }

  void onEditingComplete() {
    _formKey.currentState.validate();
  }

  bool _checkNotNull() {
    bool res;
    if (nameController.text.isEmpty &&
        emailController.text.isEmpty &&
        desController.text.isEmpty) {
      _showSnackBar('Title, Note and Description cannot be empty');
      res = false;
    } else if (nameController.text.isEmpty) {
      _showSnackBar('Name cannot be empty');
      res = false;
    } else if (emailController.text.isEmpty) {
      _showSnackBar('Email cannot be empty');
      res = false;
    } else if (desController.text.isEmpty) {
      _showSnackBar('Description cannot be empty');
      res = false;
    } else {
      res = true;
    }
    return res;
  }

  void _showSnackBar(String msg) {
    final SnackBar snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.brown,
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> saveData() async {
    File jsonFile;

    try {
      var rootDirectory = await getRootDirectory();
      print(rootDirectory);

      if (_checkNotNull() == true) {
        var name = formEntity.name = nameController.text;
        formEntity.email = emailController.text;
        formEntity.description = desController.text;

        final String newDirPath = '$rootDirectory/$name.txt';
        final String json = jsonEncode(formEntity.toMap());
        jsonFile = File('$newDirPath');
        jsonFile.createSync();
        jsonFile.writeAsStringSync(json);

        Navigator.of(context).pushNamedAndRemoveUntil(Pages.home, (Route<dynamic> route) => false);
      }
    } catch (e) {
      logger.severe('create note error');
    }
  }



  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    desController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    desFocus.dispose();

    super.dispose();
  }
}
