extends Node
@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_over()
	
func new_game(): 
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Ludanto.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$Music.play()
	$HUD.show_message("Pretigxu !")
	


func _on_mob_timer_timeout() -> void:
	score+=1
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation+PI/2
	mob.position = mob_spawn_location.position
	
	direction+=randf_range(-PI/4, PI/4)
	mob.rotation = direction 
	
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
	
func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	
func _on_score_timer_timeout() -> void:
	$HUD.update_score(score)
