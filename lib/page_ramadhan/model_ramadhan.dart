class ModelRamadhan {
  String? title;
  String? description;

  ModelRamadhan(this.title, this.description);

  ModelRamadhan.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }
}