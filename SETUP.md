# RainFocus - Setup Guide

## Overview
RainFocus is a Flutter application that plays ambient rain sounds to help users study, sleep, or relax. The app works fully offline and uses Clean Architecture with BLoC pattern.

## Architecture

The app follows Clean Architecture with three main layers:

1. **Domain Layer** (`lib/features/rain_player/domain/`)
   - Entities: `SoundEntity`
   - Use Cases: `PlaySound`, `StopSound`, `SetVolume`
   - Repository Interface: `AudioRepository`

2. **Data Layer** (`lib/features/rain_player/data/`)
   - Data Sources: `AudioPlayerService`
   - Repository Implementation: `AudioRepositoryImpl`

3. **Presentation Layer** (`lib/features/rain_player/presentation/`)
   - BLoC: `RainPlayerBloc`
   - Events: `PlaySoundEvent`, `StopSoundEvent`, `VolumeChangedEvent`
   - States: `RainPlayerInitial`, `RainPlayerPlaying`, `RainPlayerStopped`, `RainPlayerError`
   - UI: `HomePage`

## Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (3.8.1 or higher)
- Android Studio / VS Code with Flutter extensions
- For Android: Android SDK
- For iOS: Xcode (macOS only)

## Installation Steps

### 1. Install Dependencies

```bash
flutter pub get
```

This will install:
- `flutter_bloc` - State management
- `audioplayers` - Audio playback
- `get_it` - Dependency injection
- `equatable` - Value equality

### 2. Add Sound Files

Place your rain sound files in the `assets/sounds/` directory:

- `light_rain.mp3`
- `heavy_rain.mp3`
- `thunder_rain.mp3`

**Important:** The sound files must be in MP3 format (or other formats supported by audioplayers).

### 3. Verify Assets Configuration

The `pubspec.yaml` file should already have the assets configured:

```yaml
flutter:
  assets:
    - assets/sounds/
```

### 4. Run the App

#### Android
```bash
flutter run
```

#### iOS (macOS only)
```bash
flutter run
```

#### Specific Device
```bash
flutter devices  # List available devices
flutter run -d <device-id>
```

## Project Structure

```
lib/
 ├── core/
 │    ├── error/
 │    │    └── failures.dart
 │    └── usecase/
 │         └── usecase.dart
 ├── features/
 │    └── rain_player/
 │         ├── data/
 │         │    ├── datasources/
 │         │    │    └── audio_player_service.dart
 │         │    └── repositories/
 │         │         └── audio_repository_impl.dart
 │         ├── domain/
 │         │    ├── entities/
 │         │    │    └── sound_entity.dart
 │         │    ├── repositories/
 │         │    │    └── audio_repository.dart
 │         │    └── usecases/
 │         │         ├── play_sound.dart
 │         │         ├── stop_sound.dart
 │         │         └── set_volume.dart
 │         └── presentation/
 │              ├── bloc/
 │              │    ├── rain_player_bloc.dart
 │              │    ├── rain_player_event.dart
 │              │    └── rain_player_state.dart
 │              └── pages/
 │                   └── home_page.dart
 ├── injection_container.dart
 └── main.dart
```

## Features

- ✅ Play rain sounds (Light Rain, Heavy Rain, Thunder Rain)
- ✅ Stop sound playback
- ✅ Loop sounds continuously
- ✅ Volume control (0.0 - 1.0)
- ✅ Clean Architecture
- ✅ BLoC state management
- ✅ Offline functionality
- ✅ Dark, calming UI theme

## Usage

1. **Play a Sound**: Tap any of the rain sound buttons (Light Rain, Heavy Rain, Thunder Rain)
2. **Stop Sound**: Tap the "Stop" button or tap the currently playing sound button again
3. **Adjust Volume**: Use the volume slider when a sound is playing
4. **Switch Sounds**: Tap a different sound button to switch between sounds

## Troubleshooting

### Sound files not playing
- Ensure sound files are in `assets/sounds/` directory
- Verify file names match exactly: `light_rain.mp3`, `heavy_rain.mp3`, `thunder_rain.mp3`
- Check that `pubspec.yaml` has the assets section configured
- Run `flutter clean` and `flutter pub get` if issues persist

### Build errors
- Run `flutter clean`
- Run `flutter pub get`
- Ensure all dependencies are compatible with your Flutter version

### Audio not working on iOS
- Check Info.plist for required audio background modes (if needed)
- Verify audio file format is supported

## Where to Get Sound Files

Free rain sound resources:
- [FreeSound.org](https://freesound.org) - Free sound effects
- [Zapsplat](https://www.zapsplat.com) - Free sound library
- [Pixabay](https://pixabay.com/music/) - Free music and sounds

## Development

### Adding New Sounds

1. Add sound file to `assets/sounds/`
2. Update `HomePage.rainSounds` list in `home_page.dart`:

```dart
static const List<SoundEntity> rainSounds = [
  // ... existing sounds
  SoundEntity(
    name: 'New Sound Name',
    assetPath: 'new_sound.mp3',
  ),
];
```

### Architecture Principles

- **Domain Layer**: Pure business logic, no dependencies on Flutter or external packages
- **Data Layer**: Implements domain interfaces, handles data sources
- **Presentation Layer**: UI and state management only
- **Dependency Rule**: Dependencies point inward (Presentation → Domain ← Data)

## License

This project is for educational purposes.
