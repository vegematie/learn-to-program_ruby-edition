# Working with the course repository

This is a self-directed course. The student prepares, runs, edits, saves, and uploads the game. The teacher pulls the shared work onto a Mac and verifies that the source and assets run there.

## What is shared

The remote repository contains the portable project files:

```text
course-repository/
├── app/main.rb          # game source
├── sprites/             # committed art
├── sounds/              # committed sound, when used
├── data/                # committed game data
├── metadata/            # DragonRuby project metadata
├── lesson folders/      # starters and instructions
└── README.md
```

The DragonRuby engine is not shared through Git. Each computer has its own DragonRuby installation:

```text
Student's Windows computer       Teacher's Mac
DragonRuby Windows executable    DragonRuby Mac executable
        │                                │
        └── local copy of the repo ──────┘
```

Both computers run the same committed `app/main.rb` and assets with their own native DragonRuby runtime.

## SPWN

SPWN is the course's child-friendly Git wrapper. It is distributed as the `spawnpoint` Ruby gem (source: https://github.com/bebekim/spawnpoint).

Install it once on each computer:

```text
gem install spawnpoint
```

This puts the `spwn` command on the PATH on both Windows and Mac.

Useful commands:

- `spwn look` — see the current project state;
- `spwn compare` — see code changes;
- `spwn sync --target <game> --source <lesson>/starter` — load a lesson and its starter assets into the local game;
- `spwn save -m "message"` — commit the current work;
- `spwn upload` — push the commit to the remote;
- `spwn download` — pull shared work; and
- `spwn hop <branch>` — switch to an existing branch.

SPWN currently does not create branches. Create `son-learning` once with Git, then use `spwn hop son-learning` afterward.

## Student workflow

```text
+-----------------------------+
| Student: install DragonRuby |
| and make spwn available     |
+--------------+--------------+
               |
               v
+-----------------------------+
| spwn sync                    |
| lesson/starter --into mygame|
+--------------+--------------+
               |
               v
+-----------------------------+
| Launch local DragonRuby     |
| and play the current game   |
+--------------+--------------+
               |
               v
+-----------------------------+
| Edit code and assets        |
| to make the desired change  |
+--------------+--------------+
               |
               v
+-----------------------------+
| spwn look                   |
| spwn compare                |
+--------------+--------------+
               |
               v
        +------------------+
        | Does it work yet?|
        +----+--------+----+
             |        |
          no |        | yes
             |        v
             |  +-----------------------------+
             |  | spwn save -m "week ..."     |
             |  +--------------+--------------+
             |                 |
             |                 v
             |  +-----------------------------+
             |  | spwn upload                 |
             |  +--------------+--------------+
             |                 |
             |                 v
             |  | Next lesson: sync starter   |
             |  +--------------+--------------+
             |                 |
             +-----------------+
                               |
                               v
                       play and edit again
```

The `no` path is normal. Repeat play, edit, run, and inspect until the game works. Upload only the working checkpoint.

## Teacher verification workflow

```text
+-----------------------------+
| Student: spwn upload        |
| source code and assets      |
+--------------+--------------+
               |
               v
+-----------------------------+
| Teacher: spwn download      |
| on the Mac checkout         |
+--------------+--------------+
               |
               v
+-----------------------------+
| Teacher runs local Mac      |
| DragonRuby with the repo   |
+--------------+--------------+
               |
               v
+-----------------------------+
| Teacher verifies the game  |
| and reports any issue       |
+-----------------------------+
```

The teacher does not need the student's Windows executable. The teacher needs the pushed source files and committed assets.

## Cumulative project

The student keeps improving one `mygame` through the prepared lessons:

1. `01-setup/`
2. `02-how-dragonruby-works/`
3. `03-movement-and-walls/`
4. `04-collectibles/`
5. `05-pong-movement/`
6. `06-pong-game/`
7. `07-breakout/`
8. `08-space-invaders/`

Before a new lesson, sync that lesson's starter into the local game:

```text
spwn sync --target ../dragonruby/mygame --source 03-movement-and-walls/starter
```

Then launch DragonRuby, edit the marked code, and save the working result. Do not replace the cumulative project with a blank game.

## Assets

Assets that the teacher must be able to verify belong in the repository under `sprites/`, `sounds/`, or `data/` and must be committed with the code that uses them. Do not rely on an asset that exists only on the student's Windows computer.

Use lowercase filenames without spaces, such as `sprites/hero/blue-dragon.png`.

## Branch and checkpoint model

Use one long-lived `son-learning` branch rather than one branch per lesson. A branch is only version history; DragonRuby runs whichever local folder is currently selected.

The student saves checkpoints such as:

```text
spwn save -m "week 03: keep the player on screen"
spwn upload
```

The teacher receives those commits with:

```text
spwn download
```

No lesson-by-lesson merge is needed. The teacher verifies the student's uploaded contribution on the Mac checkout.
