import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/const.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Color? getColor(Set<MaterialState> states) => Colors.brown[800];
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text fields 
  String email = '';
  String password = '';
  String error = '';
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              }, 
              icon: Icon(
                Icons.person,
                color: Colors.brown[800],
              ),
              label: Text('Register',
                  style: TextStyle(
                      color: Colors.brown[800]
                  ),
              ),
            )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        // child: ElevatedButton(
        //   onPressed: () async{
        //     dynamic result = await _auth.signInAnon();
        //   },
        //   child: Text('Sign in Anon'),
        // ),
        child: Form(
          key: _formKey,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith( hintText: 'Email'),
                validator: (value) => value!.isEmpty ? 'enter an email' : null,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (value) => value!.length < 6 ? 'enter a pass 6+ chars long' : null,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'please provide a valid email or password';
                        loading = false;
                      });
                    }
                  }
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor : Colors.pink[400],
                ),
              ),
              SizedBox(height: 12.0),
              Text(error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}