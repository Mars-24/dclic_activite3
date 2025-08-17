import 'package:activite_firebase/model/redacteur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseProvider{

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<bool> saveRedacteur(RedacteurModel redacteur) async {
    try {
      await firestore.collection('redacteurs').add({
        'nom': redacteur.nom,
        'specialite': redacteur.specialite,
      });
      return true; // Insertion réussie
    } catch (e) {
      print("Erreur lors de l'insertion : $e");
      return false; // Insertion échouée
    }
  }
  Future<bool> deleteRedacteur(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('redacteurs')
          .doc(docId)
          .delete();
      return true; // Insertion réussie

    } catch (e) {
      print("Erreur lors de la suppression : $e");
      return false; // Insertion échouée
    }
  }
}