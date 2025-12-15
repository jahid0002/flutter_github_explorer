// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/usecases/usecase.dart';
// import '../../../domain/usecases/get_repository_details.dart';
// import 'repository_details_event.dart';
// import 'repository_details_state.dart';

// class RepositoryDetailsBloc
//     extends Bloc<RepositoryDetailsEvent, RepositoryDetailsState> {
//   final GetRepositoryDetails getRepositoryDetails;

//   RepositoryDetailsBloc({
//     required this.getRepositoryDetails,
//   }) : super(RepositoryDetailsInitial()) {
//     on<LoadRepositoryDetails>(_onLoadRepositoryDetails);
//   }

//   Future<void> _onLoadRepositoryDetails(
//     LoadRepositoryDetails event,
//     Emitter<RepositoryDetailsState> emit,
//   ) async {
//     emit(RepositoryDetailsLoading());

//     final result = await getRepositoryDetails(
//       RepositoryParams(event.repositoryId),
//     );

//     result.fold(
//       (failure) => emit(RepositoryDetailsError(failure.message)),
//       (repository) => emit(RepositoryDetailsLoaded(repository)),
//     );
//   }
// }
