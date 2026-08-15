# 00 - Before the first game

## Goal

Get your Windows game workspace ready. You will install the tools, load the lesson files, and run the game yourself.

## What you need

- Windows 11 Education.
- A GitHub account.
- SPWN, the course's child-friendly Git wrapper.
- Sublime Text.
- [DragonRuby Game Toolkit](https://dragonruby.org).
- Ruby, for small Ruby experiments later.
- Pyxel Editor, optional for pixel art later.

The student does not need to learn what an engine, a binary, or a Ruby gem is yet. For now: DragonRuby is the program that runs the game, and `main.rb` is the file we change.

## Your setup

1. Open this repository on GitHub.
2. Click **Fork**. Your fork is your copy of the course.
3. Clone this repository, then install SPWN with `gem install spawnpoint`.
4. Select the fork and choose a simple folder, such as `Documents\dragonruby-curriculum`.
5. Download the Windows DragonRuby zip.
6. Right-click the zip, choose **Extract All**, and keep the folder named `dragonruby-windows-amd64` intact.
7. Put it somewhere easy to find, such as `Documents\DragonRuby\dragonruby-windows-amd64`.
8. Open the curriculum folder in Sublime Text when a lesson asks you to.
9. From the repository folder, use `spwn save -m "start the course"`, then `spwn upload`.

SPWN keeps snapshots of your game. If you break something, you can return to an earlier checkpoint. There is no need to learn Git internals yet.

## First lesson load

From the course repository, load the first playable lesson into your local DragonRuby game folder:

```text
spwn sync 01-setup/starter --into mygame
```

Then open `mygame/app/main.rb` in Sublime Text and double-click your local DragonRuby executable. The lesson starter and any committed assets are now in your copy of the game.

## Checkpoint

Open the DragonRuby folder and point to `mygame\app\main.rb`. This is the first file we will change. Then continue to [Lesson 01](01-setup/README.md).
