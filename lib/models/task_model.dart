class TaskModel {
  String id;
  String title;
  String description;
  String category;
  int date;
  String userId;

  TaskModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'] ?? "",
    title: json['title'] ?? "",
    description: json['description'] ?? "",
    category: json['category'] ?? "",
    date: json['date'] ?? 0,
    userId: json['userId'] ?? "",
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "category": category,
      "userId": userId,
      "date": date,
    };
  }
}
