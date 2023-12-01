class Videos {
  String exercise = "";
  String url = "";
  String id = "";

  Videos({this.exercise = "", this.url = "", this.id = ""});

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      exercise: json['exercise'],
      url: json['url'],
      id: json['id'],
    );
  }

  factory Videos.FromList(List<dynamic> json) {
    return Videos(
      exercise: json[0],
      url: json[1],
      id: json[2],
    );
  }
}
