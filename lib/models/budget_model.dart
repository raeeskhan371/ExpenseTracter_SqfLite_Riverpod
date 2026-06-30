class BudgetModel {
  int? id;
  double amount;
  DateTime? createdAt;
  DateTime updatedAt;

  BudgetModel({
    required this.amount,
    this.createdAt,
    required this.updatedAt,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      amount: (map["amount"] as num).toDouble(),
      createdAt: DateTime.parse(map["createdAt"]),
      updatedAt: DateTime.parse(map["updatedAt"]),
      id: map["id"],
    );
  }
}
