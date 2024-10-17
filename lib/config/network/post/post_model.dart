class PostModel {
  PostModel({
      this.name, 
      this.completed, 
      this.id, 
      this.v,});

  PostModel.fromJson(dynamic json) {
    name = json['name'];
    completed = json['completed'];
    id = json['_id'];
    v = json['__v'];
  }
  String? name;
  bool? completed;
  String? id;
  num? v;
PostModel copyWith({  String? name,
  bool? completed,
  String? id,
  num? v,
}) => PostModel(  name: name ?? this.name,
  completed: completed ?? this.completed,
  id: id ?? this.id,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['completed'] = completed;
    map['_id'] = id;
    map['__v'] = v;
    return map;
  }

}