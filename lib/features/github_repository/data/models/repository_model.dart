import '../../domain/entities/repository.dart';

import 'owner_model.dart';

class RepositoryModel extends RepositoryEntity {
  const RepositoryModel({
    required super.id,
    required super.name,
    required super.fullName,
    required super.description,
    required super.isPrivate,
    required super.owner,
    required super.stars,
    required super.forks,
    required super.openIssues,
    required super.language,
    required super.defaultBranch,
    required super.visibility,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'],
      name: json['name'],
      fullName: json['full_name'],
      description: json['description'] ?? '',
      isPrivate: json['private'],
      owner: OwnerModel.fromJson(json['owner']),
      stars: json['stargazers_count'],
      forks: json['forks_count'],
      openIssues: json['open_issues_count'],
      language: json['language'] ?? '',
      defaultBranch: json['default_branch'],
      visibility: json['visibility'],
    );
  }

  /// For local storage (SharedPreferences / Hive / Isar)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'description': description,
      'private': isPrivate,
      'owner': (owner as OwnerModel).toJson(),
      'stargazers_count': stars,
      'forks_count': forks,
      'open_issues_count': openIssues,
      'language': language,
      'default_branch': defaultBranch,
      'visibility': visibility,
    };
  }
}
