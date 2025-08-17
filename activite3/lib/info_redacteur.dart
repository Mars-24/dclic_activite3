import 'package:activite_firebase/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InforRedacteur extends StatefulWidget {
  const InforRedacteur({super.key});

  @override
  State<InforRedacteur> createState() => _InforRedacteurState();
}

class _InforRedacteurState extends State<InforRedacteur> {

  // 🔹 Fonction modification
  Future<void> updateRedacteur(String docId, String nom, String specialite) async {
    TextEditingController nomCtrl = TextEditingController(text: nom);
    TextEditingController specCtrl = TextEditingController(text: specialite);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Modifier le rédacteur"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nomCtrl, decoration: InputDecoration(labelText: "Nom")),
              TextField(controller: specCtrl, decoration: InputDecoration(labelText: "Spécialité")),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('redacteurs')
                      .doc(docId)
                      .update({
                    "nom": nomCtrl.text,
                    "specialite": specCtrl.text,
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Modification réussie")),
                  );
                  setState(() {}); // recharge la liste
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Erreur modification : $e")),
                  );
                }
              },
              child: Text("Enregistrer"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Information des rédacteurs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('redacteurs').get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Il y a un problème!"));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return Center(
                child: Text(
                  "Aucun rédacteur enregistré",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                docs[index].data() as Map<String, dynamic>;

                String docId = docs[index].id; // 🔑 important pour update/delete

                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(data['nom']),
                  subtitle: Text(data['specialite']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () =>
                            updateRedacteur(docId, data['nom'], data['specialite']),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => DatabaseProvider().deleteRedacteur(docId),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
