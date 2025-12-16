import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_github_explorer/core/network/network_info.dart';
import 'package:flutter_github_explorer/core/utils/sort_preference_manager.dart';
import 'package:flutter_github_explorer/features/github_repository/data/datasources/repository_local_datasource.dart';
import 'package:flutter_github_explorer/features/github_repository/data/datasources/repository_remote_datasource.dart';
import 'package:flutter_github_explorer/features/github_repository/data/repositories/repository_repository_impl.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/repositories/repository_repository.dart';
import 'package:flutter_github_explorer/features/github_repository/domain/usecases/get_repositories.dart';
import 'package:flutter_github_explorer/features/github_repository/presentation/bloc/repository_list/repository_list_bloc.dart';
import 'package:flutter_github_explorer/features/theme/bloc/theme_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => RepositoryListBloc(
        getRepositories: sl(),
        networkInfo: sl(),
        sortPreferenceManager: sl(),
      ));

  sl.registerLazySingleton(() => GetRepositories(sl()));

  sl.registerLazySingleton<RepositoryRepository>(() => RepositoryRepositoryImpl(
        networkInfo: sl(),
        remoteDatasource: sl(),
        localDatasource: sl(),
      ));

  final client = http.Client();

  sl.registerLazySingleton<RepositoryRemoteDatasource>(
      () => RepositoryRemoteDatasourceImpl(client));

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<RepositoryLocalDatasource>(
      () => RepositoryLocalDatasourceImpl(prefs));

  sl.registerLazySingleton(() => SortPreferenceManager(prefs));

  // Connectivity
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerFactory(() => ThemeBloc(preferences: prefs));
}
