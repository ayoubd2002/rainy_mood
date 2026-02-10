import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/play_sound.dart';
import '../../domain/usecases/stop_sound.dart';
import '../../domain/usecases/set_volume.dart';
import '../../../../core/usecase/usecase.dart';
import 'rain_player_event.dart';
import 'rain_player_state.dart';

class RainPlayerBloc extends Bloc<RainPlayerEvent, RainPlayerState> {
  final PlaySound playSound;
  final StopSound stopSound;
  final SetVolume setVolume;

  RainPlayerBloc({
    required this.playSound,
    required this.stopSound,
    required this.setVolume,
  }) : super(const RainPlayerInitial()) {
    on<PlaySoundEvent>(_onPlaySound);
    on<StopSoundEvent>(_onStopSound);
    on<VolumeChangedEvent>(_onVolumeChanged);
  }

  Future<void> _onPlaySound(
    PlaySoundEvent event,
    Emitter<RainPlayerState> emit,
  ) async {
    try {
      await playSound(PlaySoundParams(event.sound));
      emit(RainPlayerPlaying(
        soundName: event.sound.name,
        volume: state is RainPlayerPlaying
            ? (state as RainPlayerPlaying).volume
            : 0.5,
      ));
    } catch (e) {
      emit(RainPlayerError('Failed to play sound: ${e.toString()}'));
    }
  }

  Future<void> _onStopSound(
    StopSoundEvent event,
    Emitter<RainPlayerState> emit,
  ) async {
    try {
      await stopSound(NoParams());
      emit(const RainPlayerStopped());
    } catch (e) {
      emit(RainPlayerError('Failed to stop sound: ${e.toString()}'));
    }
  }

  Future<void> _onVolumeChanged(
    VolumeChangedEvent event,
    Emitter<RainPlayerState> emit,
  ) async {
    try {
      await setVolume(SetVolumeParams(event.volume));
      if (state is RainPlayerPlaying) {
        final currentState = state as RainPlayerPlaying;
        emit(RainPlayerPlaying(
          soundName: currentState.soundName,
          volume: event.volume,
        ));
      }
    } catch (e) {
      emit(RainPlayerError('Failed to change volume: ${e.toString()}'));
    }
  }
}
