# 01 - Set up DragonRuby

## Mission

Make a dragon and a message appear, then change the message without restarting the game.

Today’s new words are just **code** (instructions) and **sprite** (a picture in the game).

## Parent prepares the game once

After extracting the zip, open the folder called `dragonruby-windows-amd64`. It contains a ready-to-run example game. The folders that matter first are:

```text
dragonruby-windows-amd64/
├── dragonruby.exe       # starts the game
├── dragonruby.png       # the example DragonRuby picture
├── mygame/              # the game we are making
│   ├── app/main.rb      # the code we change
│   ├── sprites/         # pictures for the game
│   ├── sounds/          # sounds later
│   ├── fonts/
│   ├── data/
│   └── metadata/
├── samples/             # example games to explore later
└── docs/                # reference material for parents
```

Do not rename or move files inside the DragonRuby folder yet. Work inside `mygame`. If copying folders feels confusing, the parent should do it before the session.

## First launch - do this together

1. Open the `dragonruby-windows-amd64` folder.
2. Double-click `dragonruby.exe`. Windows may ask whether you want to run it; choose **Run**.
3. A game window appears. This is the example game that came with DragonRuby.
4. Close the game window for a moment.
5. Open `01-setup\starter\app\main.rb` from the curriculum in Sublime Text. This is a ready-made game, not a blank file.
6. Copy all of that file.
7. Open `dragonruby-windows-amd64\mygame\app\main.rb` in Sublime Text.
8. Select all, paste the starter code, and save.
9. Double-click `dragonruby.exe` again.
10. Change `Hello, Dragon!` to your own message and save. Try a silly message first.

The game should update automatically when you save. This is called **live reload**. It means we can change the code, save, and see the result quickly without building a complicated project.

## Exercise 1.1 - Make it yours

Change the message. Play it. Ask the parent to save a GitHub snapshot with GitHub Desktop's **Commit to main** and **Push origin** buttons. You do not need to understand GitHub Desktop yet.

## Exercise 1.2 - Move the picture

In `mygame\app\main.rb`, change the dragon's `x` and `y` numbers. Save after each change and see which direction is up, down, left, and right. You do not need to understand every other line yet.

## Checkpoint

You are done when you can explain: “`main.rb` is my code, `args.outputs` puts things on the screen, and saving reloads the game.”

Next: [How DragonRuby works](../02-how-dragonruby-works/README.md).
