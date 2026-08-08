# Lesson 04 — Collectibles: design

## Goal

The dragon can collect coins. Each collected coin makes the score go up by 1 and the coin disappears from the screen.

## What the student sees

- A score label in the top-left: `Score: 0`.
- Three gold coins on the screen.
- Walking the dragon over a coin makes it vanish and the score climb by 1.

## What changes from Lesson 03

1. Add `args.state.score ||= 0` and a score label drawn every tick.
2. Add a `coins` list. Each entry has `x`, `y`, and a `collected` flag.
3. Each tick, check overlap between the dragon and each still-visible coin. On overlap, mark the coin collected and increment the score.
4. Draw only the coins that are not yet collected.

## Student change

The starter already has the coins and the overlap logic working. The student edits the coin list: adds a fourth coin, moves one, or changes the starting score. The "lists" idea is that one variable holds several coins and the game checks each one.

## Visual approach

Coins are drawn as small gold-colored squares using `args.outputs.solids`. No external file is needed, so the lesson runs before any sprite pack arrives. An adult note explains that a real `sprites/items/coin.png` can replace the colored square later.

## Code shape (target)

```ruby
module Main
  def tick(args)
    args.state.dragon_x ||= 540
    args.state.dragon_y ||= 260
    args.state.score ||= 0
    args.state.coins ||= [
      { x: 200, y: 200 },
      { x: 600, y: 400 },
      { x: 1000, y: 200 }
    ]

    # dragon movement + walls — same as Lesson 03

    # collect coins
    args.state.coins.each do |coin|
      next if coin[:collected]
      if overlap?(args.state.dragon_x, args.state.dragon_y, 100, coin[:x], coin[:y], 40)
        coin[:collected] = true
        args.state.score += 1
      end
    end

    # draw score
    args.outputs.labels << { x: 20, y: 700, text: "Score: #{args.state.score}", size_px: 22 }

    # draw dragon sprite
    # draw coins (only uncollected) as gold squares
  end

  def overlap?(x1, y1, h1, x2, y2, h2)
    (x1 - x2).abs < (h1 + h2) / 2
  end
end
```

## Starter vs target

The starter includes the coins and the overlap logic already working. The student's job is to read the coin list and change it — add a coin, move one, or set the score to a different start. The target is identical to the starter because the feature is already complete. This matches the Lesson 03 pattern.

## Adult notes

- The `overlap?` helper is a simple distance check. It is not pixel-perfect but is good enough for a first collectible.
- Coins are gold squares. When the sprite pack arrives, replace the square drawing with `path: "sprites/items/coin.png"` and adjust `w`/`h`.
- Commit on `son-learning` with `lesson 04: collect coins and score points`.
