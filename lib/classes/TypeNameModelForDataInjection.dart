class SetTypeName {
  // int ID;
  String typename;

  SetTypeName({this.typename});

  factory SetTypeName.fromJson(Map<String, dynamic> json) {
    return SetTypeName(
      // ID: json['SL'] as int,
      typename: json['type_name'] as String,
    );
  }
}
