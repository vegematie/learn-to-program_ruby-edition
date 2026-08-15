# 01 - First project

## Your goal this week

Get a playable DragonRuby game on your computer, make a dragon show up, and change what the game draws.

By the end of the week you should be able to say:

- I made the folders for my game;
- I opened DragonRuby from the terminal;
- I opened the game in Sublime Text;
- I changed `main.rb` and saw the game change;
- I saved my work with SPWN.

## Tools you will use

These are the tools for this course. You do not need to understand everything about them yet. You are learning the smallest useful piece of each one first.

- **File Explorer** — your folders and files.
- **PowerShell** — a place where you can open DragonRuby and move around folders.
- **Sublime Text** — where you write the game.
- **DragonRuby** — the game engine that runs your game.
- **SPWN** — the tool that downloads lessons, saves your progress, and sends your work to your teacher.

Do not worry about Git, GitHub, or the separate Ruby install yet. They are there, but you do not use them directly in week 1.

## What your game folder should look like

After setup, your game folder should look like this:

```
Documents
└── game-dev
    └── dragonruby
        ├── dragonruby.exe
        ├── samples
        ├── docs
        └── mygame
            ├── app
            │   └── main.rb
            ├── sprites
            ├── sounds
            └── metadata
```

`dragonruby.exe` is the DragonRuby program.

`mygame` is where your game lives.

`mygame/app/main.rb` is the file you will edit first.

## Step 1: make the parent folder

Open **File Explorer**.

1. Click **Documents** on the left.
2. Right-click an empty space.
3. Choose **New**, then **Folder**.
4. Name the folder `game-dev`.

Use lowercase letters and the hyphen. Do not put a space in the name.

## Step 2: find your DragonRuby download

1. Open **File Explorer**.
2. Go to **Downloads**.
3. Find the DragonRuby ZIP file.
4. Right-click it.
5. Choose **Extract All**.
6. Extract it somewhere for now using the default suggestion.

DragonRuby has to be extracted. Do not try to run it while it is still inside the ZIP file.

## Step 3: move DragonRuby into your game folder

1. Open the folder that was just extracted.
2. Find the folder that contains `dragonruby.exe`, `mygame`, `samples`, and `docs`.
3. Rename that folder to `dragonruby`.
4. Move the whole `dragonruby` folder into `Documents\game-dev`.

When you are done, DragonRuby should be here:

```
Documents
└── game-dev
    └── dragonruby
```

## Step 4: check that DragonRuby is in the right place

Open the `dragonruby` folder. You should see:

- `dragonruby.exe`
- `mygame`
- `samples`
- `docs`

If you instead see another folder inside it, and `dragonruby.exe` is hidden one level deeper, move the contents up. You want `dragonruby.exe` to be directly inside `dragonruby`.

## Step 5: turn on file name extensions

This helps you avoid files like `main.rb.txt` when you meant to make `main.rb`.

1. In File Explorer, choose **View**.
2. Choose **Show**.
3. Turn on **File name extensions**.

## Step 6: find the file you will edit

Open the folder path:

`dragonruby` → `mygame` → `app` → `main.rb`

Do not change it yet. Just find it.

## Step 7: open the whole game in Sublime Text

1. Open **Sublime Text**.
2. Choose **File**, then **Open Folder**.
3. Choose:
   `Documents\game-dev\dragonruby`
4. Click **Select Folder**.

The left sidebar should show:

- `docs`
- `mygame`
- `samples`

If you expand `mygame`, you should be able to see `app` and `main.rb`.

## Step 8: your first terminal

You will now use PowerShell to open DragonRuby.

### Open PowerShell

1. Press the **Windows key**.
2. Type `PowerShell`.
3. Choose **Windows PowerShell** or **PowerShell**.

Do **not** choose “Run as administrator.”

Your screen may look something like this:

```
PS C:\Users\YourName>
```

The part before the `>` tells you which folder you are standing in right now.

### Four commands to learn first

1. **Where am I?**
   ```
   pwd
   ```
   This prints the folder you are in.

2. **What is here?**
   ```
   ls
   ```
   This lists the files and folders in your current folder.

3. **Go into another folder**
   ```
   cd Documents
   cd game-dev
   cd dragonruby
   ```
   After each one, you can use `pwd` and `ls` to check where you are.

4. **Go back up**
   ```
   cd ..
   ```
   This moves you to the folder above the one you are in.

### A useful trick

Instead of typing the whole folder name, type the first few letters and press **Tab**.

For example:

```
cd dra
```

If you press **Tab**, PowerShell may finish it for you.

This helps you type less and make fewer mistakes.

### The two special folders

- `.` means “the folder I am in right now.”
- `..` means “the folder above this one.”

### Open DragonRuby

When you are inside the folder that contains `dragonruby.exe`, run:

```
.\dragonruby.exe
```

The `.\` means:

> Run the program called `dragonruby.exe` from the folder I am in right now.

Important: typing only `dragonruby.exe` may not work, even when `ls` shows the file.

DragonRuby should open and run your game.

### Stop DragonRuby

You can stop it with:

- **Ctrl+C** in PowerShell, or
- closing the DragonRuby window.

## Step 9: set up Git once

Before you clone anything, Git may ask for your name and email the first time you use it on this computer.

If you are not sure whether this has been done yet, an adult can run these two commands once in PowerShell:

```
git config --global user.name "Nathan"
git config --global user.email "nathan@example.com"
```

Use Nathan’s real name and email if you have them.

You only need to do this once per computer. After that, Git remembers it.

If Git already works, you do not need to run these commands again.

## Step 10: get the course repo

The lesson lives in a Git repository on GitHub.

This is the first time you will use Git. It is normal if this feels like a lot. Ask for help the first time if you need it.

You can get the course repo in two ways:

- **PowerShell and Git**, or
- **GitHub Desktop**.

Pick one. If you are unsure, use the first one and follow the numbered steps.

### Option 1: use PowerShell and Git

1. Open **PowerShell**.
2. Go to your `game-dev` folder:
   ```
   cd Documents
   cd game-dev
   ```
3. Clone the course repo:
   ```
   git clone https://github.com/vegematie/learn-to-program_ruby-edition
   ```
4. Wait for it to finish.
5. When it is done, you should see a new folder inside `game-dev` for the course.

The folder name will be `learn-to-program_ruby-edition`, unless a different name was used when cloning.

### Option 2: use GitHub Desktop

If you have **GitHub Desktop** on your computer, you can use that instead.

1. Open **GitHub Desktop**.
2. Choose **File**, then **Clone repository**.
3. Find the course repository:
   `https://github.com/vegematie/learn-to-program_ruby-edition`
4. Choose a place to put it, or accept the default.
5. Click **Clone**.
6. When it is done, find the course folder in **File Explorer**.
7. Move that folder into `Documents\game-dev` if it is not already there.

After cloning, you should have a course folder inside `game-dev`.

### What to do after cloning

Whichever way you used, you should now have a course folder inside `game-dev`.

Do not worry about branches or commits yet. You only need the course folder for now.

## Step 11: get SPWN

SPWN is a separate tool. It is not inside the course repo. You need it before the next step.

SPWN is a small Ruby program called a gem. Ruby is already on your computer, so you can install SPWN yourself:

1. Open **PowerShell**.
2. Type:
   ```
   gem install spawnpoint
   ```
3. Wait for the install to finish.

If the install does not work, stop here and ask the adult to look at the setup note in `SETUP.md`.

### Check that SPWN is ready

1. Open **PowerShell**.
2. Type:
   ```
   spwn --version
   ```
3. If PowerShell shows a version number, SPWN is ready.
4. If PowerShell says it does not know `spwn`, SPWN is not installed yet. Ask an adult to finish setting it up.

Do not continue to Step 12 until `spwn --version` works.

## Step 12: use SPWN to copy the lesson into your game

SPWN is the tool that copies a lesson from the course repo into your DragonRuby `mygame` folder.

Do this in **PowerShell**.

1. Open PowerShell.
2. Go into the course repo folder:
   ```
   cd Documents
   cd game-dev
   cd learn-to-program_ruby-edition
   ```
3. Run SPWN:
   ```
   spwn sync 01-setup/starter --into ../dragonruby/mygame
   ```

The first time a lesson copies a file that already exists in your game folder, SPWN asks before replacing it.

After this step, your `mygame` folder should contain the files for this lesson.

## Step 13: prove the whole loop

Do these in order:

1. Open DragonRuby from PowerShell.
2. Open `mygame/app/main.rb` in Sublime Text.
3. Change the message in the file.
4. Save the file.
5. Look at DragonRuby and see whether it changed.
6. Stop DragonRuby or close it.
7. Save your work with SPWN.

Your SPWN save command is:

```
spwn save -m "week 01: first project"
```

## Exercise 1.1 - Change a value

In `mygame/app/main.rb`, find this line:

```ruby
message = "Hello, Dragon!"
```

Change the text between the quotation marks.

Save the file and look at the game.

The message is a **string value**. A variable is the name that holds the value. Here, the variable is `message` and the value is `"Hello, Dragon!"`.

## Exercise 1.2 - Move the player

Find these lines:

```ruby
dragon_x = 540
dragon_y = 260
```

Change one number at a time.

Save and play after each change.

These are **number values**. They control where the dragon is drawn.

## Exercise 1.3 - Make it yours

Pick one small change:

- write a new message;
- move the dragon to a place you like;
- or change the dragon’s size.

Save, play, and then save a checkpoint:

```
spwn look
spwn save -m "week 01: first project"
spwn upload
```

## Checkpoint

You are done when you can say:

- `main.rb` is the game code;
- a variable holds a value;
- `args.outputs` is how the game draws things; and
- saving `main.rb` changes the game in DragonRuby.

Next: [02 - Movement](../02-how-dragonruby-works/README.md).

---

## Art milestone

If you are ready, draw a simple 16×16 player sprite in Pyxel Edit and save it under `sprites/`.

You can keep using the picture DragonRuby already gives you for now.
