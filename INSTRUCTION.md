# Adult instructions

This file is for the parent/teacher. The child should use the lesson `README.md` files instead.

## The simple model

Use one DragonRuby installation, one `mygame` folder, and one GitHub repository.

```text
dragonruby-windows-amd64/       # installed once by the parent
├── dragonruby.exe              # the child double-clicks this
└── mygame/                     # also the GitHub repository
    ├── app/main.rb             # the one active game
    ├── sprites/
    ├── metadata/
    ├── 01-setup/               # lesson instructions and template
    ├── 02-how-dragonruby-works/
    └── ...
```

DragonRuby's normal double-click behaviour runs the `mygame` folder beside `dragonruby.exe`. The child does not choose a folder, create a shortcut, use a command line, or understand how the engine selected the game.

The GitHub repository is the `mygame` folder. That means the active game and the lesson templates are all tracked together.

## Two different kinds of work

Do not confuse the cumulative lesson game with future standalone games.

### The cumulative lesson game

This is the child's learning path:

- one evolving `mygame`;
- one `son-learning` branch;
- Lesson 01, then Lesson 02, then Lesson 03 building on the previous game;
- one commit after each meaningful lesson checkpoint.

Right now the prepared lessons are:
- `00-prerequisites.md`
- `01-setup/`
- `02-how-dragonruby-works/`
- `03-movement-and-walls/`
- `04-collectibles/`

Do not replace this game with a new game's template.

Do not replace this game with a new game's template.

### A new standalone game

When the child wants to make a different game, create a new game folder from a clean template:

```text
games/
├── _template/                  # parent-prepared complete DragonRuby game
├── space-adventure/            # copied from _template
├── coin-dash/
└── dragon-rescue/
```

Each standalone game has its own `app/main.rb`, `sprites/`, `sounds/`, `fonts/`, `data/`, and `metadata/`. The child can learn how to create this folder from the template, but the template itself is still supplied by the parent.

DragonRuby runs one game folder at a time. The parent selects a standalone game by using the DragonRuby Windows launcher with that game's folder, or by preparing a simple one-click launcher for it. The DragonRuby engine is installed once; it is not copied into every game.

Standalone games can live in the same `son-learning` branch and repository while the project is small. Give each game a clear folder name and commit its work normally. A separate repository is only needed if a game becomes a genuinely separate project.

## Downloaded assets

The parent can provide password-protected asset packs through Google Drive or Dropbox. The password must never be stored in GitHub, README files, scripts, or commit messages.

The parent should:

1. Download and unzip the asset pack.
2. Check that the files are appropriate and licensed for the project.
3. Keep the folder structure ready to copy into the game, for example `sprites/hero/` or `sounds/`.
4. Copy the assets into the selected game's folders.
5. Tell the child which asset names are available.

Use lowercase filenames without spaces or capital letters, such as `sprites/hero/blue-dragon.png`. Sound can be introduced later; it is not part of the first programming lessons.

## Use one child branch, not one branch per lesson

Keep `main` as the clean course branch. Create one long-lived branch for the child, such as `son-learning`, and use it for every lesson.

- A **folder** contains code and game assets.
- A **branch** is a version-history line in Git.
- DragonRuby runs the `mygame` folder; it does not run a Git branch.

The parent checks out `son-learning` once. The child and parent stay on that branch while teaching. The lesson number is represented by the lesson folder and commit message, not by a new branch.

### Why not create one branch per lesson?

Suppose `lesson-03` is created before Lesson 02 is finished:

```text
main:        lesson 01
lesson-03:   lesson 01

main later:  lesson 01 + completed lesson 02
lesson-03:   still based on lesson 01
```

Both lines may then change the same `mygame/app/main.rb` from different starting points. Merging Lesson 03 later can produce conflicts or accidentally discard the Lesson 02 changes. One continuous `son-learning` branch avoids that problem.

## Lesson structure

The course is a cumulative game. The child keeps improving the same `mygame` rather than starting a new game for every lesson.

The first lesson provides the initial template:

```text
01-setup/
├── README.md
├── starter/                    # initial/recovery template
│   └── app/main.rb
└── target/                     # finished state for comparison
    └── app/main.rb
```

Later lessons provide a README and a target state. They assume the previous lesson's working `mygame` and add one small feature to it. The child never builds a project from an empty file.

For Lesson 04, the target adds a coin list, a score label, and simple overlap detection. The starter and target are identical, because the feature is already complete in the starter; the student edits the coin list rather than typing the whole thing.

## One-time setup

1. Extract the Windows DragonRuby zip.
2. Keep the extracted `dragonruby-windows-amd64` folder intact.
3. In GitHub Desktop, clone this repository.
4. Put the course repository in the engine's `mygame` location. The parent may need to rename the original example `mygame` first and then place the cloned course repository there.
5. In GitHub Desktop, create a branch named `son-learning` from `main` and check it out.
6. Confirm the folder beside `dragonruby.exe` is named `mygame` and contains `app/main.rb`.
7. Double-click `dragonruby.exe`. It should run the course's active game.

The exact installation is a parent job. Once it works, the child should not need to repeat it.

## Starting the first lesson

For Lesson 01 only:

1. Copy the Lesson 01 `starter` contents into the active `mygame` folder.
2. Commit that initial working game on `son-learning`.
3. Double-click the ordinary `dragonruby.exe`.
4. Confirm the starter game already runs.
5. Give the child the lesson README and open `mygame/app/main.rb` in Sublime Text.

## Starting a later lesson

Before each new lesson, whether that is later the same day or another week:

1. Make sure the previous lesson is committed on `son-learning` in GitHub Desktop.
2. Open the next lesson's README. Do not replace `mygame` with a new starter.
3. Double-click the ordinary `dragonruby.exe`.
4. Confirm the previous game still runs.
5. Give the child the lesson README and open `mygame/app/main.rb` in Sublime Text.

The child changes only the marked lines in the existing game. When he saves, DragonRuby reloads the one `mygame` folder.

## Finishing a lesson

1. The child saves and plays the game.
2. The parent reviews the changed files in GitHub Desktop.
3. The parent commits directly to `son-learning`, for example `lesson 02: move the dragon`.
4. The parent clicks **Push origin**.

There is no lesson-by-lesson checkout and no lesson-by-lesson merge. If he finishes three lessons in one afternoon, repeat this process three times and keep making normal commits on `son-learning`:

```text
start lesson 01 -> complete lesson 01
start lesson 02 -> complete lesson 02
start lesson 03 -> complete lesson 03
```

If he stops halfway through a lesson, either leave the game until the next session or make a clearly named checkpoint commit such as `lesson 02: halfway point`. Do not reset `mygame` unless deliberately recovering an earlier checkpoint.

`son-learning` is the child's complete working branch. Leave it there; merging it back into `main` is not part of the course.

Double-clicking `dragonruby.exe` runs the local `mygame` folder. DragonRuby does not know or care which Git branch is checked out. GitHub Desktop only records the history of whichever branch is currently selected.

If something goes wrong, GitHub Desktop can restore the previous lesson checkpoint. The later lesson's `target` is also available for comparison or rescue.

The DragonRuby engine, samples, and bundled documentation are installed once and are not committed to GitHub.
