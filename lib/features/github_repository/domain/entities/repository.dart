import 'package:equatable/equatable.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/entities/owner.dart';

class RepositoryEntity extends Equatable {
  final int? id;
  final String? nodeId;
  final String? name;
  final String? fullName;
  final bool? isPrivate;
  final OwnerEntity? owner;
  final String? htmlUrl;
  final String? description;
  final bool? fork;

  final String? url;
  final String? forksUrl;
  final String? keysUrl;
  final String? collaboratorsUrl;
  final String? teamsUrl;
  final String? hooksUrl;
  final String? issueEventsUrl;
  final String? eventsUrl;
  final String? assigneesUrl;
  final String? branchesUrl;
  final String? tagsUrl;
  final String? blobsUrl;
  final String? gitTagsUrl;
  final String? gitRefsUrl;
  final String? treesUrl;
  final String? statusesUrl;
  final String? languagesUrl;
  final String? stargazersUrl;
  final String? contributorsUrl;
  final String? subscribersUrl;
  final String? subscriptionUrl;
  final String? commitsUrl;
  final String? gitCommitsUrl;
  final String? commentsUrl;
  final String? issueCommentUrl;
  final String? contentsUrl;
  final String? compareUrl;
  final String? mergesUrl;
  final String? archiveUrl;
  final String? downloadsUrl;
  final String? issuesUrl;
  final String? pullsUrl;
  final String? milestonesUrl;
  final String? notificationsUrl;
  final String? labelsUrl;
  final String? releasesUrl;
  final String? deploymentsUrl;

  final String? createdAt;
  final String? updatedAt;
  final String? pushedAt;

  final String? gitUrl;
  final String? sshUrl;
  final String? cloneUrl;
  final String? svnUrl;
  final String? homepage;

  final int? size;
  final int? stargazersCount;
  final int? watchersCount;
  final String? language;

  final bool? hasIssues;
  final bool? hasProjects;
  final bool? hasDownloads;
  final bool? hasWiki;
  final bool? hasPages;
  final bool? hasDiscussions;

  final int? forksCount;
  final bool? archived;
  final bool? disabled;
  final int? openIssuesCount;

  // final LicenseEntity? license;

  final bool? allowForking;
  final bool? isTemplate;
  final bool? webCommitSignoffRequired;

  final List<String>? topics;
  final String? visibility;

  final int? forks;
  final int? openIssues;
  final int? watchers;

  final String? defaultBranch;
  final double? score;

  const RepositoryEntity({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.isPrivate,
    this.owner,
    this.htmlUrl,
    this.description,
    this.fork,
    this.url,
    this.forksUrl,
    this.keysUrl,
    this.collaboratorsUrl,
    this.teamsUrl,
    this.hooksUrl,
    this.issueEventsUrl,
    this.eventsUrl,
    this.assigneesUrl,
    this.branchesUrl,
    this.tagsUrl,
    this.blobsUrl,
    this.gitTagsUrl,
    this.gitRefsUrl,
    this.treesUrl,
    this.statusesUrl,
    this.languagesUrl,
    this.stargazersUrl,
    this.contributorsUrl,
    this.subscribersUrl,
    this.subscriptionUrl,
    this.commitsUrl,
    this.gitCommitsUrl,
    this.commentsUrl,
    this.issueCommentUrl,
    this.contentsUrl,
    this.compareUrl,
    this.mergesUrl,
    this.archiveUrl,
    this.downloadsUrl,
    this.issuesUrl,
    this.pullsUrl,
    this.milestonesUrl,
    this.notificationsUrl,
    this.labelsUrl,
    this.releasesUrl,
    this.deploymentsUrl,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.gitUrl,
    this.sshUrl,
    this.cloneUrl,
    this.svnUrl,
    this.homepage,
    this.size,
    this.stargazersCount,
    this.watchersCount,
    this.language,
    this.hasIssues,
    this.hasProjects,
    this.hasDownloads,
    this.hasWiki,
    this.hasPages,
    this.hasDiscussions,
    this.forksCount,
    this.archived,
    this.disabled,
    this.openIssuesCount,
    // this.license,
    this.allowForking,
    this.isTemplate,
    this.webCommitSignoffRequired,
    this.topics,
    this.visibility,
    this.forks,
    this.openIssues,
    this.watchers,
    this.defaultBranch,
    this.score,
  });

  @override
  List<Object?> get props => [
        id,
        nodeId,
        name,
        fullName,
        isPrivate,
        owner,
        htmlUrl,
        description,
        fork,
        url,
        forksUrl,
        keysUrl,
        collaboratorsUrl,
        teamsUrl,
        hooksUrl,
        issueEventsUrl,
        eventsUrl,
        assigneesUrl,
        branchesUrl,
        tagsUrl,
        blobsUrl,
        gitTagsUrl,
        gitRefsUrl,
        treesUrl,
        statusesUrl,
        languagesUrl,
        stargazersUrl,
        contributorsUrl,
        subscribersUrl,
        subscriptionUrl,
        commitsUrl,
        gitCommitsUrl,
        commentsUrl,
        issueCommentUrl,
        contentsUrl,
        compareUrl,
        mergesUrl,
        archiveUrl,
        downloadsUrl,
        issuesUrl,
        pullsUrl,
        milestonesUrl,
        notificationsUrl,
        labelsUrl,
        releasesUrl,
        deploymentsUrl,
        createdAt,
        updatedAt,
        pushedAt,
        gitUrl,
        sshUrl,
        cloneUrl,
        svnUrl,
        homepage,
        size,
        stargazersCount,
        watchersCount,
        language,
        hasIssues,
        hasProjects,
        hasDownloads,
        hasWiki,
        hasPages,
        hasDiscussions,
        forksCount,
        archived,
        disabled,
        openIssuesCount,
        //  license,
        allowForking,
        isTemplate,
        webCommitSignoffRequired,
        topics,
        visibility,
        forks,
        openIssues,
        watchers,
        defaultBranch,
        score,
      ];
}
