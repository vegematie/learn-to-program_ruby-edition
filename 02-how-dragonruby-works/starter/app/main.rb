module Main
  def tick(args)
    # TRY THIS 1: change the starting position.
    args.state.dragon_x ||= 540
    args.state.dragon_y ||= 260

    # TRY THIS 2: change speed and see what happens.
    speed = 5
    args.state.dragon_x -= speed if args.inputs.keyboard.left
    args.state.dragon_x += speed if args.inputs.keyboard.right
    args.state.dragon_y -= speed if args.inputs.keyboard.down
    args.state.dragon_y += speed if args.inputs.keyboard.up

    # TRY THIS 3: change the dragon's size.
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
      text: "Arrow keys move the dragon | ticks: #{Kernel.tick_count}",
      size_px: 22
    }
  end
end
