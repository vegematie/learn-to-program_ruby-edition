# 01 - First project

## Week 1 outcome

Load a playable DragonRuby project, make a dragon player appear, and change what the game draws.

## Concepts

- Files and folders
- Ruby values
- Variables
- Drawing
- DragonRuby project structure
- The first SPWN save-point

## Load the lesson

From the course repository, run:

```text
spwn sync 01-setup/starter --into mygame
```

Open your local DragonRuby folder and double-click its ordinary executable. Open `mygame/app/main.rb` in Sublime Text.

The game should show a dragon and a message. Saving the Ruby file should reload the game.

## Exercise 1.1 - Change a value

Find:

```ruby
message = "Hello, Dragon!"
```

Change the text inside the quotation marks. Save and play. The message is a **string value** held by the variable `message`.

## Exercise 1.2 - Move the player

Change one of these numbers:

```ruby
dragon_x = 540
dragon_y = 260
```

Save and play after each change. These are number values held by variables. They control where the dragon is drawn.

## Exercise 1.3 - Make it yours

Choose one small creative change:

- write a new message;
- move the dragon to a favourite place; or
- change the dragon's size.

Then save a checkpoint:

```text
spwn look
spwn save -m "week 01: first project"
spwn upload
```

## Checkpoint

You are done when you can explain:

- `main.rb` is the game code;
- a variable holds a value;
- `args.outputs` draws something; and
- your local DragonRuby reloads the game after saving.

Next: [02 - Movement](../02-how-dragonruby-works/README.md).

---

## Art milestone

If you are ready, draw a simple 16×16 player sprite in Pyxel Edit and commit it under `sprites/`. The supplied DragonRuby picture is fine for now.
