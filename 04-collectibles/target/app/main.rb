module Main
  def tick(args)
    args.state.dragon_x ||= 540
    args.state.dragon_y ||= 260
    args.state.score ||= 0
    args.state.stars ||= [
      { x: 200, y: 200 },
      { x: 600, y: 400 },
      { x: 1000, y: 200 }
    ]

    speed = 5
    next_x = args.state.dragon_x
    next_y = args.state.dragon_y
    next_x -= speed if args.inputs.keyboard.left
    next_x += speed if args.inputs.keyboard.right
    next_y -= speed if args.inputs.keyboard.down
    next_y += speed if args.inputs.keyboard.up
    next_x = 0 if next_x < 0
    next_x = 1080 if next_x > 1080
    next_y = 0 if next_y < 0
    next_y = 520 if next_y > 520
    args.state.dragon_x = next_x
    args.state.dragon_y = next_y

    args.state.stars.reject! do |star|
      if overlap?(args.state.dragon_x, args.state.dragon_y, 100, star[:x], star[:y], 40)
        args.state.score += 1
        true
      else
        false
      end
    end

    args.outputs.labels << { x: 20, y: 700, text: "Score: #{args.state.score}", size_px: 22 }
    args.outputs.sprites << {
      x: args.state.dragon_x, y: args.state.dragon_y, w: 200, h: 200,
      path: "dragonruby.png"
    }
    args.state.stars.each do |star|
      args.outputs.solids << {
        x: star[:x], y: star[:y], w: 80, h: 80,
        r: 255, g: 210, b: 0
      }
    end
  end

  def overlap?(x1, y1, h1, x2, y2, h2)
    (x1 - x2).abs < (h1 + h2) / 2 && (y1 - y2).abs < (h1 + h2) / 2
  end
end
