import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String type;

  const Owner({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.type,
  });

  @override
  // TO DO: implement props
  List<Object?> get props => [id, login, avatarUrl, htmlUrl, type];
}
