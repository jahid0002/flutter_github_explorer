// import '../../domain/entities/owner.dart';

// class OwnerModel extends Owner {
//   const OwnerModel({
//     required super.id,
//     required super.login,
//     required super.avatarUrl,
//     required super.htmlUrl,
//     required super.type,
//   });

//   factory OwnerModel.fromJson(Map<String, dynamic> json) {
//     return OwnerModel(
//       id: json['id'],
//       login: json['login'],
//       avatarUrl: json['avatar_url'],
//       htmlUrl: json['html_url'],
//       type: json['type'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'login': login,
//       'avatar_url': avatarUrl,
//       'html_url': htmlUrl,
//       'type': type,
//     };
//   }
// }
import 'package:flutter_github_explorer/features/github_repository/domain/entities/owner.dart';

class OwnerModel extends OwnerEntity {
  const OwnerModel({
    super.login,
    super.id,
    super.nodeId,
    super.avatarUrl,
    super.gravatarId,
    super.url,
    super.htmlUrl,
    super.followersUrl,
    super.followingUrl,
    super.gistsUrl,
    super.starredUrl,
    super.subscriptionsUrl,
    super.organizationsUrl,
    super.reposUrl,
    super.eventsUrl,
    super.receivedEventsUrl,
    super.type,
    super.userViewType,
    super.siteAdmin,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
      gravatarId: json['gravatar_id'],
      url: json['url'],
      htmlUrl: json['html_url'],
      followersUrl: json['followers_url'],
      followingUrl: json['following_url'],
      gistsUrl: json['gists_url'],
      starredUrl: json['starred_url'],
      subscriptionsUrl: json['subscriptions_url'],
      organizationsUrl: json['organizations_url'],
      reposUrl: json['repos_url'],
      eventsUrl: json['events_url'],
      receivedEventsUrl: json['received_events_url'],
      type: json['type'],
      userViewType: json['user_view_type'],
      siteAdmin: json['site_admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'node_id': nodeId,
      'avatar_url': avatarUrl,
      'gravatar_id': gravatarId,
      'url': url,
      'html_url': htmlUrl,
      'followers_url': followersUrl,
      'following_url': followingUrl,
      'gists_url': gistsUrl,
      'starred_url': starredUrl,
      'subscriptions_url': subscriptionsUrl,
      'organizations_url': organizationsUrl,
      'repos_url': reposUrl,
      'events_url': eventsUrl,
      'received_events_url': receivedEventsUrl,
      'type': type,
      'user_view_type': userViewType,
      'site_admin': siteAdmin,
    };
  }
}
