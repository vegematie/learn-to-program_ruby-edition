module Main
  def tick(args)
    args.state.dragon_x ||= 60
    args.state.dragon_y ||= 260
    args.state.frame_count ||= 0
    args.state.frame_count += 1

    speed = 2

    # The dragon walks forward on its own.
    next_x = args.state.dragon_x + speed
    next_y = args.state.dragon_y

    # TRY THIS 1: steer with the arrow keys.
    next_x -= speed if args.inputs.keyboard.left
    next_x += speed if args.inputs.keyboard.right
    next_y -= speed if args.inputs.keyboard.down
    next_y += speed if args.inputs.keyboard.up

    # TRY THIS 2: add if statements that keep next_x and next_y on screen.
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
      text: "The dragon walks alone. Steer it! | frames: #{args.state.frame_count}",
      size_px: 22
    }
  end
end
