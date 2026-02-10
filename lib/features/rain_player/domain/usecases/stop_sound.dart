import '../../../../core/usecase/usecase.dart';
import '../repositories/audio_repository.dart';

class StopSound implements UseCase<void, NoParams> {
  final AudioRepository repository;

  StopSound(this.repository);

  @override
  Future<void> call(NoParams params) async {
    return await repository.stopSound();
  }
}
