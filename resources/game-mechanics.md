# Game mechanics and programming ideas

This is an adult planning guide. The child should meet each idea through a visible game change, not through this table.

| Game change | Visible result | Programming idea |
| --- | --- | --- |
| Move the player | Arrow keys move a character | Variables, assignment, input |
| Add walls | The character stops at the edge | `if`, comparisons |
| Collect a coin | A number goes up | Counters, lists, incrementing |
| Touch an enemy | The player loses health | Collision, Boolean logic |
| Patrol between points | An NPC walks a route | Loops, lists, simple state |
| Spawn enemies | New enemies appear | Methods, lists |
| Chase the player | An enemy follows | Position maths, decisions |
| Win or lose | A clear ending appears | State, conditionals |
| Animate a character | The picture changes frames | Arrays, indexing, timing |
| Add a cooldown | An action must wait | Time, comparison |
| Add randomness | Each play is a little different | Random numbers |

## Recommended order

1. Movement and screen edges.
2. Collectibles and score.
3. Collision response.
4. A patrolling NPC.
5. Health and damage.
6. Win and lose screens.
7. Simple spawning and chase behaviour.
8. Animation, randomness, and cooldowns as polish.

Each lesson should extend the existing working game. The parent supplies the code and assets; the child changes only the small, interesting part.

## State machines

Introduce this only after the child has already used variables and `if` statements several times.

Explain it as moods:

```text
The game can be in one mood at a time:

title → playing → won
                 ↘ lost
```

The code is just a variable plus rules:

```ruby
args.state.game_state ||= :title

case args.state.game_state
when :title
  # show the title
when :playing
  # move, collide, and score
when :won, :lost
  # show the result and wait for restart
end
```

The important idea is: “The game has one current mood, and events can change that mood.” A full state-machine framework or class hierarchy is unnecessary.

## Event-driven thinking

DragonRuby still runs `tick` repeatedly, so the child will first use simple checks. Later, name the interesting moments:

- the jump key was just pressed;
- the player touched a coin;
- health reached zero;
- the player just landed;
- a timer finished.

Then teach the pattern:

```text
something happened → react → maybe change state
```

DragonRuby's `key_down` input is a good first “just happened” event. Collision and timer events can come later.

## Hierarchical states: later only

Use hierarchical states only when flat states begin repeating too much code. Explain them as big moods containing smaller moods:

```text
player
├── grounded
│   ├── idle
│   └── walking
└── airborne
    ├── jumping
    └── falling
```

The parent state owns shared rules; the child state owns the special behaviour. In Ruby, names such as `:grounded_idle` and `:airborne_jumping` are enough at first. Do not introduce a State class or framework for a 12-year-old's first game.
