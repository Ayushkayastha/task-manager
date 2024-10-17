class UpdateModel {
  UpdateModel({
      this.id, 
      this.name, 
      this.completed, 
      this.v,});

  UpdateModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    completed = json['completed'];
    v = json['__v'];
  }
  String? id;
  String? name;
  bool? completed;
  num? v;
UpdateModel copyWith({  String? id,
  String? name,
  bool? completed,
  num? v,
}) => UpdateModel(  id: id ?? this.id,
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