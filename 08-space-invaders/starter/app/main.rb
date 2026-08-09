module Main
  def tick(args)
    args.state.player_x ||= 580
    args.state.enemies ||= make_enemies
    args.state.bullets ||= []
    args.state.enemy_direction ||= 1
    args.state.shot_timer ||= 0

    args.state.player_x += 7 if args.inputs.keyboard.right
    args.state.player_x -= 7 if args.inputs.keyboard.left
    args.state.bullets << { x: args.state.player_x + 20, y: 90, w: 6, h: 16 } if args.inputs.keyboard.key_down.space
    args.state.shot_timer += 1
    args.state.bullets.each { |bullet| bullet[:y] += 8 }

    move_enemies(args)
    draw_game(args)
  end

  def make_enemies
    (0...3).flat_map do |row|
      (0...8).map { |column| { x: 180 + column * 120, y: 560 - row * 55, w: 50, h: 30 } }
    end
  end

  def move_enemies(args)
    args.state.enemies.each do |enemy|
      enemy[:x] += args.state.enemy_direction
    end
    if args.state.enemies.any? { |enemy| enemy[:x] < 40 || enemy[:x] > 1190 }
      args.state.enemy_direction = -args.state.enemy_direction
      args.state.enemies.each { |enemy| enemy[:y] -= 25 }
    end
  end

  def draw_game(args)
    args.outputs.solids << { x: args.state.player_x, y: 40, w: 60, h: 30, r: 80, g: 220, b: 120 }
    args.state.bullets.each { |bullet| args.outputs.solids << bullet.merge(r: 255, g: 255, b: 255) }
    args.state.enemies.each { |enemy| args.outputs.solids << enemy.merge(r: 220, g: 80, b: 80) }
    args.outputs.labels << { x: 20, y: 700, text: "SPACE INVADERS", size_px: 30 }
  end
end
