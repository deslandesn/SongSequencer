extends TileMap

var GridWidth = 15
var GridHeight = 9
var prevCell:Vector2i
@export var audioSample:AudioStream
var currentSongSheet:SongSheet

func _ready():
	$AudioPreview.stream = audioSample
	currentSongSheet = SongSheet.new(GridWidth,GridHeight,audioSample)
	for x in currentSongSheet.length:
		for y in currentSongSheet.height:
			currentSongSheet.SetNote(x,y,false)
			set_cell(0,Vector2(x,y), 0, Vector2i(0,0),0)
			
func LoadSongsheet(newSongSheet:SongSheet):
	currentSongSheet = newSongSheet
	$AudioPreview.stream = currentSongSheet.audio
	GridWidth = newSongSheet.length;
	GridHeight = newSongSheet.height;
	for x in currentSongSheet.length:
		for y in currentSongSheet.height:
			set_cell(1,Vector2(x,y), 0, Vector2i(0,0),0)
			if(currentSongSheet.IsValidNote(x,y)):
				set_cell(1,Vector2(x,y), 1, Vector2i(0,0),0)

func _process(delta):
	var tile = local_to_map(get_local_mouse_position())
	
	# clear previous cell
	if tile!=prevCell:
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

func _checkIfInGrid(inPosition:Vector2):
	if inPosition.x < GridWidth && inPosition.x >= 0 && inPosition.y < GridHeight && inPosition.y >= 0:
		return true
	return false
	
func playNotePreview(note:int):
	var pitch = pow(2, note/12.0)
	$AudioPreview.pitch_scale = pitch
	$AudioPreview.play()


	
