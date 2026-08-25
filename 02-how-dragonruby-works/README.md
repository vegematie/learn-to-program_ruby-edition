# 02 - Movement

## Week 2 outcome

Make the player move with the keyboard.

## Concepts

- Input
- Coordinates
- Speed
- `if`
- Methods

## Load the lesson

Make sure Week 1 is saved, then run:

```text
spwn sync --target ../dragonruby/mygame --source 02-how-dragonruby-works/starter
```

Launch your local DragonRuby and open `mygame/app/main.rb`.

DragonRuby repeatedly calls `tick`. The game reads the arrow keys, changes the remembered position, and draws the dragon there.

```text
arrow key → change position → draw player
```

## Ruby syntax decoder

New symbols show up in this week's code. Here is what each one means. Come back to this
table any time a line looks strange.

- **`#` — a comment.** The computer ignores everything after `#`. It is a note for humans.
- **`=` — "hold this".** `dragon_x = 540` puts 540 into a jar labeled `dragon_x`.
- **`||=` — "hold this, but only if the jar is empty".** Used for the starting position,
  so it is written once, not every frame.
- **`+=` and `-=` — "change by".** `x += speed` is short for `x = x + speed`.
- **`.` — "ask for".** `args.inputs.keyboard.left` asks: args, give me your inputs;
  inputs, give me the keyboard; keyboard, is left held?
- **`<<` — "add to the list".** `args.outputs.sprites << { ... }` adds one more thing
  to draw.
- **`{ key: value }` — a description card.** Each line inside is "label: answer", like
  `x: 640`. The colon hugs the word in front of it.
- **`def name(things) ... end` — a recipe.** Nothing inside runs until someone calls
  the name. The things in parentheses are what you must hand it.
- **`if` at the end of a line — "only when".** `x -= speed if keyboard.left` reads like
  English: subtract speed *if* left is held.
- **`"#{...}"` — fill in the blank inside words.** The code inside `#{ }` runs and its
  result is pasted into the text.

## Exercise 2.1 - Move the player

Hold the arrow keys. The movement code uses a method:

```ruby
move_player(args, 5)
```

`move_player` is a named group of movement instructions. The `5` is the speed passed into the method.

## Exercise 2.2 - Change the speed

Change `5` to another number. Save and play.

Read this line out loud:

> “Run the `move_player` method with a speed of 5.”

## Exercise 2.3 - Read one `if`

Inside `move_player`, find:

```ruby
if args.inputs.keyboard.right
  args.state.dragon_x += speed
end
```

It means:

> “If the right arrow is held, add speed to the player's x position.”

Change the starting position or speed for a small creative experiment.

## Exercise 2.4 - Save the working game

When the player moves as you want:

```text
spwn look
spwn compare
spwn save -m "week 02: player movement"
spwn upload
```

## Checkpoint

You are done when you can explain:

- `args.inputs` tells the game what the player is doing;
- `args.state` remembers the player's position;
- `move_player` groups movement instructions; and
- `if` makes movement happen only when a key is held.

Next: [03 - Time and boundaries](../03-movement-and-walls/README.md).
