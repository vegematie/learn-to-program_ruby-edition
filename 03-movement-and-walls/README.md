# 03 - Time and boundaries

## Week 3 outcome

Keep the dragon moving consistently and stop it at the edges of the screen.

## New idea

DragonRuby runs `tick` again and again. Each run is one **frame**. The game can count frames to measure time:

```text
one tick = one frame
60 frames ≈ one second
```

The game can also compare a position with a boundary:

```ruby
if next_x < 0
  next_x = 0
end
```

Today’s ideas are frames, timers, Booleans, comparisons, and screen boundaries.

## Load the lesson

Make sure Week 2 is saved, then run:

```text
spwn sync 03-movement-and-walls/starter --into mygame
```

Launch your local DragonRuby and open `mygame/app/main.rb` in Sublime Text.

If the game gets messy, copy `03-movement-and-walls/starter/app/main.rb` into `mygame/app/main.rb` and start again.

## Exercise 3.1 - Watch frames

Watch the `frames` number while the game is open. It increases because `tick` keeps running.

The number is a simple timer. Change the label to show `args.state.frame_count / 60.0` and watch roughly one second pass every 60 frames.

## Exercise 3.2 - Add the boundary rules

The dragon can currently leave the screen. Find the `TRY THIS` comment and add these rules after the movement code:

```ruby
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
```

Read one rule out loud:

> “If the next x position is less than zero, set it back to zero.”

The maximums are `1280 - 200` and `720 - 200` because the dragon is 200 units wide and tall.

## Exercise 3.3 - Make a small timer change

Change the speed from `5` to another number. The frame counter still increases one frame at a time, while the dragon moves a different distance each frame.

## Checkpoint

You are done when you can say:

- “DragonRuby calls `tick` once per frame.”
- “A timer can count frames.”
- “A comparison gives the game a true-or-false answer.”
- “Boundary rules keep the dragon on screen.”

Save the working result:

```text
spwn look
spwn compare
spwn save -m "week 03: keep the player on screen"
spwn upload
```

Next: [04 - Collectibles](../04-collectibles/README.md).

---

## Adult notes

- This is Week 3 of the integrated curriculum: time and boundaries.
- The starter is playable but intentionally allows the dragon to leave the screen.
- The intended student implementation is four small `if` rules.
- The target shows the completed boundary rules. Do not ask the student to type the whole file.
- Commit with a message such as `week 03: keep the player on screen`.
