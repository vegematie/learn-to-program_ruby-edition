module Main
  def tick(args)
    args.state.ball_x ||= 620
    args.state.ball_y ||= 340
    args.state.ball_vx ||= 4
    args.state.ball_vy ||= 3
    args.state.ball_x += args.state.ball_vx
    args.state.ball_y += args.state.ball_vy

    draw_paddle(args, 40, 260)
    draw_paddle(args, 1200, 260)
    args.outputs.solids << { x: args.state.ball_x, y: args.state.ball_y, w: 20, h: 20, r: 255, g: 255, b: 255 }
    args.outputs.labels << { x: 520, y: 700, text: "PONG", size_px: 32 }
  end

  def draw_paddle(args, x, y)
    args.outputs.solids << { x: x, y: y, w: 20, h: 200, r: 255, g: 255, b: 255 }
  end
end
