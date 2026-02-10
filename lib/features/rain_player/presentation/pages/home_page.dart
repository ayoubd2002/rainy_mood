import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/rain_player_bloc.dart';
import '../bloc/rain_player_event.dart';
import '../bloc/rain_player_state.dart';
import '../../domain/entities/sound_entity.dart';
import '../widgets/rain_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Available rain sounds
  static const List<SoundEntity> rainSounds = [
    SoundEntity(name: 'Light Rain', assetPath: 'light_rain.mp3'),
    SoundEntity(name: 'Heavy Rain', assetPath: 'heavy_rain.mp3'),
    SoundEntity(name: 'Thunder Rain', assetPath: 'thunder_rain.mp3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: BlocBuilder<RainPlayerBloc, RainPlayerState>(
        builder: (context, state) {
          final isPlaying = state is RainPlayerPlaying;

          return RainBackground(
            isPlaying: isPlaying,
            child: Container(
            
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF0F2027),
                    const Color(0xFF203A43),
                    const Color(0xFF2C5364),
                  ],
                ),
              ),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Title with gradient
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFFE4E4E4),
                                        Color(0xFF4A90E2),
                                      ],
                                    ).createShader(bounds),
                                child: const Text(
                                  'RainFocus',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 3,
                                    shadows: [
                                      Shadow(
                                        color: Color(0xFF4A90E2),
                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: const Text(
                                  'Ambient rain sounds for focus',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFB0C4DE),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 64),

                              // Current playing status
                              if (state is RainPlayerPlaying) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 18,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.3),
                                        const Color(
                                          0xFF16213E,
                                        ).withOpacity(0.5),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(
                                        0xFF4A90E2,
                                      ).withOpacity(0.5),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF4A90E2,
                                        ).withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF4A90E2,
                                          ).withOpacity(0.3),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.music_note,
                                          color: Color(0xFF4A90E2),
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Now Playing',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF9E9E9E),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            state.soundName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFFE4E4E4),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 48),
                              ],

                              if (state is RainPlayerStopped) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Text(
                                    'No sound playing',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF9E9E9E),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 48),
                              ],

                              // Sound buttons
                              ...rainSounds.map((sound) {
                                final isPlayingSound =
                                    state is RainPlayerPlaying &&
                                    state.soundName == sound.name;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: _SoundButton(
                                    sound: sound,
                                    isPlaying: isPlayingSound,
                                    onTap: () {
                                      if (isPlayingSound) {
                                        context.read<RainPlayerBloc>().add(
                                          const StopSoundEvent(),
                                        );
                                      } else {
                                        context.read<RainPlayerBloc>().add(
                                          PlaySoundEvent(sound),
                                        );
                                      }
                                    },
                                  ),
                                );
                              }),

                              const SizedBox(height: 32),

                              // Stop button
                              _StopButton(
                                isEnabled: state is RainPlayerPlaying,
                                onTap: () {
                                  if (state is RainPlayerPlaying) {
                                    context.read<RainPlayerBloc>().add(
                                      const StopSoundEvent(),
                                    );
                                  }
                                },
                              ),

                              const SizedBox(height: 48),

                              // Volume control
                              if (state is RainPlayerPlaying) ...[
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.volume_down,
                                            color: Color(0xFF9E9E9E),
                                            size: 20,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Volume',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFFB0C4DE),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Icon(
                                            Icons.volume_up,
                                            color: Color(0xFF9E9E9E),
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      SliderTheme(
                                        data: SliderThemeData(
                                          trackHeight: 6,
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                                enabledThumbRadius: 12,
                                              ),
                                          overlayShape:
                                              const RoundSliderOverlayShape(
                                                overlayRadius: 20,
                                              ),
                                        ),
                                        child: Slider(
                                          value: state.volume,
                                          min: 0.0,
                                          max: 1.0,
                                          activeColor: const Color(0xFF4A90E2),
                                          inactiveColor: const Color(
                                            0xFF2A2A3E,
                                          ),
                                          onChanged: (value) {
                                            context.read<RainPlayerBloc>().add(
                                              VolumeChangedEvent(value),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                              // Error message
                              if (state is RainPlayerError) ...[
                                const SizedBox(height: 24),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(
                                          0xFFE94560,
                                        ).withOpacity(0.2),
                                        const Color(
                                          0xFFE94560,
                                        ).withOpacity(0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(
                                        0xFFE94560,
                                      ).withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFFE94560,
                                          ).withOpacity(0.3),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.error_outline,
                                          color: Color(0xFFE94560),
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          state.message,
                                          style: const TextStyle(
                                            color: Color(0xFFE94560),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SoundButton extends StatelessWidget {
  final SoundEntity sound;
  final bool isPlaying;
  final VoidCallback onTap;

  const _SoundButton({
    required this.sound,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isPlaying
            ? [
                BoxShadow(
                  color: const Color(0xFF4A90E2).withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 24),
            decoration: BoxDecoration(
              gradient: isPlaying
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF4A90E2),
                        const Color(0xFF357ABD),
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                    ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isPlaying
                    ? const Color(0xFF4A90E2).withOpacity(0.8)
                    : Colors.white.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isPlaying
                        ? Colors.white.withOpacity(0.2)
                        : Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  sound.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isPlaying ? Colors.white : const Color(0xFFE4E4E4),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StopButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onTap;

  const _StopButton({required this.isEnabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: const Color(0xFFE94560).withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onTap : null,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: isEnabled
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFE94560),
                        const Color(0xFFC73650),
                      ],
                    )
                  : LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.05),
                        Colors.white.withOpacity(0.02),
                      ],
                    ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isEnabled
                    ? const Color(0xFFE94560).withOpacity(0.6)
                    : Colors.white.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.stop_rounded,
                  size: 24,
                  color: isEnabled
                      ? Colors.white
                      : Colors.white.withOpacity(0.3),
                ),
                const SizedBox(width: 12),
                Text(
                  'Stop',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isEnabled
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
