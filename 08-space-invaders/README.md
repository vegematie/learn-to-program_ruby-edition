# 08 - Space Invaders

## Week 8 outcome

Make a formation of enemies move, fire bullets, and become destroyable.

## Concepts

- Bullets
- Enemy collections
- Spawning
- Difficulty
- Win and lose states

## Load the lesson

Run:

```text
spwn sync --target ../dragonruby/mygame --source 08-space-invaders/starter
```

The starter has a player, enemy formation, and bullets. Enemies move, but bullets do not destroy them yet.

## Exercise 8.1 - Read the collections

Find `args.state.enemies` and `args.state.bullets`. The game loops over both collections every frame.

## Exercise 8.2 - Destroy an enemy

When a bullet overlaps an enemy, remove the enemy and the bullet. Increase the score.

## Exercise 8.3 - Finish the game state

The target shows `YOU WIN` when no enemies remain and `GAME OVER` when an enemy reaches the player. Change the starting enemy rows or the enemy speed and keep the game playable.

## Checkpoint

Enemies move in formation, bullets destroy enemies, the game gets harder as the formation descends, and the player can win or lose.

```text
spwn look
spwn compare
spwn save -m "week 08: build Space Invaders"
spwn upload
```

Unit 2 is complete. Next: Week 9 introduces classes and reusable game objects.
