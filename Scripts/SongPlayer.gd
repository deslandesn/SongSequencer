extends Node

@export var audio:AudioStream
var songSheet:SongSheet
var currPos:int = 1
var soundPlayers = []

func PlaySong(newSong:SongSheet):
	songSheet = newSong
	initAudioPlayers()
	currPos = 0
	$SongTimer.wait_time = songSheet.BPM
	$SongTimer.start()

func initAudioPlayers():
	for i in songSheet.height:
		var aPlayer = AudioStreamPlayer.new()
		aPlayer.stream = audio
		aPlayer.pitch_scale = pow(2, i/12.0)
		add_child(aPlayer)
		soundPlayers.append(aPlayer)

func _on_song_timer_timeout():
	var notes = songSheet.GetNotesAtBar(currPos)
	for key in notes:
		var playable = notes[key]["Selected"]
		print(notes[key])
		if playable:
			playNote(key)
	currPos = currPos + 1
	if(songSheet.length-1 < currPos):
		$SongTimer.stop()

func playNote(note:int):
	soundPlayers[note].play()
