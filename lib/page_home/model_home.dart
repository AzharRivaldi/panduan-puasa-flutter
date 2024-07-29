class ModelHome {
  String? title;
  String? description;

  ModelHome(this.title, this.description);

  ModelHome.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }
}