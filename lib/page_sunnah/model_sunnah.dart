class ModelSunnah {
  String? title;

  ModelSunnah(this.title);

  ModelSunnah.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }
}