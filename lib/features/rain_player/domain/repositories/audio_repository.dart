import '../entities/sound_entity.dart';

abstract class AudioRepository {
  Future<void> playSound(SoundEntity sound);
  Future<void> stopSound();
  Future<void> setVolume(double volume);
  Future<void> dispose();
}
