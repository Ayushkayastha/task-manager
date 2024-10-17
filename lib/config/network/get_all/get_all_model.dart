class GetAllModel {
  GetAllModel({
      this.id, 
      this.name, 
      this.completed, 
      this.v,});

  GetAllModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    completed = json['completed'];
    v = json['__v'];
  }
  String? id;
  String? name;
  bool? completed;
  num? v;
GetAllModel copyWith({  String? id,
  String? name,
  bool? completed,
  num? v,
}) => GetAllModel(  id: id ?? this.id,
  name: name ?? this.name,
  completed: completed ?? this.completed,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['completed'] = completed;
    map['__v'] = v;
    return map;
  }

}