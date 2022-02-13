import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:napster_bloc/src/models/tracks_model.dart';
import 'package:napster_bloc/src/widgets/buttons/button_add_to_collectoin.dart';
import 'package:rxdart/rxdart.dart';

import 'common.dart';

class Player extends StatefulWidget {
  final Track currentTrack;
  final bool showBtnLike;
  final bool autoPlay;

  const Player(
    this.currentTrack, {
    this.showBtnLike = true,
    this.autoPlay = false,
    Key? key,
  }) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final AudioPlayer _player = AudioPlayer();

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    if (widget.autoPlay) {
      _player.play();
    }
    return SizedBox(
      height: 200,
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Первая строка это слева картинка, а справа информация о треке и альбом
              Row(
                children: [
                  // Картинка альбома
                  SizedBox(
                    height: 85,
                    child: Align(
                      alignment: Alignment.center,
                      child: widget.currentTrack.imagePreview,
                    ),
                  ),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Альбом: ${widget.currentTrack.albumName}',
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                            child: Text(
                              widget.currentTrack.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ShowButtonAddToCollectoin(
                              currentTrack: widget.currentTrack,
                              showBtnLike: widget.showBtnLike),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Вторая строка это кнопка запуска/пауза и прогресс проигрывания
              Row(
                children: [
                  StreamBuilder<PlayerState>(
                    stream: _player.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState;
                      final playing = playerState?.playing;
                      const double iconSize = 40.0;
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          width: iconSize,
                          height: iconSize,
                          child: const CircularProgressIndicator(),
                        );
                      } else if (playing != true) {
                        return IconButton(
                          icon: const Icon(Icons.play_arrow),
                          iconSize: iconSize,
                          onPressed: _player.play,
                        );
                      } else if (processingState != ProcessingState.completed) {
                        return IconButton(
                          icon: const Icon(Icons.pause),
                          iconSize: iconSize,
                          onPressed: _player.pause,
                        );
                      } else {
                        return IconButton(
                          icon: const Icon(Icons.replay),
                          iconSize: iconSize,
                          onPressed: () => _player.seek(Duration.zero),
                        );
                      }
                    },
                  ),
                  Expanded(
                    child: StreamBuilder<PositionData>(
                      stream: _positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        return SeekBar(
                          duration: positionData?.duration ?? Duration.zero,
                          position: positionData?.position ?? Duration.zero,
                          bufferedPosition:
                              positionData?.bufferedPosition ?? Duration.zero,
                          onChangeEnd: _player.seek,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initPlayer();
    super.initState();
  }

  Future<void> _initPlayer() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    _player.playbackEventStream
        .listen((event) {}, onError: (Object e, StackTrace stackTrace) {});

    try {
      await _player.setAudioSource(
          AudioSource.uri(Uri.parse(widget.currentTrack.previewURL)));
    } catch (e) {
      //  print("Error loading audio source: $e");
    }
  }
}
