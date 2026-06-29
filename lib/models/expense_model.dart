class ExpenseModel {
  int? id;
  String title;
  double amount;
  String category;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;

  ExpenseModel({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "amount": amount,
      "category": category,
      "date": date.toIso8601String(),
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map["id"],
      title: map["title"],
      amount: (map["amount"] as num).toDouble(),
      category: map["category"],
      date: DateTime.parse(map["date"]),
      createdAt: DateTime.parse(map["createdAt"]),
      updatedAt: DateTime.parse(map["updatedAt"]),
    );
  }
}
