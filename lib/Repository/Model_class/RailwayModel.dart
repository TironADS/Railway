class RailwayModel {
  RailwayModel({
      this.status, 
      this.message, 
      this.timestamp, 
      this.data,});

  RailwayModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    timestamp = json['timestamp'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  int? timestamp;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['timestamp'] = timestamp;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.name, 
      this.engName, 
      this.code, 
      this.stateName,});

  Data.fromJson(dynamic json) {
    name = json['name'];
    engName = json['eng_name'];
    code = json['code'];
    stateName = json['state_name'];
  }
  String? name;
  String? engName;
  String? code;
  String? stateName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['eng_name'] = engName;
    map['code'] = code;
    map['state_name'] = stateName;
    return map;
  }

}