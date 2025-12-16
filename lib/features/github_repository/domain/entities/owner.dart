// import 'package:equatable/equatable.dart';

// class Owner extends Equatable {
//   final int id;
//   final String login;
//   final String avatarUrl;
//   final String htmlUrl;
//   final String type;

//   const Owner({
//     required this.id,
//     required this.login,
//     required this.avatarUrl,
//     required this.htmlUrl,
//     required this.type,
//   });

//   @override
//   // TO DO: implement props
//   List<Object?> get props => [id, login, avatarUrl, htmlUrl, type];
// }
import 'package:equatable/equatable.dart';

class OwnerEntity extends Equatable {
  final String? login;
  final int? id;
  final String? nodeId;
  final String? avatarUrl;
  final String? gravatarId;
  final String? url;
  final String? htmlUrl;
  final String? followersUrl;
  final String? followingUrl;
  final String? gistsUrl;
  final String? starredUrl;
  final String? subscriptionsUrl;
  final String? organizationsUrl;
  final String? reposUrl;
  final String? eventsUrl;
  final String? receivedEventsUrl;
  final String? type;
  final String? userViewType;
  final bool? siteAdmin;

  const OwnerEntity({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.userViewType,
    this.siteAdmin,
  });

  @override
  List<Object?> get props => [
        login,
        id,
        nodeId,
        avatarUrl,
        gravatarId,
        url,
        htmlUrl,
        followersUrl,
        followingUrl,
        gistsUrl,
        starredUrl,
        subscriptionsUrl,
        organizationsUrl,
        reposUrl,
        eventsUrl,
        receivedEventsUrl,
        type,
        userViewType,
        siteAdmin,
      ];
}
