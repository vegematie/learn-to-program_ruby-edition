module Main
  def tick(args)
    message = "Hello, Dragon!"
    dragon_x = 540
    dragon_y = 260

    # TRY THIS: change the words inside text.
    args.outputs.labels << {
      x: 640,
      y: 560,
      text: message,
      size_px: 42,
      anchor_x: 0.5
    }

    args.outputs.sprites << {
      # TRY THIS: change dragon_x and dragon_y to move the dragon.
      x: dragon_x,
      y: dragon_y,
      w: 200,
      h: 200,
      path: "dragonruby.png"
    }
  end
end
