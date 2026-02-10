import 'package:get_it/get_it.dart';
import 'features/rain_player/data/datasources/audio_player_service.dart';
import 'features/rain_player/data/repositories/audio_repository_impl.dart';
import 'features/rain_player/domain/repositories/audio_repository.dart';
import 'features/rain_player/domain/usecases/play_sound.dart';
import 'features/rain_player/domain/usecases/stop_sound.dart';
import 'features/rain_player/domain/usecases/set_volume.dart';
import 'features/rain_player/presentation/bloc/rain_player_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => RainPlayerBloc(
      playSound: sl(),
      stopSound: sl(),
      setVolume: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => PlaySound(sl()));
  sl.registerLazySingleton(() => StopSound(sl()));
  sl.registerLazySingleton(() => SetVolume(sl()));

  // Repository
  sl.registerLazySingleton<AudioRepository>(
    () => AudioRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton(() => AudioPlayerService());
}
