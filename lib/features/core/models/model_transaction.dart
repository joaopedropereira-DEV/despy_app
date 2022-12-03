// Enums to Transaction Entity
enum Status { active, pending }

enum Type { revenue, expense, investments }

class Transaction {
  final String id;
  final double value;
  final String title;
  final String? description;
  final String refCategory;
  final DateTime createAt;
  final bool toRepeat;
  final Status status;
  final Type type;

  Transaction({
    this.description,
    required this.id,
    required this.value,
    required this.title,
    required this.refCategory,
    required this.createAt,
    required this.toRepeat,
    required this.status,
    required this.type,
  });

  Map<String, dynamic> toJson(Transaction transaction) {
    // Transaction to Json
    final Map<String, dynamic> data = {};

    data["id"] = transaction.id;
    data["value"] = transaction.value;
    data["title"] = transaction.title;
    data["description"] = transaction.description;
    data["createAt"] = transaction.createAt;
    data["toRepeat"] = transaction.toRepeat;
    data["status"] = transaction.status;
    data["type"] = transaction.type;

    return data;
  }
}
