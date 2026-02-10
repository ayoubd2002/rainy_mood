import '../../domain/entities/sound_entity.dart';
import '../../domain/repositories/audio_repository.dart';
import '../datasources/audio_player_service.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioPlayerService audioPlayerService;

  AudioRepositoryImpl(this.audioPlayerService);

  @override
  Future<void> playSound(SoundEntity sound) async {
    // Build full asset path: assets/sounds/filename.mp3
    // The audio service will handle platform-specific source types
    String fullAssetPath = sound.assetPath;
    
    // If it's just a filename, prepend the full path
    if (!fullAssetPath.startsWith('assets/')) {
      if (fullAssetPath.startsWith('sounds/')) {
        fullAssetPath = 'assets/$fullAssetPath';
      } else {
        fullAssetPath = 'assets/sounds/$fullAssetPath';
      }
    }
    
    await audioPlayerService.playAsset(fullAssetPath);
  }

  @override
  Future<void> stopSound() async {
    await audioPlayerService.stop();
  }

  @override
  Future<void> setVolume(double volume) async {
    await audioPlayerService.setVolume(volume);
  }

  @override
  Future<void> dispose() async {
    await audioPlayerService.dispose();
  }
}
