extends TileMap

## Note Tilemap is hidden so cannot see tiles

var ammo_pickup = preload("res://Ammo.tscn")
var mre_pickup = preload("res://MRE.tscn")
var rng = RandomNumberGenerator.new()  ##setup Random Number Generator
var used = get_used_cells() ##create a list of all tiles on the tilemap that have content
var ammo_pickups = 7
var mre_pickups = 5


func _ready():
	while ammo_pickups > 0:
		ammo_pickups -= 1
		rng.randomize() ## Change the random seed so new random number each time
		var pickup = used[rng.randi() % used.size()] ##pick a random tile position from the list of used tiles
		var spawnlocation = Vector2(pickup) ## setup new spean coordinates
		
		##Spawn the new object
		var new_ammo_pickup = ammo_pickup.instance()
		get_parent().call_deferred("add_child", (new_ammo_pickup))
		var _scene = get_tree().get_current_scene().get_name()
		Global.ammo_pickup_instances.append(new_ammo_pickup)
		
		#position the new object over the tileset object (32 added so it does not spawn offset)
		new_ammo_pickup.position.x = spawnlocation.x * 64 + 32
		new_ammo_pickup.position.y = spawnlocation.y * 32 + 32
		
	
	while mre_pickups > 0:
		mre_pickups -= 1
		rng.randomize() ## Change the random seed so new random number each time
		var m_pickup = used[rng.randi() % used.size()] ##pick a random tile position from the list of used tiles
		var m_spawnlocation = Vector2(m_pickup) ## setup new spean coordinates
		
		##Spawn the new object
		var new_mre_pickup = mre_pickup.instance()
		get_parent().call_deferred("add_child", (new_mre_pickup))
		var _scene = get_tree().get_current_scene().get_name()
		Global.mre_pickup_instances.append(new_mre_pickup)
		
		#position the new object over the tileset object (32 added so it does not spawn offset)
		new_mre_pickup.position.x = m_spawnlocation.x * 64 + 32
		new_mre_pickup.position.y = m_spawnlocation.y * 32 + 32

