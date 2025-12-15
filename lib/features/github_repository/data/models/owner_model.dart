import '../../domain/entities/owner.dart';

class OwnerModel extends Owner {
  const OwnerModel({
    required super.id,
    required super.login,
    required super.avatarUrl,
    required super.htmlUrl,
    required super.type,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      id: json['id'],
      login: json['login'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
      'type': type,
    };
  }
}
