import '../../../../core/usecase/usecase.dart';
import '../repositories/audio_repository.dart';

class SetVolume implements UseCase<void, SetVolumeParams> {
  final AudioRepository repository;

  SetVolume(this.repository);

  @override
  Future<void> call(SetVolumeParams params) async {
    return await repository.setVolume(params.volume);
  }
}

class SetVolumeParams {
  final double volume;

  SetVolumeParams(this.volume);
}
