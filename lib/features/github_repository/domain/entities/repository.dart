import 'package:equatable/equatable.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/entities/owner.dart';

class RepositoryEntity extends Equatable {
  final int id;
  final String name;
  final String fullName;
  final String description;
  final bool isPrivate;
  final Owner owner;
  final int stars;
  final int forks;
  final int openIssues;
  final String language;
  final String defaultBranch;
  final String visibility;

  const RepositoryEntity({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.isPrivate,
    required this.owner,
    required this.stars,
    required this.forks,
    required this.openIssues,
    required this.language,
    required this.defaultBranch,
    required this.visibility,
  });

  @override
  // TO DO: implement props
  List<Object?> get props => [
        id,
        name,
        fullName,
        description,
        isPrivate,
        owner,
        stars,
        forks,
        openIssues,
        language,
        defaultBranch,
        visibility,
      ];
}
