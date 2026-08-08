# 04 - Collectibles

## Mission

Make coins the dragon can collect. Each collected coin makes the score go up by 1.

## New idea

A game can hold a **list** of things. Today the list is coins. The game checks each coin to see whether the dragon touches it.

## Start with the working game

1. This lesson continues [Lesson 03](03-movement-and-walls/README.md).
2. Start DragonRuby by double-clicking the ordinary executable.
3. Open the existing `mygame/app/main.rb` in Sublime Text.

If the game ever gets messy, copy the file from `04-collectibles/starter/app/main.rb` into `mygame/app/main.rb` and start again.

## Exercise 4.1 - Read the coin list

Near the top of the file you will see a list that looks a bit like this:

```ruby
args.state.coins ||= [
  { x: 200, y: 200 },
  { x: 600, y: 400 },
  { x: 1000, y: 200 }
]
```

That list is three coins. Each one has an `x` and a `y`.

Try changing one of the numbers, save, and play. Watch where the coin moves.

## Exercise 4.2 - Add your own coin

Add a fourth coin to the list. Here is an example you can type:

```ruby
  { x: 900, y: 100 },
```

Put it inside the list, after one of the other coins and before the closing `]`. Save and play. Walk the dragon over your new coin and watch the score.

## Exercise 4.3 - Start with a different score

Find the line that says `args.state.score ||= 0`.

Change the `0` to another number, save, and play. The score label should start at the number you chose.

Read it out loud with a parent:

> “The score starts at this number the first time, and keeps its value after that.”

## How collecting works

Each tick, the game does this for every coin that is not yet collected:

1. Check whether the dragon is close enough to the coin.
2. If it is, mark the coin as collected and add 1 to the score.

The coin disappears because the game stops drawing coins that are marked collected.

You do not need to memorise the exact code. The idea is:

```text
for each coin:
  if dragon touches coin:
    coin disappears
    score goes up by 1
```

## Checkpoint

You are done when you can say:

- “The coins are in a list.”
- “The game checks each coin every tick.”
- “When the dragon touches a coin, the score goes up.”
- “I can add a coin by editing the list.”

Next: [05 - Patrol NPC](05-patrol-npc/README.md) when it is ready.

---

## Adult notes

- The coin is a gold square drawn with `args.outputs.solids`. No external sprite is needed for this lesson, so it runs before any asset pack arrives.
- The `overlap?` helper is a simple distance check. It is not pixel-perfect but is good enough for a first collectible.
- When the sprite pack arrives, replace the coin square with `path: "sprites/items/coin.png"` and adjust `w`/`h`. The rest of the lesson stays the same.
- The starter and target are identical here, because the feature is already complete. The lesson is about reading and editing the coin list, not typing the whole thing from scratch.
- Keep the student edit small. Adding one coin or moving one is enough. If the student wants more, let them add a second coin, but do not turn this into a puzzle.
- Commit on the `son-learning` branch with a message like `lesson 04: collect coins and score points`.
