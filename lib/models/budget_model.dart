class BudgetModel {
  int? id;
  double amount;
  String createdAt;
  String updatedAt;

  BudgetModel({
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      amount: (map["amount"] as num).toDouble(),
      createdAt: map["createdAt"],
      updatedAt: map["updatedAt"],
      id: map["id"],
    );
  }
}
