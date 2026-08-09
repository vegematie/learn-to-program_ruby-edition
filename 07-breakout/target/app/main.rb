module Main
  def tick(args)
    args.state.paddle_x ||= 540
    args.state.ball_x ||= 620
    args.state.ball_y ||= 100
    args.state.ball_vx ||= 4
    args.state.ball_vy ||= 4
    args.state.bricks ||= make_bricks

    args.state.paddle_x += 8 if args.inputs.keyboard.right
    args.state.paddle_x -= 8 if args.inputs.keyboard.left
    args.state.ball_x += args.state.ball_vx
    args.state.ball_y += args.state.ball_vy
    args.state.ball_vx = -args.state.ball_vx if args.state.ball_x < 0 || args.state.ball_x > 1260
    args.state.ball_vy = -args.state.ball_vy if args.state.ball_y > 700
    args.state.ball_vy = -args.state.ball_vy if args.state.ball_y < 0
    args.state.ball_vy = -args.state.ball_vy if args.state.ball_y < 60 && args.state.ball_x.between?(args.state.paddle_x, args.state.paddle_x + 200)

    args.state.bricks.reject! do |brick|
      if overlap?(args.state.ball_x, args.state.ball_y, 20, brick[:x], brick[:y], brick[:w])
        args.state.ball_vy = -args.state.ball_vy
        true
      else
        false
      end
    end

    draw_game(args)
  end

  def make_bricks
    (0...5).flat_map do |row|
      (0...10).map { |column| { x: 80 + column * 115, y: 560 - row * 45, w: 100, h: 30 } }
    end
  end

  def overlap?(x1, y1, size1, x2, y2, size2)
    (x1 - x2).abs < (size1 + size2) / 2 && (y1 - y2).abs < (size1 + size2) / 2
  end

  def draw_game(args)
    args.outputs.solids << { x: args.state.paddle_x, y: 30, w: 200, h: 20, r: 255, g: 255, b: 255 }
    args.outputs.solids << { x: args.state.ball_x, y: args.state.ball_y, w: 20, h: 20, r: 255, g: 255, b: 255 }
    args.state.bricks.each { |brick| args.outputs.solids << brick.merge(r: 220, g: 80, b: 80) }
    args.outputs.labels << { x: 20, y: 700, text: "BREAKOUT | bricks left: #{args.state.bricks.length}", size_px: 30 }
  end
end
