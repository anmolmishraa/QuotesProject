class Fav {
  final String id;


  Fav({required this.id, });



  Map<String, dynamic> toMap() {
    return {'id': this.id, };
  }

  factory Fav.fromMap(Map map) {
    return Fav(
      id: map['id'],

    );
  }

  String toString() {
    return 'id: $id';
  }
}