extends Node2D

enum STATE {START, DISADVANTANGE, VANTAGE, 
	SELECT, BATTLE, STATUS, END, ESCAPED,
	SELECT_ENEMY 
}
var cur_state = STATE.START 

var timer = 0.0
var is_menu_show = false

func _ready():
	# Tomar los enmigos
	var enemies = $Enemigos.get_children()
	$Text.show()
	var enemies_dir : Dictionary[String, int] = {}
	for i in enemies:
		var n = i.name.get_slice("_", 0)
		if enemies_dir.has(n):
			enemies_dir[n] = enemies_dir[n] + 1
		else:
			enemies_dir[n] = 1
	
	var apear_text : String = "Aparece "
	for e in enemies_dir.keys():
		if enemies_dir[e] > 1:
			apear_text += str(enemies_dir[e]) + " " + e + "s "
		else:
			apear_text += str(enemies_dir[e]) + " " + e + " "
	$Text.get_child(0).text = apear_text
	

func _process(delta):
	match cur_state:
		STATE.START:
			timer += delta
			if timer >= 2.0:
				timer = 0.0
				cur_state = STATE.SELECT
				$Text.hide()
				$Player/Comand.show()
				$Player/Comand/Attack.grab_focus()
		STATE.DISADVANTANGE:
			pass
		STATE.VANTAGE:
			pass
		STATE.SELECT:
			if is_menu_show:
				pass
			pass
		STATE.SELECT_ENEMY:
			
			
			pass
		STATE.BATTLE:
			
			
			pass
		STATE.STATUS:
			pass
		STATE.END:
			pass
		STATE.ESCAPED:
			pass
		_:
			pass
	
	if cur_state == STATE.END:
		
		pass
	
	pass


func _on_magia_pressed():
	$Menu.show()
	$Menu/options/ItemList.grab_focus()
	$Menu/options/ItemList.select(0)
	is_menu_show = true

func _on_attack_pressed():
	cur_state = STATE.SELECT_ENEMY
	pass # Replace with function body.

func _on_item_pressed():
	pass # Replace with function body.

func _on_escapar_pressed():
	pass # Replace with function body.

func _on_item_list_item_selected(index):
	cur_state = STATE.SELECT_ENEMY
	$Menu.hide()
	
