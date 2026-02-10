import 'package:equatable/equatable.dart';

class SoundEntity extends Equatable {
  final String name;
  final String assetPath;

  const SoundEntity({
    required this.name,
    required this.assetPath,
  });

  @override
  List<Object> get props => [name, assetPath];
}
