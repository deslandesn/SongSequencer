extends Node

var songSheets = []
var soundPlayers = []

var songSheet:SongSheet
var currPos:int = 0
var nps:float = 1
# Songsheet : soundPlayerArrayIndex
#var soundDictionary = {}

func AddSong(newSong:SongSheet):
	songSheets.Append(newSong)
	
func PlaySongs(allSheets):
	print("Playing all")
	for i in allSheets:
		print("Song sheet added")
	songSheets = allSheets
	initAllAudioSongs()
	$SongTimer.wait_time = 1 / nps
	$SongTimer.start()
	
func setNotePerSecond(newNPS:int):
	nps = newNPS

func initAllAudioSongs():
	soundPlayers = []
	for i in songSheets.size():
		
		print("song")
		var currSongSheet = songSheets[i]
		var soundPlayerArray = []
		for x in currSongSheet.height:
			var aPlayer = AudioStreamPlayer.new()
			aPlayer.stream = currSongSheet.audio
			aPlayer.pitch_scale = pow(2, x/12.0)
			add_child(aPlayer)
			soundPlayerArray.append(aPlayer)
		soundPlayers.append(soundPlayerArray)
		
func _on_song_timer_timeout():
	print("Tick")
	var trackEnd = true
	for song in songSheets.size():
		if songSheets[song].length > currPos:
			trackEnd = false
		else:
			continue
				
		var notes = songSheets[song].GetNotesAtBar(currPos)
		for key in notes.size():
			var playable = notes[key]["Selected"]
			if playable:
				soundPlayers[song][key].play()
	currPos = currPos + 1
	if trackEnd:
		StopSong()	
		
func StopSong():
	$SongTimer.stop()
	currPos = 0	
	
func playNote(note:int):
	soundPlayers[note].play()
