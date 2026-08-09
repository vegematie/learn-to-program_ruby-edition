module Main
  def tick(args)
    args.state.left_y ||= 260
    args.state.right_y ||= 260
    args.state.ball_x ||= 620
    args.state.ball_y ||= 340
    args.state.ball_vx ||= 5
    args.state.ball_vy ||= 3
    args.state.left_score ||= 0
    args.state.right_score ||= 0

    move_paddles(args)
    args.state.ball_x += args.state.ball_vx
    args.state.ball_y += args.state.ball_vy
    args.state.ball_vy = -args.state.ball_vy if args.state.ball_y < 0 || args.state.ball_y > 680
    args.state.ball_vx = -args.state.ball_vx if args.state.ball_x < 40 || args.state.ball_x > 1220

    draw_game(args)
  end

  def move_paddles(args)
    args.state.left_y += 6 if args.inputs.keyboard.key_held.w
    args.state.left_y -= 6 if args.inputs.keyboard.key_held.s
    args.state.right_y += 6 if args.inputs.keyboard.up
    args.state.right_y -= 6 if args.inputs.keyboard.down
  end

  def draw_game(args)
    args.outputs.solids << { x: 40, y: args.state.left_y, w: 20, h: 200, r: 255, g: 255, b: 255 }
    args.outputs.solids << { x: 1220, y: args.state.right_y, w: 20, h: 200, r: 255, g: 255, b: 255 }
    args.outputs.solids << { x: args.state.ball_x, y: args.state.ball_y, w: 20, h: 20, r: 255, g: 255, b: 255 }
    args.outputs.labels << { x: 500, y: 700, text: "#{args.state.left_score}     PONG     #{args.state.right_score}", size_px: 30 }
  end
end
