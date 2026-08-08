# Adult notes for future games and lessons

This folder is for the parent/teacher. The student should work from the lesson README files, not from this document.

## Current course shape

- `00-prerequisites.md` — before the first game
- `01-setup/` — first working game
- `02-how-dragonruby-works/` — movement and the heartbeat
- `03-movement-and-walls/` — the first `if` rules
- `04-collectibles/` — coins and score
- later lessons — to be added one at a time

The course is cumulative. Each lesson continues the same `mygame` game. Only Lesson 01 needs a fresh starter.

## The active game lives in `mygame`

Right now the working course game lives here:

- `mygame/app/main.rb`

That file should match the latest finished lesson on the `son-learning` branch.

Lesson `starter/` and `target/` folders are rescue and reference copies. They are not the student's active game unless a lesson tells the parent to copy one in.

## How to add another lesson

Use `LESSON-TEMPLATE.md` as the shape.

Each lesson needs:
- `NN-short-title/README.md`
- `NN-short-title/starter/app/main.rb` only for the first lesson or for recovery
- `NN-short-title/target/app/main.rb`

A cumulative lesson should:
1. continue the previous lesson's working game
2. add one visible feature
3. keep the student change small, usually a few lines

Do not ask the student to build a project structure from scratch.

## How to create a new standalone game

When the student wants a different game, do not edit the lesson game. Create a new game folder from a clean template.

Example shape:

```text
games/
├── _template/
│   ├── app/main.rb
│   ├── sprites/
│   ├── sounds/
│   ├── fonts/
│   ├── data/
│   └── metadata/
├── space-adventure/
├── coin-dash/
└── dragon-rescue/
```

Each standalone game keeps its own:
- `app/main.rb`
- `sprites/`
- `sounds/`
- `fonts/`
- `data/`
- `metadata/`

The engine is installed once. It is not copied into every game.

## How to prepare a new game template

Before the student starts a new game:

1. Make one clean template game in `games/_template/`.
2. Make sure it runs from a fresh folder.
3. Include only the files a new game should start with.
4. Do not put the template inside the student's active `mygame`.
5. Show the student how to copy the template folder and rename it.

The student should be able to make a new game by copying one folder and opening the copy in DragonRuby.

## Asset packs from Google Drive or Dropbox

The parent may provide password-protected asset packs.

Before giving assets to the student:
1. Download the pack.
2. Unzip it.
3. Check the files are appropriate and allowed for this project.
4. Put them in a clean folder structure, for example:
   - `sprites/player/`
   - `sprites/enemy/`
   - `sprites/items/`
   - `sounds/`
5. Copy the needed files into the student's game folder.
6. Tell the student the exact filenames they can use.

Use simple lowercase filenames without spaces, like:
- `sprites/player/blue-dragon.png`
- `sprites/items/coin.png`

Do not store passwords in:
- GitHub
- README files
- code comments
- scripts
- commit messages

## Recommended asset folders for this course

For early lessons, keep assets simple:

- `sprites/` — pictures used by the game
- `sounds/` — sound later, not needed for the first lessons
- `fonts/` — optional
- `data/` — optional simple data files later

For a standalone game, it is fine to use subfolders by role:

- `sprites/player/`
- `sprites/enemies/`
- `sprites/items/`
- `sprites/tiles/`
- `sounds/sfx/`
- `sounds/music/`

Keep the folder names short and easy to type.

## Lesson planning idea list

Use `resources/game-mechanics.md` when you want the next visible feature. A good lesson is one small visible change, not a long explanation.

Good next lesson ideas after walls:
- collectibles and score
- a simple enemy or obstacle
- touching something and getting hurt
- winning and losing
- a second sprite
- simple animation by swapping pictures

## Git habit for new games

If a standalone game stays small, it can live in the same repository and branch for now. Give it a clear folder name and commit normally.

Move it to its own repository only when it becomes a separate project in practice.

## What the student should learn next

The student should learn how to:
- make a new game folder from a template
- put sprites into the right folder
- open the new game in DragonRuby
- change one thing and see it immediately

That is enough for a first independent game. The code can stay tiny.
