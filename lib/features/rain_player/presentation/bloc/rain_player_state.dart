import 'package:equatable/equatable.dart';

abstract class RainPlayerState extends Equatable {
  const RainPlayerState();

  @override
  List<Object> get props => [];
}

class RainPlayerInitial extends RainPlayerState {
  const RainPlayerInitial();
}

class RainPlayerPlaying extends RainPlayerState {
  final String soundName;
  final double volume;

  const RainPlayerPlaying({
    required this.soundName,
    required this.volume,
  });

  @override
  List<Object> get props => [soundName, volume];
}

class RainPlayerStopped extends RainPlayerState {
  const RainPlayerStopped();
}

class RainPlayerError extends RainPlayerState {
  final String message;

  const RainPlayerError(this.message);

  @override
  List<Object> get props => [message];
}
