extends TileMap

var GridWidth = 15
var GridHeight = 9
var Dic = {}
var prevCell
var currentSongSheet:SongSheet

func _ready():
	currentSongSheet = SongSheet.new(GridWidth,GridHeight)
	for x in currentSongSheet.length:
		for y in currentSongSheet.height:
			currentSongSheet.SetNote(x,y,false)
			set_cell(0,Vector2(x,y), 0, Vector2i(0,0),0)
			

func _process(delta):
	var tile = local_to_map(get_global_mouse_position())
	
	if prevCell:
		set_cell(2,prevCell, -1, Vector2i(0,0),0)
		
	prevCell = tile;
	if(_checkIfInGrid(tile)):
		set_cell(2,tile, 2, Vector2i(0,0),0)
	
	if Input.is_action_just_released("SelectItem"):
		if(_checkIfInGrid(tile)):
			set_cell(1,tile, 1, Vector2i(0,0),0)
			currentSongSheet.SetNote(tile.x,tile.y,true)
			playNotePreview(tile.y)
		
	if Input.is_action_just_released("RemoveItem"):
		if(_checkIfInGrid(tile)):
			set_cell(1,tile, 0, Vector2i(0,0),0)
			currentSongSheet.SetNote(tile.x,tile.y,false)

func _checkIfInGrid(position:Vector2):
	if position.x < GridWidth && position.y < GridHeight:
		return true
	return false

func _on_play_song_button_down():
	$"../SongPlayer".PlaySong(currentSongSheet)
	
func playNotePreview(note:int):
	var pitch = pow(2, note/12.0)
	$AudioPreview.pitch_scale = pitch
	$AudioPreview.play()


	
