import 'package:activite_firebase/add.dart';
import 'package:activite_firebase/info_redacteur.dart';
import 'package:flutter/material.dart';


class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magazine',style:TextStyle(color: Colors.white) ),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search,color: Colors.white,))],
      ),
      drawer: Drawer(
        child: Column(children: [
          DrawerHeader(decoration:BoxDecoration(color: Colors.pinkAccent) ,child: Container(
            width: double.infinity,
            child: Text('Menu',style: TextStyle(color: Colors.white,fontSize: 20.0),),
          ),),
          ListTile(
            leading: Icon(Icons.person_add_alt_1_rounded),
            title: Text('Ajouter un redacteur'),
            onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (_)=>AddRedacteur()));},
          ),
          ListTile(
            leading: Icon(Icons.list_alt_outlined),
            title: Text('Information des redacteurs'),
            onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (_)=>InforRedacteur()));},

          ),
        ],),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/magazine.jpg'),
              height: MediaQuery.of(context).size.height / 3,
              fit: BoxFit.cover,
            ),
            PartieTitre(),
            PartieText(),
            PartieIcone(),
            PartieRubrique()
          ],
        ),
      ),
    );
  }
}


class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenu au magazine info',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          Text('Votre magazine numerique,source d\'inspiration')
        ],
      ),
    );
  }
}

class PartieText extends StatelessWidget {
  const PartieText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(
          'Artificial Intelligence (AI) has rapidly evolved from a niche technology to a fundamental component of many applications we use daily. From voice assistants to recommendation systems, AI is quietly transforming how we interact with technology.'),
    );
  }
}

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Column(
              children: [
                Icon(Icons.call, color: Colors.pink),
                SizedBox(height: 5.0),
                Text('TEL', style: TextStyle(color: Colors.pink))
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Icon(Icons.mail, color: Colors.pink),
                SizedBox(height: 5.0),
                Text('MAIL', style: TextStyle(color: Colors.pink))
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Icon(
                  Icons.share,
                  color: Colors.pink,
                ),
                SizedBox(height: 5.0),
                Text(
                  'PARTAGE',
                  style: TextStyle(color: Colors.pink),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Image.asset(
              'assets/images/image_1.png',
              width: MediaQuery.of(context).size.width/3,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Image.asset(
              'assets/images/image_2.png',
              width: MediaQuery.of(context).size.width/3,
            ),
          ),
        ],
      ),
    );
  }
}