import 'package:activite_firebase/database/database.dart';
import 'package:activite_firebase/info_redacteur.dart';
import 'package:activite_firebase/model/redacteur.dart';
import 'package:flutter/material.dart';

class AddRedacteur extends StatefulWidget {
  const AddRedacteur({super.key});

  @override
  State<AddRedacteur> createState() => _AddRedacteurState();
}

class _AddRedacteurState extends State<AddRedacteur> {
  final _formKey = GlobalKey<FormState>();
  final _nomCtrl = TextEditingController(),_specialiteCtrl = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _nomCtrl.dispose();
    _specialiteCtrl.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _nomCtrl.clear();
    _specialiteCtrl.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter redacteur',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
          child:Padding(        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),

          child: Column(
            children: [
              TextFormField(
                controller: _nomCtrl,
                decoration: InputDecoration(
                    labelText: 'Nom du redacteur',
                    hintText: 'Nom du redacteur',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: _specialiteCtrl,
                decoration: InputDecoration(
                    labelText: 'specialité du redacteur',
                    hintText: 'specialité du redacteur',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () async{
                  if (_nomCtrl.text.isEmpty ||
                      _specialiteCtrl.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Veuillez remplir tous les champs')),
                    );
                    return;
                  }
                  final nom = _nomCtrl.text;
                  final speciality = _specialiteCtrl.text;
                  var redacteur = RedacteurModel(nom: nom,specialite: speciality);
                  var response = await DatabaseProvider().saveRedacteur(redacteur);
                  if(response){
                    _nomCtrl.clear();
                    _specialiteCtrl.clear();
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>InforRedacteur()));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erreur lors de l\'enregistrement du redacteur'),),);
                  }
                }, child: Text('Ajouter redacteur'),style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    )
                ),),
              )
            ],
          ),
          ),
      )


          ,
    );
  }
}
