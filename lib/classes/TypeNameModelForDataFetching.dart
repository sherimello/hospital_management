class TypeNameModelForDataFetching {
  List<Data> data;

  TypeNameModelForDataFetching({this.data});

  TypeNameModelForDataFetching.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data extends TypeNameModelForDataFetching{
  String sL;
  String typeName;

  Data({this.sL, this.typeName});

  Data.fromJson(Map<String, dynamic> json) {
    sL = json['SL'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SL'] = this.sL;
    data['type_name'] = this.typeName;
    return data;
  }
}