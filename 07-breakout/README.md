# 07 - Breakout

## Week 7 outcome

Make a ball destroy a wall of bricks.

## Concepts

- Collections of objects
- Repetition
- Removing objects
- Multiple collision targets

## Load the lesson

Run:

```text
spwn sync --target ../dragonruby/mygame --source 07-breakout/starter
```

The starter has a paddle, ball, and brick collection. The ball bounces, but bricks do not disappear yet.

## Exercise 7.1 - Read the brick collection

Find `args.state.bricks`. Each hash is one brick with a position and size. Change a brick's `x` or `y` and watch the wall change.

## Exercise 7.2 - Remove a brick

Inside the brick loop, check whether the ball overlaps the brick. When it does, remove the brick and reverse the ball's vertical velocity.

The target uses `reject!` so the collection becomes smaller while the game runs.

## Exercise 7.3 - Make your own level

Add a row of bricks or change a brick's colour. Keep the level playable.

## Checkpoint

The ball can hit several bricks, bricks disappear, and the remaining collection is drawn each frame.

```text
spwn look
spwn compare
spwn save -m "week 07: break bricks"
spwn upload
```

Next: [08 - Space Invaders](../08-space-invaders/README.md).
