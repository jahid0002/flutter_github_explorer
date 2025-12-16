class Constants {
  static const String baseUrl = 'https://api.github.com';

  static const String searchRepositoriesEndpoint =
      '/search/repositories?q=flutter&sort=stars&order=desc&per_page=50';

//  static const String sortBy = 'sort';
  static const String sortByStars = 'stars';
  static const String sortByUpdated = 'updated';

  static const String sortByForks = 'forks';
}

//https://api.github.com/search/repositories?q=flutter&sort=stars&order=desc&per_page=50
