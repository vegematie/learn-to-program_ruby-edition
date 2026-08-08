module Main
  def tick(args)
    args.state.dragon_x ||= 540
    args.state.dragon_y ||= 260
    args.state.score ||= 0
    args.state.coins ||= [
      { x: 200, y: 200 },
      { x: 600, y: 400 },
      { x: 1000, y: 200 }
    ]

    speed = 5
    args.state.dragon_x -= speed if args.inputs.keyboard.left
    args.state.dragon_x += speed if args.inputs.keyboard.right
    args.state.dragon_y -= speed if args.inputs.keyboard.down
    args.state.dragon_y += speed if args.inputs.keyboard.up

    args.state.dragon_x = 1280 if args.state.dragon_x < -200
    args.state.dragon_x = -200 if args.state.dragon_x > 1280
    args.state.dragon_y = 720 if args.state.dragon_y < -200
    args.state.dragon_y = -200 if args.state.dragon_y > 720

    args.state.coins.each do |coin|
      next if coin[:collected]
      if overlap?(args.state.dragon_x, args.state.dragon_y, 100, coin[:x], coin[:y], 40)
        coin[:collected] = true
        args.state.score += 1
      end
    end

    args.outputs.labels << {
      x: 20,
      y: 700,
      text: "Score: #{args.state.score}",
      size_px: 22
    }

    args.outputs.sprites << {
      x: args.state.dragon_x,
      y: args.state.dragon_y,
      w: 200,
      h: 200,
      path: "dragonruby.png"
    }

    args.state.coins.each do |coin|
      next if coin[:collected]
      args.outputs.solids << {
        x: coin[:x],
        y: coin[:y],
        w: 80,
        h: 80,
        r: 255,
        g: 210,
        b: 0
      }
    end
  end

  def overlap?(x1, y1, h1, x2, y2, h2)
    (x1 - x2).abs < (h1 + h2) / 2 && (y1 - y2).abs < (h1 + h2) / 2
  end
end
