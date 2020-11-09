class BaseOutput<T> {
  List<T> data;
  int code;

  BaseOutput({this.code, this.data});

  factory BaseOutput.fromJson(
      Map<String, dynamic> json, Function decodeDataObject) {
    var data;

    var dataMap = json['data'];

    data = List<T>();

    if (dataMap is List) {
      json['data'].forEach((v) {
        data.add(decodeDataObject(v));
      });
    } else {
      data.add(decodeDataObject(json['data']));
    }

    return BaseOutput(code: json["code"], data: data);
  }
}
