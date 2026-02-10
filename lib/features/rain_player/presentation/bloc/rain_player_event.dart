import 'package:equatable/equatable.dart';
import '../../domain/entities/sound_entity.dart';

abstract class RainPlayerEvent extends Equatable {
  const RainPlayerEvent();

  @override
  List<Object> get props => [];
}

class PlaySoundEvent extends RainPlayerEvent {
  final SoundEntity sound;

  const PlaySoundEvent(this.sound);

  @override
  List<Object> get props => [sound];
}

class StopSoundEvent extends RainPlayerEvent {
  const StopSoundEvent();
}

class VolumeChangedEvent extends RainPlayerEvent {
  final double volume;

  const VolumeChangedEvent(this.volume);

  @override
  List<Object> get props => [volume];
}
