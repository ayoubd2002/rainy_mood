import '../../../../core/usecase/usecase.dart';
import '../entities/sound_entity.dart';
import '../repositories/audio_repository.dart';

class PlaySound implements UseCase<void, PlaySoundParams> {
  final AudioRepository repository;

  PlaySound(this.repository);

  @override
  Future<void> call(PlaySoundParams params) async {
    return await repository.playSound(params.sound);
  }
}

class PlaySoundParams {
  final SoundEntity sound;

  PlaySoundParams(this.sound);
}
