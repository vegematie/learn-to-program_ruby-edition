# Adult wiring note for week 1

This note is for the adult helping Nathan. It is not for Nathan to follow directly.

## What is already installed

- Ruby 4.0.6 on Windows.
- Git on Windows.
- Sublime Text.
- GitHub account.
- DragonRuby DevKit downloaded.

Nothing is wired yet.

## What still needs to happen

1. Folder setup in File Explorer.
2. DragonRuby extracted and moved into `Documents\game-dev\dragonruby`.
3. First PowerShell lesson: navigate and launch DragonRuby.
4. Git configured once, if this is Nathan’s first Git setup on this computer.
5. Git clone of the course repo into `game-dev`.
6. SPWN installed with `gem install spawnpoint`.
7. SPWN used to copy the lesson into `mygame`.
8. Sublime used to open the whole dragonruby folder.
9. One full loop proven: edit `main.rb`, see the change, then `spwn save`.

## Target folder layout

```
Documents
└── game-dev
    ├── dragonruby
    │   ├── dragonruby.exe
    │   ├── samples
    │   ├── docs
    │   └── mygame
    │       ├── app
    │       │   └── main.rb
    │       ├── sprites
    │       ├── sounds
    │       └── metadata
    └── learn-to-program_ruby-edition
```

`mygame` is the working folder. The lesson is copied into it from the course repo. Nathan edits `mygame/app/main.rb`.

SPWN is installed as a Ruby gem, so there is no `spawnpoint` folder in `game-dev`. The `spwn` command works in PowerShell from any folder. The README assumes `spwn` works; this note records what the adult has to do to make that true.

## Nathan-facing setup is in the README

The README is written for Nathan:

- make `Documents\game-dev`;
- extract and move DragonRuby;
- turn on file extensions;
- find `mygame/app/main.rb`;
- open the whole dragonruby folder in Sublime;
- learn `pwd`, `ls`, `cd`, `cd ..`, and `.\dragonruby.exe`;
- run the one-time Git config if needed;
- clone the course repo into `game-dev`, using PowerShell/Git or GitHub Desktop;
- install SPWN with `gem install spawnpoint`;
- use `spwn sync --target ../dragonruby/mygame --source 01-setup/starter` to copy the lesson into `mygame`;
- prove the edit → run → save loop with `spwn save -m "week 01: first project"`.

Use that order when working with him.

## Git cloning for Nathan

For the first clone, teach him one of these:

- PowerShell and Git:
  ```
  cd Documents\game-dev
  git clone https://github.com/vegematie/learn-to-program_ruby-edition
  ```
- GitHub Desktop, if it is already installed:
  File → Clone repository → choose `vegematie/learn-to-program_ruby-edition` → clone → move the folder into `game-dev` if needed.

The course repo folder should end up inside `game-dev`, beside `dragonruby`.

## SPWN install

SPWN is not inside the course repo. It is distributed as the `spawnpoint` Ruby gem.

Install it once in PowerShell:

```
gem install spawnpoint
```

This puts the `spwn` command on the PATH. SPWN needs Ruby and Git. Both should already be on Nathan’s machine.

## SPWN command path

Because SPWN is installed as a gem, the `spwn` command works from any folder. The README and lessons use plain `spwn ...` commands.

## SPWN’s job in this course

SPWN is the child-facing sync tool. It hides Git from Nathan at first.

Its job here is:

- copy lessons from the course repo into DragonRuby’s `mygame`;
- save checkpoints as Git commits;
- let his progress move to the shared project space.

Every lesson should end with a save:

```
spwn look
spwn save -m "week 01: first project"
spwn upload
```

## Parent checkpoint for week 1

Before moving on, Nathan should be able to show:

- `dragonruby.exe` in File Explorer;
- `mygame\app\main.rb`;
- the whole `dragonruby` folder open in Sublime Text’s sidebar;
- DragonRuby running from PowerShell;
- one edit to `main.rb` that visibly changes the game;
- one `spwn save` completed.

## What to leave alone for now

Do not connect Ruby 4.0.6 to DragonRuby.

Do not make the GitHub website Nathan’s normal workflow.

Do not teach Git commands beyond the first clone and the one-time config.

Do not teach `subl .` in the first lesson unless Sublime’s command-line launcher is already on the PATH.

## What still needs to be decided

Before treating this note as final, decide:

- whether GitHub Desktop is already installed on Nathan’s machine, or whether you want to teach only the PowerShell clone for now.
