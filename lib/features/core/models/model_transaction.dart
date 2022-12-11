// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionModel {
  final String id;
  final double value;
  final String title;
  final String? description;
  final String refCategory;
  final DateTime createAt;
  final bool toRepeat;
  final String status;
  final String type;

  TransactionModel({
    required this.id,
    required this.value,
    required this.title,
    this.description,
    required this.refCategory,
    required this.createAt,
    required this.toRepeat,
    required this.status,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'title': title,
      'description': description,
      'refCategory': refCategory,
      'createAt': createAt.millisecondsSinceEpoch,
      'toRepeat': toRepeat,
      'status': status,
      'type': type,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      value: map['value'] as double,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      refCategory: map['refCategory'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      toRepeat: map['toRepeat'] as bool,
      status: map['status'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
