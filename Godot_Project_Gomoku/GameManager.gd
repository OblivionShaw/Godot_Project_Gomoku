extends Node

@export var player = 1

@onready var playerTips = %Tips
@onready var label = $"../Game/Node/Label"

func _ready():
	if is_instance_valid(playerTips):
		playerTips.text = "玩家1行動"
	else:
		print("Error: 'Tips' node not found or not ready.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _switchPlayer():
	print(player)
	
	label = "HI"
	if is_instance_valid(playerTips):
		playerTips.text = "玩家1行動"
	else:
		playerTips = "../Game/Node/Tips"
		#playerTips.text = player
		
	if player == 1:
		player = 2
	else:
		player = 1
	
