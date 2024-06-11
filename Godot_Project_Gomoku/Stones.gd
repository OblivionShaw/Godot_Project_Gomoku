extends GridContainer

@export var sprite1: Texture = preload("res://stone1.png")
@export var sprite2: Texture = preload("res://stone2.png")
@onready var grid_container = %Stones
var stone_scene = preload("res://stone.tscn")
var board = [] # 宣告一個陣列有225格負責記錄棋局狀況
var BOARD_SIZE = 15

func _ready():
	if grid_container == null:
		var grid_container = %Stones
	grid_container.columns = BOARD_SIZE
	board.resize(BOARD_SIZE * BOARD_SIZE) # 初始化棋盤陣列
	_nextRoundSpawn()

func _nextRoundSpawn():
	# 刪除grid_container的所有子節點
	for child in grid_container.get_children():
		child.queue_free()

	for i in range(BOARD_SIZE):
		for j in range(BOARD_SIZE):
			var stone_instance = stone_scene.instantiate()
			grid_container.add_child(stone_instance)
			stone_instance.modulate = Color(1, 1, 1, 0)
			var index = i * BOARD_SIZE + j # 計算按鈕的順位
			stone_instance.pressed.connect(self._button_pressed.bind(index))

func _button_pressed(index):
	# 在這裡處理按鈕被按下的事件
	var button = grid_container.get_child(index)
	button.disabled = true
	button.modulate = Color(1, 1, 1, 1) # 將按鈕變為不透明
	if GameManager.player == 1:
		button.icon = sprite1
		board[index] = 1
	elif GameManager.player == 2:
		button.icon = sprite2
		board[index] = 2

	if _check_victory(index):
		GameManager.playerTips.text = "yesyesyes"
		print("Player " + str(GameManager.player) + " wins!")
		# 玩家勝利後的處理，比如禁用所有按鈕
		for i in range(BOARD_SIZE * BOARD_SIZE):
			grid_container.get_child(i).disabled = true
	else:
		GameManager._switchPlayer()

func _check_victory(position):
	# 檢查四個方向是否有連續五個相同顏色的棋子
	var player = board[position]
	# 水平方向, 垂直方向, 正斜方向, 反斜方向
	return _check_line(player, position, 1, 0) or \
		   _check_line(player, position, 0, 1) or \
		   _check_line(player, position, 1, 1) or \
		   _check_line(player, position, -1, 1)

func _check_line(player, position, dx, dy):
	var count = 1 # 起始點已經有一個棋子
	var x = position % BOARD_SIZE
	var y = position / BOARD_SIZE
	var new_x = x + dx
	var new_y = y + dy
	while new_x >= 0 and new_x < BOARD_SIZE and new_y >= 0 and new_y < BOARD_SIZE and board[new_y * BOARD_SIZE + new_x] == player:
		count += 1
		new_x += dx
		new_y += dy
	new_x = x - dx
	new_y = y - dy
	while new_x >= 0 and new_x < BOARD_SIZE and new_y >= 0 and new_y < BOARD_SIZE and board[new_y * BOARD_SIZE + new_x] == player:
		count += 1
		new_x -= dx
		new_y -= dy
	return count >= 5 # 如果連續棋子數量大於等於5，則返回真


func _on_next_round_button_pressed():
	_nextRoundSpawn()
	GameManager.player = 1
	pass # Replace with function body.
