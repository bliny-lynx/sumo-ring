extends RigidBody2D

enum {STAGED, MOVING, DOWNED}

var state: = STAGED # essentially paused, the characters spawn first and then run at each other
@export var facing_right = true
var direction = Vector2.RIGHT
@onready var impulse_cd = $ImpulseCooldown
@onready var progress_bar = $Line2D
var power = 150
var size = 2.0
var target_size = 2.0
var inebriation = 0
var drunk_anims = ["default", "angry", "drunk", "fall"]
var enemy_anims = ["enemy1", "enemy2", "enemy3", "enemy4", "enemy5"]
@onready var dustspin = $Dustspin
@onready var growables = [$CollisionShape2D, $Sprite2D]
@onready var tween = null
var next_anim = null

func _ready():
    if not facing_right:
        $Dustspin.flip_h = true
        $Dustspin.position.x = -$Dustspin.position.x
        direction = Vector2.LEFT
        $Sprite2D.flip_h = true
        impulse_cd.wait_time -= randf_range(0.02, 0.2)
        $Sprite2D.play(enemy_anims.pick_random())

func setup():
    if Gamestate.phase != Gamestate.Phase.BATTLE:
        return
    if not facing_right:
        return
    var status = Gamestate.status_effects()
    print_debug("before setup size: ", size, " power: ", power, " drunk: ", inebriation,
    " speed: ", impulse_cd.wait_time, " mass: ", mass)
    drink(status["inebriation"])
    target_size += status["weight"]
    mass += status["weight"]
    power += status["strength"]
    impulse_cd.wait_time += status["slow"]
    size = target_size
    print_debug("after setup size: ", size, " power: ", power, " drunk: ", inebriation,
    " speed: ", impulse_cd.wait_time, " mass: ", mass)

func unstage():
    impulse_cd.start()
    if state != DOWNED:
        state = MOVING

func downed():
    return state == DOWNED

func recover():
    $Sprite2D.play("recover")
    next_anim = "drunk"
    inebriation -= 1
    $Statuseffect.visible = false
    $Statuseffect2.visible = false
    if Gamestate.phase == Gamestate.Phase.BATTLE:
        state = MOVING
        impulse_cd.start()

func drink(amount=1):
    var effect_name = ["dizzy", "bubble", "anger", "anger2"].pick_random()
    new_effect(effect_name)
    inebriation += amount
    print_debug("drunk ", inebriation)
    if inebriation < len(drunk_anims):
        $Sprite2D.play(drunk_anims[inebriation])
    if inebriation >= len(drunk_anims) - 1:
        fall()

func fall():
    Audio.grunt_sfx()
    $Sprite2D.play(drunk_anims[-1])
    next_anim = "passed_out"
    new_effect("sleep")
    state = DOWNED

func grow(amount=0.5):
    if is_instance_valid(tween):
        tween.kill()
    tween = get_tree().create_tween()
    target_size += amount
    tween.tween_property(self, "size", target_size, 0.5)

func _process(_delta):
    for g in growables:
        g.scale = Vector2(size, size)
    if state == STAGED:
        return
    progress_bar.points = PackedVector2Array([Vector2(-impulse_cd.time_left * 20, 0), Vector2(impulse_cd.time_left * 20, 0)])

func _on_impulse_cooldown_timeout():
    if state == MOVING:
        dustspin.visible = true
        dustspin.play()
        apply_central_impulse(direction * power)
        if inebriation > 0:
            if not randi() % 20:
                fall()
    if state == DOWNED:
        if not randi() % 6:
            recover()
    power += randf_range(-1, 1)

func new_effect(anim_name):
    var effect_node = [$Statuseffect, $Statuseffect2].pick_random()
    effect_node.visible = true
    effect_node.play(anim_name)

func _on_sprite_2d_animation_finished():
    if next_anim != null:
        $Sprite2D.play(next_anim)
    next_anim = null


func _on_body_entered(_body):
    Audio.slap_sfx()
