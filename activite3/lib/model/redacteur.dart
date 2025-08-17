class RedacteurModel{

  final int? id;
  final String nom;
  final String specialite;

  RedacteurModel({this.id,required this.nom,required this.specialite});

  Map<String,dynamic>toMap(){
    return{
      'id':id,
      'nom':nom,
      'specialite':specialite
    };
  }

  factory RedacteurModel.fromMap(Map<String,dynamic>map){
    return RedacteurModel(id:map['id'],nom:map['nom'], specialite:map['specialite']);
  }

}