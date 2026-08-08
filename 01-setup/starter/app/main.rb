module Main
  def tick(args)
    # TRY THIS: change the words inside text.
    args.outputs.labels << {
      x: 640,
      y: 560,
      text: "Hello, Dragon!",
      size_px: 42,
      anchor_x: 0.5
    }

    args.outputs.sprites << {
      # TRY THIS: change x and y to move the dragon.
      x: 540,
      y: 260,
      w: 200,
      h: 200,
      path: "dragonruby.png"
    }
  end
end
