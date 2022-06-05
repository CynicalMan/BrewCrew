import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Color? getColor(Set<MaterialState> states) => Colors.brown[800];

  @override
  Widget build(BuildContext context) {
    
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        print(context);
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }
    
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews, 
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(getColor),
              ),
              onPressed: () async{
                await _auth.signOut();
              }, 
              icon: Icon(Icons.logout),
              label: Text(''),
            ),
            TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(getColor),
              ),
              onPressed: () => _showSettingsPanel(), 
              icon: Icon(Icons.settings),
              label: Text(''),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList()
        ),
      ),
    );
  }
}