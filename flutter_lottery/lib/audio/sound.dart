import 'package:just_audio/just_audio.dart';

//感觉返回的future有问题，下次用https://github.com/bluefireteam/audioplayers试试
class Sound {
  static final Map<String, AudioPlayer> _players = {};

  static Future<void> init() async {
    final playList = ['appear.mp3', 'bg.mp3', 'error.mp3', 'hooray.mp3'];
    for (final p in playList) {
      final player = AudioPlayer();
      await player.setAsset('sound/$p', preload: false);
      _players[p] = player;
    }
    print("sound inited...");
  }

  static void dispose() {
    for (var e in _players.values) {
      e.dispose();
    }
  }

  static Future<void> play(String name, {bool loop = false}) async {
    if (_players.containsKey(name)) {
      final player = _players[name];
      if (player == null) {
        return;
      }
      player.setLoopMode(loop ? LoopMode.one : LoopMode.off);
      if(player.playing) {
        await player.stop();
      }
      await player.seek(Duration.zero);
      player.play();
    }
  }
}