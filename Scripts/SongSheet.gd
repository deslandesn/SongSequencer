class_name SongSheet

var audio:AudioStream
var length : int = 15
var height : int = 9
var size : int
var Dic = {}

func _init(song_length:int, song_height:int, song_audio:AudioStream):
	length = song_length
	height = song_height
	audio = song_audio
	for x in length:
		for y in height:
			Dic[str(Vector2(x,y))]={
				"Selected": false,
				"Position": str(Vector2(x,y))
			}
			#print(Dic[str(Vector2(x,y))])
			
func IsValidNote(x:int,y:int) -> bool:
	var position = str(Vector2(x,y))
	var validNote:bool = Dic[position]["Selected"]
	return validNote
	
func SetNote(x:int,y:int,sel:bool):
	Dic[str(Vector2(x,y))]={
		"Selected": sel,
		"Position": str(Vector2(x,y))
	}
func GetNotesAtBar(bar:int):
	var notes = {}
	for y in height:
		notes[y] = Dic[str(Vector2(bar,y))]
	return notes
