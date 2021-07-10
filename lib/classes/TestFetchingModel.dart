class TestFetchingModel {
  List<Data> data;

  TestFetchingModel({this.data});

  TestFetchingModel.fromJson(Map<String, dynamic> json) {
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

class Data {
  String sL;
  String testName;
  String fee;
  String type;

  Data({this.sL, this.testName, this.fee, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    sL = json['SL'];
    testName = json['test_name'];
    fee = json['fee'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SL'] = this.sL;
    data['test_name'] = this.testName;
    data['fee'] = this.fee;
    data['type'] = this.type;
    return data;
  }
}
