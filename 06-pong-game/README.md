# 06 - Complete Pong

## Week 6 outcome

Make Pong playable for two people, with paddles, score, lives, round resets, and game over.

## Concepts

- Paddles
- Lives and score
- Resetting a round
- Game-over state

## Load the lesson

Run:

```text
spwn sync 06-pong-game/starter --into mygame
```

The starter is a playable Pong table. Add the round rules, then play against another person.

## Exercise 6.1 - Move the paddles

Use `W`/`S` for the left paddle and the arrow keys for the right paddle. Change the paddle speed and see how control feels.

## Exercise 6.2 - Score a point

When the ball leaves the left side, increase the right score. When it leaves the right side, increase the left score. Then call `reset_ball`.

## Exercise 6.3 - Finish the round

The target ends the game when a player reaches 5 points. Change the winning score and play a short match.

## Checkpoint

Two people can play, points are recorded, the ball resets after a point, and the game announces a winner.

```text
spwn look
spwn compare
spwn save -m "week 06: complete Pong"
spwn upload
```

Next: [07 - Breakout](../07-breakout/README.md).
