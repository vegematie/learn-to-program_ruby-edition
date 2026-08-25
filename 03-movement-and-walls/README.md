# 03 - Time and boundaries

## Week 3 outcome

The dragon walks forward by itself. You steer it, give the game a clock, and build walls
so it can never leave the screen.

## New idea

Last week nothing moved unless you held a key. This week the game moves on its own:

```ruby
next_x = args.state.dragon_x + speed
```

No keyboard needed — every frame proposes a step forward. Your job is to steer and to
say *no* at the edges.

DragonRuby runs `tick` again and again. Each run is one **frame**. Counting frames is
counting time:

```text
one tick = one frame
60 frames ≈ one second
```

Today’s ideas are frames, timers, comparisons, and screen boundaries.

## Load the lesson

Make sure Week 2 is saved, then run:

```text
spwn sync --target ../dragonruby/mygame --source 03-movement-and-walls/starter
```

Launch your local DragonRuby and open `mygame/app/main.rb` in Sublime Text.

If the game gets messy, copy `03-movement-and-walls/starter/app/main.rb` into `mygame/app/main.rb` and start again.

## Exercise 3.1 - Watch it escape

Run the game and do not touch the keyboard. The dragon walks right until it leaves the
screen and is gone.

The movement code works in three steps:

1. **propose** — `next_x` is where the dragon *wants* to go;
2. **check** — (nothing yet — that is your job today);
3. **commit** — `args.state.dragon_x = next_x` makes it real.

The game proposes every frame but never checks. That is why the dragon escapes.

## Exercise 3.2 - Give the game a clock

The label shows `frames: #{args.state.frame_count}`. Change it to:

```ruby
text: "The dragon walks alone. Steer it! | seconds: #{args.state.frame_count / 60.0}",
```

Watch roughly one second pass every 60 frames. The `.0` tells Ruby to keep the fraction
instead of rounding down.

## Exercise 3.3 - Build the walls

Find the `TRY THIS 2` comment and add these rules after the steering code, **before** the
notebook is updated:

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

Each rule guards exactly one edge. The maximums are `1280 - 200` and `720 - 200` because
the dragon is 200 units wide and tall.

Now the walking dragon reaches the right wall and stops there, walking in place, until
you steer it away. The walls matter *because* the dragon never stops moving.

## Exercise 3.4 - Make time dangerous (stretch)

The dragon walks at speed 2 forever. Make time push it faster — change the speed line to:

```ruby
speed = 2 + args.state.frame_count / 300
```

Every 300 frames (about five seconds) the dragon gets a little faster. Time is now part
of the game, not just a number on screen.

## Checkpoint

You are done when you can say:

- “The game can move things by itself, one small step per frame.”
- “A timer can count frames.”
- “A comparison gives the game a true-or-false answer.”
- “The game proposes a move, the walls check it, and then the notebook commits it.”

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
- The starter is playable: the dragon auto-walks right and escapes the screen if the
  student does nothing. The escape is the motivation for the walls.
- The intended student implementation is four small `if ... end` rules plus the label
  change.
- The target shows the completed version. Do not ask the student to type the whole file.
- Exercise 3.4 is optional stretch work.
- Commit with a message such as `week 03: keep the player on screen`.
