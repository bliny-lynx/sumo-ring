extends Node

var num_players = 8
var bus = "Master"

var available = []  # The available players.
var queue = []  # The queue of sounds to play.
var musicplayer = null
var altplayer = null
var bg_song = load("res://audio/Summoning_musa.mp3")
var battle_song = load("res://audio/Sumo_taistelu.mp3")
var food_sounds = ["res://audio/eat_low.mp3", "res://audio/eat_normal.mp3"]
var drink_sounds = ["res://audio/drink_1.mp3", "res://audio/drink_2.mp3"]
var error_sound = "res://audio/error_koto.mp3"
var click_sound = "res://audio/sfx_click.mp3"
var gong_sound = "res://audio/sfx_gong.mp3"

func _ready():
    # Create the pool of AudioStreamPlayer nodes.
    musicplayer = AudioStreamPlayer.new()
    musicplayer.bus = "background"
    musicplayer.volume_db = -12
    musicplayer.stream = bg_song
    musicplayer.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(musicplayer)
    altplayer = AudioStreamPlayer.new()
    altplayer.bus = bus
    altplayer.volume_db = 3
    altplayer.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
    altplayer.stream = load("res://audio/koto_strings.mp3")
    add_child(altplayer)

func play_alt():
    altplayer.play()

func play_bg_music():
    musicplayer.stop()
    musicplayer.stream = bg_song
    musicplayer.play()
    musicplayer.finished.connect(func(): musicplayer.play())

func play_battle_music():
    musicplayer.stop()
    musicplayer.stream = battle_song
    musicplayer.play()
    musicplayer.finished.connect(func(): musicplayer.play())

func init_audio():
    for i in num_players:
        var p = AudioStreamPlayer.new()
        add_child(p)
        available.append(p)
        p.finished.connect(func(): _on_stream_finished(p))
        p.bus = bus

func _on_stream_finished(stream):
    # When finished playing a stream, make the player available again.
    available.append(stream)

func error_sfx():
    play(error_sound)

func click_sfx():
    play(click_sound)

func gong_sfx():
    play(gong_sound)

func drink_sfx():
    play(drink_sounds.pick_random())

func food_sfx():
    play(food_sounds.pick_random())

func play(sound_path):
    queue.append(sound_path)

func clear_effects():
    for stream_player in get_children():
        if stream_player == musicplayer or stream_player == altplayer:
            print_debug("stream player is music or crash")
            pass
        else:
            if stream_player.playing:
                stream_player.stop()
                _on_stream_finished(stream_player)

func _process(_delta):
    # Play a queued sound if any players are available.
    if not queue.is_empty() and not available.is_empty():
        available[0].stream = load(queue.pop_front())
        available[0].play()
        available.pop_front()
