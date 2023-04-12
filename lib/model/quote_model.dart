// /// quotes : "The greatest glory in living lies not in never falling, but in rising every time we fall."
// /// author_name : "Nelson Mandela"
// /// tag : "emotional"
// /// id : "1"
//
// class QuoteModel {
//   QuoteModel({
//       String? quotes,
//       String? authorName,
//       String? tag,
//       String? id,}){
//     _quotes = quotes;
//     _authorName = authorName;
//     _tag = tag;
//     _id = id;
// }
//
//   QuoteModel.fromJson(dynamic json) {
//     _quotes = json['quotes'];
//     _authorName = json['author_name'];
//     _tag = json['tag'];
//     _id = json['id'];
//   }
//   String? _quotes;
//   String? _authorName;
//   String? _tag;
//   String? _id;
// QuoteModel copyWith({  String? quotes,
//   String? authorName,
//   String? tag,
//   String? id,
// }) => QuoteModel(  quotes: quotes ?? _quotes,
//   authorName: authorName ?? _authorName,
//   tag: tag ?? _tag,
//   id: id ?? _id,
// );
//   String? get quotes => _quotes;
//   String? get authorName => _authorName;
//   String? get tag => _tag;
//   String? get id => _id;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['quotes'] = _quotes;
//     map['author_name'] = _authorName;
//     map['tag'] = _tag;
//     map['id'] = _id;
//     return map;
//   }
//
// }

class QuoteModel {
  String ?quotes;
  String ?authorName;
  String ?tag;
  String ?id;

  QuoteModel({this.quotes, this.authorName, this.tag, this.id});

  QuoteModel.fromJson(Map<String, dynamic> json) {
    quotes = json['quotes'];
    authorName = json['author_name'];
    tag = json['tag'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quotes'] = this.quotes;
    data['author_name'] = this.authorName;
    data['tag'] = this.tag;
    data['id'] = this.id;
    return data;
  }
}