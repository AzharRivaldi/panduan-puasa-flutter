class ModelDetailSunnah {
  String? title;
  String? description;

  ModelDetailSunnah(this.title, this.description);

  ModelDetailSunnah.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json["description"];
  }
}