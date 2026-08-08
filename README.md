# Make Games with DragonRuby

A small, game-first programming course for a 12-year-old beginner who knows Scratch. Every lesson is a playable DragonRuby project with a few lines to change.

This is not a Ruby course first. It is a “make the game do something cool” course. New words are introduced only when the game needs them.

## The template rule

Every lesson starts with a working game. The student never starts with a blank project and never has to type a whole game from a book. Most lessons continue the same game; only the first lesson needs a fresh starter.

Each lesson provides:

- `README.md` - one tiny mission and the instructions.
- `starter/` - the initial complete game, used for Lesson 01 and recovery.
- `target/` - the finished state to compare with after trying.

The student changes one or two lines, saves, plays, and sees the lesson work. Everything else is scaffolding supplied by the course or prepared by the parent. The child keeps editing the same active `mygame` and always double-clicks the ordinary DragonRuby executable.

## Start here

This course assumes **Windows 11 Education** and these tools:

- [GitHub Desktop](https://desktop.github.com/) - saving and sharing the project.
- [Sublime Text](https://www.sublimetext.com/) - editing the code.
- [DragonRuby Game Toolkit](https://dragonruby.itch.io/dragonruby-gtk) - running the game.
- Ruby - small experiments when a lesson calls for them. DragonRuby runs its own game code.
- Pyxel Editor - making tiny pixel-art images later.

Adults: see [INSTRUCTION.md](INSTRUCTION.md) for setup and lesson-switching instructions.

1. **Parent:** install the tools and fork this repository in GitHub Desktop.
2. **Student:** open `dragonruby-windows-amd64\\mygame\\app\\main.rb` in Sublime Text.
3. **Student:** change one small thing, save, and play.

The course uses one short loop: change a few lines, save, play the game, celebrate, then save a GitHub snapshot. The parent handles confusing Git steps at first.

## Lessons

| Lesson | Game result | Programming idea |
| --- | --- | --- |
| [00 - Prerequisites](00-prerequisites.md) | A ready-to-use GitHub repo | Files, folders, commits |
| [01 - Setup](01-setup/README.md) | A greeting and a dragon | Editor, engine, live reload |
| [02 - How DragonRuby works](02-how-dragonruby-works/README.md) | A moving, wrapping dragon | `tick`, input, state, coordinates |
| 03 - Movement and walls | The dragon stays on screen | Variables and conditionals |
| 04 - Collectibles | A score goes up | Lists, overlap, incrementing |
| 05 - Patrol NPC | An enemy follows a route | Loops and simple state |
| 06 - Health and damage | Win and lose | State machines |
| 07 - Art and game feel | A game that looks like yours | Pixel art and feedback |
| 08 - Ship it | A finished game others can play | Packaging and release |

Sound comes after the core game works. Pyxel Editor is an optional art tool, not a second programming course. Meshy can be an optional later experiment for making art ideas, but it is not needed to learn programming.

The course game and future games use different workflows: lessons extend one cumulative game; a new game starts from a separate clean template. Adults should read [INSTRUCTION.md](INSTRUCTION.md) before creating additional games or importing asset packs.

To make a new game later, copy one clean template folder and give it its own `app/main.rb`, `sprites/`, `sounds/`, `fonts/`, `data/`, and `metadata/`. The student learns to make a new game by copying a ready folder, not by building one from scratch. See [adult notes for future games](00-adult-notes-for-future-games.md) for the template rule and asset folder ideas.

Adults can use the [game mechanics map](resources/game-mechanics.md) to plan the next visible programming idea. State machines and hierarchical states are later organising tools, not starting topics.

## What is ready now

- Lesson 00: prerequisites
- Lesson 01: first game setup
- Lesson 02: movement and the heartbeat
- Lesson 03: walls and `if`
- Lesson 04: collectibles and score

The working course game lives in `mygame/app/main.rb`. Lessons 05 onward still need to be written.

## What comes next

After Lesson 04, the next visible ideas are:
- a patrol enemy
- something that hurts the player
- winning and losing

One lesson at a time. Keep each one small enough for one short session.

## Git habit

Git is the game's rewind button. The parent can do the first commits while the student learns. Later, the student can use GitHub Desktop's **Commit** and **Push origin** buttons after every working change.

Keep the commit message about what the player can now see or do.

## Teaching rhythm

- One session: 20-40 minutes.
- One visible change per exercise.
- Read code together; do not require memorisation.
- Stop while the game is still fun.
- Let the student choose names, colours, characters, and the next tiny feature.
- If an exercise takes more than a few minutes to understand, the parent reveals the target or supplies the missing line. The lesson is the goal, not solving a puzzle unaided.

## Source material

The lessons are adapted from the beginner path in *Building Games with DragonRuby* v1.2 and the DragonRuby samples/docs. The book is a reference, not homework: use it when a lesson points you there or when curiosity wins.
