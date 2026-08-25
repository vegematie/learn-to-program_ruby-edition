# 05 - Pong movement

## Week 5 outcome

Make a Pong ball move and bounce around the playfield.

## Concepts

- Position
- Velocity
- Direction
- Collision

## Load the lesson

Run:

```text
spwn sync --target ../dragonruby/mygame --source 05-pong-movement/starter
```

Launch your local DragonRuby. The starter shows paddles and a ball that moves, but the ball leaves the screen.

## Exercise 5.1 - Read velocity

Find `ball_vx` and `ball_vy`. They say how much the ball changes on each frame.

Change one number and watch the ball move differently.

## Exercise 5.2 - Make the ball bounce

After the ball moves, add:

```ruby
if args.state.ball_y < 0 || args.state.ball_y > 680
  args.state.ball_vy = -args.state.ball_vy
end
```

Then add the same idea for the left and right edges. A collision changes direction by reversing velocity.

## Checkpoint

The ball moves, reaches an edge, and bounces instead of disappearing.

```text
spwn look
spwn compare
spwn save -m "week 05: Pong movement"
spwn upload
```

Next: [06 - Complete Pong](../06-pong-game/README.md).
