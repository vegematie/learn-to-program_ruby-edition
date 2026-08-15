# Make Games with [DragonRuby](https://dragonruby.org)

A game-first programming course for Nathan who is new to Ruby.

Learns programming by making games and Ruby concepts are introduced only when a game mechanic needs them. The student learns to describe game state and rules, predict what should happen, implement the smallest change, and compare the result with the prediction.

## Course rules

- No coding agent, Copilot, AI autocomplete, or AI-generated code.
- [DragonRuby](https://dragonruby.org) is the game engine.
- Sublime Text is the student's editor.
- Pyxel Edit is used for sprites, tiles, and animation.
- SPWN provides child-friendly save-points and sharing.
- GitHub Actions tests game rules and data.
- Lesson templates provide the starting point; the student owns the work.
- Predict before running: for each new rule, the student should describe at least one concrete example and predict the result before testing it in the game.
- Templates provide structure rather than solutions. Early templates provide more structure; later templates become smaller and require more of the design to come from the student.
- Every lesson starts with a playable project.
- Every lesson ends with a visible improvement and a `spwn save`.

The student should not need to install Ruby, rbenv, Bundler, or a database server. DragonRuby provides the runtime used to run the games.

## How we solve programming problems

Programming in this course is not trial and error. Before changing the game, understand what the game knows, what rule should operate on it, and what result you expect.

For trivial work, use:

```text
RULE → EXAMPLE → CODE → CHECK
```

For non-trivial mechanics, use:

```text
STATE
  ↓
RULE
  ↓
EXAMPLES
  ↓
CODE TEMPLATE
  ↓
IMPLEMENT
  ↓
TEST
```

This produces the recurring development loop used throughout the course:

```text
DESCRIBE → PREDICT → IMPLEMENT → PLAY → OBSERVE → REFINE
    ↑                                                │
    └────────────────────────────────────────────────┘
```

**Describe** the desired behaviour in plain language. **Predict** what should happen for concrete values or situations. **Implement** the smallest change that expresses the rule. **Play** the game. **Observe** what actually happened. **Refine** the rule, example, or implementation when observation differs from prediction.

A working game is not enough. The student should gradually become able to explain what state mattered, what the rule was, what was predicted, and what actually happened.

## Weekly rhythm

Each week contains two or three short sessions:

1. Play the current game.
2. Describe the next game rule in plain language.
3. Work through a concrete example and predict what should happen.
4. Change one small part of the template.
5. Run the game and observe the result.
6. Compare the observation with the prediction.
7. Refine the rule, example, or code if necessary.
8. Add or edit a sprite when appropriate.
9. Explain the Ruby concept after the mechanic works.
10. Save the working version with `spwn save`.
11. Finish with a small creative challenge.

A lesson should normally take 20–40 minutes. Stop before frustration begins.

Creative challenges are less-scaffolded transfer exercises. They ask Nathan to apply the current idea in a new situation without being shown the code. The challenge becomes less prescribed as the course progresses: first change a known rule, then invent a mechanic, then design the state, examples, and implementation independently.

## SPWN lesson workflow

SPWN is distributed as the `spawnpoint` Ruby gem. Install it once with `gem install spawnpoint`, which puts the `spwn` command on the PATH. After that, the student follows the same loop every week:

```text
+-----------------------+
| Student prepares repo |
| and installs SPWN     |
+-----------+-----------+
            |
            v
+-----------------------+
| spwn sync             |
| lesson/starter        |
| --into mygame         |
+-----------+-----------+
            |
            v
+-----------------------+
| Student opens DragonRuby|
| and plays the game    |
+-----------+-----------+
            |
            v
+-----------------------+
| Student describes the |
| rule and predicts the  |
| result                 |
+-----------+-----------+
            |
            v
+-----------------------+
| Student edits one     |
| small marked change   |
+-----------+-----------+
            |
            v
+-----------------------+
| Play and observe      |
| spwn look / compare   |
+-----------+-----------+
            |
            v
     +------------------------+
     | Did observation match  |
     | the prediction?        |
     +----+--------------+----+
          |              |
       no |              | yes
          |              v
          |  +-----------------------+
          |  | Student reviews result|
          |  | spwn save -m "..."    |
          |  +-----------+-----------+
          |              |
          |              v
          |  +-----------------------+
          |  | spwn upload           |
          |  | share the checkpoint  |
          |  +-----------+-----------+
          |              |
          |              v
          |  +-----------------------+
          |  | Next week: spwn sync  |
          |  | the next starter      |
          |  +-----------+-----------+
          |              |
          +--------------+
                         |
                         v
                 play and edit again
```

The `no` path asks which part needs refinement: was the rule wrong, was the example or prediction wrong, or was the code wrong? The student can run that loop as many times as needed before saving and uploading.

Useful commands:

```text
spwn look                              # see the current project state
spwn compare                           # see the code changes
spwn sync 03-movement-and-walls/starter --into mygame
spwn save -m "week 03: keep the player on screen"
spwn upload                            # share the checkpoint
```

## Big Table of Contents

### Unit 1 — From Scratch to Ruby games

DragonRuby's game loop; frames and time; values and variables; coordinates; input; conditions; methods; and Git save-points.

### Unit 2 — Classic arcade mechanics

Movement; velocity; direction; collision; arrays; loops; score; lives; and game states.

Projects: Pong, Breakout, and Space Invaders.

### Unit 3 — Objects, sprites, and animation

Classes; instance variables; `initialize`; object methods; object collaboration; sprite sheets; animation frames; and animation states.

Projects: reusable player, enemy, bullet, and collectible objects.

### Unit 4 — Grid worlds and simple AI

Two-dimensional arrays; tile maps; grid coordinates; enemy patrols; chasing; distance and direction; and state machines.

Projects: maze game, Pac-Man-style game, and simple enemy AI.

### Unit 5 — Platformers and game feel

Gravity; jumping; platform collision; game feel; camera scrolling; timers and cooldowns; hit reactions; UI and feedback; and debugging.

Project: a short platformer.

### Unit 6 — Local chess

Board representation; pieces as objects; legal movement; captures; turns; king safety; check; checkmate; special moves; move history; save/load; and automated tests.

Project: local two-player chess with no computer opponent.

### Later Unit 7 — ¾-view hack-and-slash

Tile depth ordering; combat; weapons; inventory; enemy classes; animation states; procedural rooms; procedural dungeons; seeded generation; and boss rooms.

### Later Unit 8 — Server multiplayer

Client and server; messages; game rooms; server-authoritative rules; move validation; disconnects; and saving games.

Project: online chess multiplayer.

### Later Unit 9 — Pseudo-3D FPS

Vectors; angles; rays; distance; perspective; raycasting; first-person movement; enemy billboard sprites; and weapon animation.

Project: a small Wolfenstein-style FPS.

## Integrated 24-Week Plan

### Unit 1 — From Scratch to Ruby games

#### Week 1 — First project

Game result: a dragon player appears on screen.

Concepts: files and folders, Ruby values, variables, drawing, DragonRuby project structure, and the first Git commit.

Pyxel Edit: create the first player sprite.

#### Week 2 — Movement

Game result: the player moves with the keyboard.

Concepts: input, coordinates, speed, `if`, and methods.

#### Week 3 — Time and boundaries

Game result: movement remains consistent and the player cannot leave the screen.

Concepts: frames, timers, Booleans, comparisons, and screen boundaries.

#### Week 4 — Collectibles

Game result: the player collects stars and gains points.

Concepts: arrays, loops, collision, score, and removing objects.

Pyxel Edit: collectible and enemy sprites.

### Unit 2 — Classic arcade mechanics

#### Week 5 — Pong movement

Game result: a ball moves and bounces.

Concepts: velocity, direction, position, and collision.

#### Week 6 — Complete Pong

Game result: two players can play Pong.

Concepts: paddles, lives, score, resetting a round, and game-over state.

#### Week 7 — Breakout

Game result: bricks appear and disappear when hit.

Concepts: collections of objects, repetition, removing objects, and multiple collision targets.

#### Week 8 — Space Invaders

Game result: enemies move in formation and can be destroyed.

Concepts: bullets, enemy collections, spawning, difficulty, and win/lose states.

### Unit 3 — Objects, sprites, and animation

#### Week 9 — Classes

Game result: the game uses `Player`, `Enemy`, `Bullet`, and `Item` objects.

Concepts: classes, `initialize`, instance variables, and object methods.

#### Week 10 — Objects collaborating

Game result: bullets damage enemies and enemies affect the player.

Concepts: passing objects to methods, health, damage, and object interaction.

#### Week 11 — Sprite sheets

Game result: the player has idle and walking animation.

Concepts: frames, sprite sheets, animation timers, and direction.

Pyxel Edit: create idle and walking frames.

#### Week 12 — Animation states

Game result: the player can idle, walk, attack, get hurt, and die.

Concepts: state machines, animation selection, cooldowns, and timed actions.

### Unit 4 — Grid worlds and simple AI

#### Week 13 — Maze data

Game result: a maze is generated from a two-dimensional array.

Concepts: rows, columns, grid coordinates, and tile data.

#### Week 14 — Maze movement

Game result: the player moves through the maze but not through walls.

Concepts: grid collision, neighbouring cells, and separating level data from game logic.

#### Week 15 — Enemy patrol

Game result: an enemy follows a route.

Concepts: waypoints, loops, direction changes, and patrol state.

#### Week 16 — Enemy chase

Game result: an enemy follows the player.

Concepts: distance, direction, simple AI, and `idle`, `patrol`, and `chase`.

Pyxel Edit: directional enemy animation.

### Unit 5 — Platformers and game feel

#### Week 17 — Gravity and jumping

Game result: the player jumps and falls.

Concepts: gravity, acceleration, velocity, and ground detection.

#### Week 18 — Platform collision

Game result: the player lands on platforms and avoids hazards.

Concepts: horizontal and vertical collision, collision response, and reusable methods.

#### Week 19 — Game feel

Game result: the platformer feels responsive because the camera follows the player and hits produce visible feedback.

Concepts: world and screen coordinates, camera offset, timers, hit flash, screen shake, invincibility frames, and health UI.

Lesson shape:

1. Add a camera offset so the player can move through a larger world.
2. Add a short hit flash when the player takes damage.
3. Add invincibility frames so one collision cannot remove all health.
4. Add a small screen shake timer and tune its strength.
5. Add a health display and predict how it changes after each hit.

Creative challenge: choose one event—landing, collecting an item, defeating an enemy, or reaching a checkpoint—and give it a distinct visual response using a timer, colour, movement, or animation.

#### Week 20 — Platformer vertical slice

Game result: one finished platformer level.

Concepts: checkpoints, game restart, debugging, refactoring repeated code, and playtesting.

### Unit 6 — Local chess

#### Week 21 — Chessboard and pieces

Game result: an 8×8 board displays chess pieces.

Concepts: two-dimensional arrays, coordinates, classes, piece data, and mouse selection.

Pyxel Edit: simple chess piece sprites.

#### Week 22 — Legal movement, captures, and turns

Game result: pawns, rooks, bishops, knights, and queens move legally, capture pieces, and take turns.

Concepts: methods, conditions, rules, blocked paths, captures, and turn management.

```ruby
class Knight
  def legal_move?(from, to, board)
    # A knight moves in an L shape.
  end
end
```

#### Week 23 — King safety, check, and checkmate

Game result: the game prevents illegal moves that leave a king in danger and detects check and checkmate.

Concepts: rule validation, hypothetical board positions, edge cases, state checking, and test positions.

#### Week 24 — Special rules and finished local chess

Game result: castling, promotion, en passant, move history, undo, save/load, and release work in a complete local chess game.

Concepts: move history, special rules, testable game rules, GitHub Actions, README, and release.

The first chess version has no computer opponent and no online server.

## Templates become smaller over time

Early lessons provide most of the program structure. Middle lessons provide a playable structure and a requirement, while Nathan increasingly supplies the examples and implementation. Late lessons provide a game idea or mechanic, and Nathan identifies the state, writes the rules, creates examples, designs the code, and tests it.

```text
EARLY COURSE

rule
example
template
   ↓
student implements


MIDDLE COURSE

requirement
template
   ↓
student derives examples
student implements


LATE COURSE

requirement
   ↓
student identifies state
student writes rules
student creates examples
student designs code
student tests it


AFTER WEEK 24

idea
   ↓
student designs the program
```

The goal is for the design loop to become natural, so that templates eventually provide useful structure without telling Nathan what the solution is.

## Testing approach

Examples and predictions written while designing a mechanic should become automated tests when practical. A prediction is a claim about what the game should do; an automated test checks that claim repeatedly.

GitHub Actions should test rules and data, not visual appearance.

Examples:

- A rook cannot move diagonally.
- A bishop cannot jump over a piece.
- A knight can jump.
- A player cannot move into check.
- Checkmate is detected.
- A generated level has a reachable exit.
- A save file restores the correct position.
- Every item has a valid ID.

## After Week 24

The first assessment is explicit: rebuild one earlier small game from a blank DragonRuby project without looking at the original implementation. Ruby and DragonRuby documentation may be consulted.

The next project is independent development:

1. Rebuild a small game from a blank DragonRuby project without looking at its original implementation.
2. Design an original game.
3. Make a four-to-eight-week vertical slice.
4. Add original Pyxel Edit art and animation.
5. Playtest it.
6. Publish it privately or on itch.io.
7. Join a small game jam.

After that, choose one direction: continue DragonRuby game programming, build the ¾-view procedural hack-and-slash game, add a Ruby chess server, move to a real 3D engine, or deepen pixel art, animation, sound, or level design.

## Repository and setup

See [INSTRUCTION.md](INSTRUCTION.md) for local setup, lesson switching, and sharing between Windows and Mac. Use SPWN for the course's save-point, lesson-sync, and sharing commands.

The active game is `mygame/app/main.rb`. The student works through the lessons in order:

- [00 - Prerequisites](00-prerequisites.md)
- [01 - First project](01-setup/README.md)
- [02 - Movement](02-how-dragonruby-works/README.md)
- [03 - Time and boundaries](03-movement-and-walls/README.md)
- [04 - Collectibles](04-collectibles/README.md)
- [05 - Pong movement](05-pong-movement/README.md)
- [06 - Complete Pong](06-pong-game/README.md)
- [07 - Breakout](07-breakout/README.md)
- [08 - Space Invaders](08-space-invaders/README.md)

Lessons 09 onward will be added as each project is designed. Do not create empty lesson folders just to represent the roadmap.
