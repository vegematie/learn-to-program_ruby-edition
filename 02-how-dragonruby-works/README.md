# 02 - How DragonRuby works

## Mission

Make the dragon move with the arrow keys and understand the tiny loop that makes the game work.

## DragonRuby in one sentence

DragonRuby keeps asking your game:

> “What should happen right now?”

Your answer is a piece of Ruby code called `tick`. DragonRuby asks it about 60 times every second. That is why the game can notice the arrow key, move the dragon a little, and draw the new picture many times each second.

This is like Scratch's **forever** block:

```text
forever:
  see what the player is doing
  update what the game remembers
  draw the new picture
```

## The three useful drawers in `args`

DragonRuby gives `tick` a toolbox called `args`. We only need three drawers today:

| Drawer | Scratch-like meaning |
| --- | --- |
| `args.inputs` | What the player is doing now |
| `args.state` | What the game remembers |
| `args.outputs` | What the game should draw now |

### `args.inputs` - listen to the player

This asks whether an arrow key is being held:

```ruby
if args.inputs.keyboard.right
  # the player is holding the right arrow
end
```

### `args.state` - remember things

The game needs to remember where the dragon is. `args.state.dragon_x` is a named memory box:

```ruby
args.state.dragon_x ||= 540
```

The `||=` means: “Give this box 540 the first time, but keep its old value afterward.” Without memory, the dragon would forget its position on every heartbeat.

### `args.outputs` - draw the current picture

This puts a dragon picture on the screen:

```ruby
args.outputs.sprites << {
  x: args.state.dragon_x,
  y: args.state.dragon_y,
  w: 200,
  h: 200,
  path: "dragonruby.png"
}
```

DragonRuby redraws the screen each heartbeat. Your code tells it what should be visible in that heartbeat. This is why the dragon's current position is sent to `args.outputs` every time.

## How the moving dragon works

Read this from top to bottom:

```ruby
args.state.dragon_x ||= 540       # remember where the dragon starts
speed = 5                          # decide how far it moves

if args.inputs.keyboard.right     # is right being held?
  args.state.dragon_x += speed     # move the memory box right
end

args.outputs.sprites << {          # draw the dragon there
  x: args.state.dragon_x,
  y: args.state.dragon_y,
  w: 200,
  h: 200,
  path: "dragonruby.png"
}
```

The important idea is not memorising the Ruby punctuation. It is the chain:

```text
arrow key → change remembered position → draw at the new position
```

## The screen map

DragonRuby's game screen is 1280 units wide and 720 units tall. The bottom-left corner is `(0, 0)`:

```text
(0, 720)                    (1280, 720)
     +----------------------------+
     |                            |
     |            dragon          |
     |                            |
     +----------------------------+
(0, 0)                      (1280, 0)
```

Increasing `x` moves right. Increasing `y` moves up.

## Exercise 2.1 - Try small changes

Open the existing `mygame/app/main.rb` from Lesson 01. It already works. Try one marked change at a time:

1. Change the dragon's starting position.
2. Change its speed.
3. Change its size.

Save after every change and play. The goal is to see how one number changes the game.

The `target/app/main.rb` file is a rescue/reference version. Do not copy it over your game at the start. It is completely fine to look at it when stuck.

## Exercise 2.2 - See the heartbeat

The starter displays `Kernel.tick_count`, the number of heartbeats DragonRuby has run. Watch it increase while the game is open.

You do not need to memorise `Kernel.tick_count`. It is just a way to see that `tick` keeps running.

## Exercise 2.3 - Explore with a parent

Run one DragonRuby sample together. Point out one thing you might borrow for your own game. No written report is needed.

## Save your work

Ask the parent to review the change, then use GitHub Desktop to commit it on the `son-learning` branch and click **Push origin**.

Checkpoint: you can describe `args.inputs` as “what the player is doing,” `args.state` as “what the game remembers,” and `args.outputs` as “what the game draws.”
