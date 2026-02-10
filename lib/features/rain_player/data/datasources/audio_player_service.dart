import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  /// Plays an audio asset. Uses BytesSource for Web and AssetSource for mobile platforms.
  /// 
  /// [fullAssetPath] should be the full path from root, e.g., 'assets/sounds/light_rain.mp3'
  Future<void> playAsset(String fullAssetPath) async {
    try {
      // Stop any currently playing sound before starting a new one
      await _audioPlayer.stop();
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);

      // For Web, use BytesSource to avoid format errors
      if (kIsWeb) {
        final ByteData data = await rootBundle.load(fullAssetPath);
        final Uint8List bytes = data.buffer.asUint8List();
        await _audioPlayer.play(BytesSource(bytes));
      } else {
        // For mobile platforms (Android/iOS), use AssetSource
        // Remove 'assets/' prefix as AssetSource expects path relative to assets folder
        String assetPath = fullAssetPath;
        if (assetPath.startsWith('assets/')) {
          assetPath = assetPath.replaceFirst('assets/', '');
        }
        await _audioPlayer.play(AssetSource(assetPath));
      }
    } catch (e) {
      throw Exception('Failed to play audio: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      throw Exception('Failed to stop audio: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
    } catch (e) {
      throw Exception('Failed to set volume: $e');
    }
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
