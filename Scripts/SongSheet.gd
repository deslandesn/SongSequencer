class_name SongSheet

var length : int
var height : int
var size : int
var BPM : float = 0.2
var Dic = {}

func _init(song_length:int, song_height:int):
	length = song_length
	height = song_height
	for x in length:
		for y in height:
			Dic[str(Vector2(x,y))]={
				"Selected": false,
				"Position": str(Vector2(x,y))
			}
			
func IsValidNote(x:int,y:int) -> bool:
	var position = Vector2(x,y)
	var validNote:bool = Dic[position]["Selected"]
	return validNote

func SetBPM(bpm:float):
	BPM = bpm
	
func SetNote(x:int,y:int,sel:bool):
	Dic[str(Vector2(x,y))]={
		"Selected": sel,
		"Position": str(Vector2(x,y))
	}
	print(Dic[str(Vector2(x,y))])

func GetNotesAtBar(bar:int):
	var notes = {}
	for y in height:
		notes[y] = Dic[str(Vector2(bar,y))]
	return notes
