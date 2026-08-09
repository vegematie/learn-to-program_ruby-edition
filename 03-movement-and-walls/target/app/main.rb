module Main
  def tick(args)
    args.state.dragon_x ||= 540
    args.state.dragon_y ||= 260
    args.state.frame_count ||= 0
    args.state.frame_count += 1

    speed = 5
    next_x = args.state.dragon_x
    next_y = args.state.dragon_y
    next_x -= speed if args.inputs.keyboard.left
    next_x += speed if args.inputs.keyboard.right
    next_y -= speed if args.inputs.keyboard.down
    next_y += speed if args.inputs.keyboard.up

    if next_x < 0
      next_x = 0
    end
    if next_x > 1080
      next_x = 1080
    end
    if next_y < 0
      next_y = 0
    end
    if next_y > 520
      next_y = 520
    end

    args.state.dragon_x = next_x
    args.state.dragon_y = next_y

    args.outputs.sprites << {
      x: args.state.dragon_x,
      y: args.state.dragon_y,
      w: 200,
      h: 200,
      path: "dragonruby.png"
    }

    args.outputs.labels << {
      x: 20,
      y: 700,
      text: "Arrow keys move the dragon | frames: #{args.state.frame_count}",
      size_px: 22
    }
  end
end
