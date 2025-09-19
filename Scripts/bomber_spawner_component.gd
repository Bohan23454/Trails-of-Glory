
class_name BomberSpawnerComponent
extends Node2D

# The scene we want to spawn
@export var scene = preload("res://Prefabs/enemylaser.tscn")

# Spawn an instance of the scene at a specific global position on a parent
# By default the parent is the current "main" scene , but you can pass in
# an alternative parent if you so choose.
func spawn(global_spawn_position: Vector2 = global_position, global_spawn_rotation: float = global_rotation, parent: Node = get_tree().current_scene) -> Node:
	assert(scene is PackedScene)
	# Instance the scene
	var instance = scene.instantiate()
	# Add it as a child of the parent
	parent.add_child(instance)
	# Update the global position of the instance.
	# (This must be done after adding it as a child)
	instance.global_position = global_spawn_position
	instance.global_rotation = global_spawn_rotation
	# Return the instance in case we want to perform any other operations
	# on it after instancing it.
	return instance
