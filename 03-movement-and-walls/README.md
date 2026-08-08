# 03 - Movement and walls

## Mission

Make the dragon stop at the edges of the screen so it never disappears.

## New idea

A game can make decisions with `if`. Today we use it to say: “If the dragon goes too far, bring it back.”

## Start with the working game

1. This lesson continues [Lesson 02](02-how-dragonruby-works/README.md).
2. Start DragonRuby by double-clicking the ordinary executable.
3. Open the existing `mygame/app/main.rb` in Sublime Text.

If the game ever gets messy, copy the file from `03-movement-and-walls/starter/app/main.rb` into `mygame/app/main.rb` and start again.

## Exercise 3.1 - Make the dragon stop at the edge

Find the four lines near the bottom that start with `args.state.dragon_x =` or `args.state.dragon_y =`.

Those lines already keep the dragon on screen. Try changing the numbers a little and watch what happens.

For example:
- Change `1280` to something smaller and see where the dragon stops.
- Change `-200` to something else and see how far off screen the dragon can go before it snaps back.

Save after each change and play.

## Exercise 3.2 - Add your own wall rule

Below the dragon movement, add one new rule of your own.

Here is one example you can type exactly:

```ruby
args.state.dragon_x = 640 if args.state.dragon_x > 1300
```

Read it out loud with a parent:

> “If the dragon goes past 1300, put it back at 640.”

Then try to write one more rule yourself. It does not need to be fancy. It only needs to use `if` and a number.

## Checkpoint

You are done when you can say:
- “The dragon moves because of the arrow keys.”
- “The `if` lines stop the dragon at the edges.”
- “Changing a number changes where the wall happens.”

Next: [04 - Collectibles](04-collectibles/README.md) when it is ready.

---

## Adult notes

- This lesson is the first real use of `if` for game rules.
- The target file is the same as the starter, because the border code is already complete. The lesson is about understanding it and changing the numbers, not typing the whole thing from scratch.
- Keep the student edit small. The goal is reading and tweaking, not writing a large block.
- If the student wants a bigger challenge, let them invent a second rule, but do not turn this into a puzzle. The lesson is the idea, not the exact code.
- Commit on the `son-learning` branch with a message like `lesson 03: stop the dragon at the edges`.
