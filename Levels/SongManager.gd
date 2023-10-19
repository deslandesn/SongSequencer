extends Node2D

@export var BassAudioSample:AudioStream
@export var GuitarAudioSample:AudioStream

#song_length:int, song_height:int, song_audio:AudioStream
@onready var GuitarSongSheet = SongSheet.new(16,9,GuitarAudioSample)
@onready var BassSongSheet = SongSheet.new(16,9,BassAudioSample)
var currentSongSheet:SongSheet

@onready var NotePlacer = get_node("SongTiles")
@onready var SongPlayer = get_node("SongPlayer")

func _ready():
	currentSongSheet = GuitarSongSheet
	NotePlacer.LoadSongsheet(GuitarSongSheet)
	
func _on_guitar_button_button_down():
	currentSongSheet = GuitarSongSheet
	NotePlacer.LoadSongsheet(GuitarSongSheet)

func _on_bass_guitar_button_down():
	currentSongSheet = BassSongSheet
	NotePlacer.LoadSongsheet(BassSongSheet)

func _on_play_button_button_down():
	var songs = [currentSongSheet]
	SongPlayer.PlaySongs(songs);

func _on_play_all_button_button_down():
	var songs = [GuitarSongSheet,BassSongSheet]
	SongPlayer.PlaySongs(songs);

func _on_stop_button_button_down():
	SongPlayer.StopSong()# Replace with function body.

func _on_h_slider_value_changed(value):
	SongPlayer.setNotePerSecond(value)
