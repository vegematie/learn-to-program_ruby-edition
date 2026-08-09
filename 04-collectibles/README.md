# 04 - Collectibles

## Week 4 outcome

Make the dragon collect stars and gain points.

## New idea

An array is a list of things. The game loops over the stars, checks each one, and removes a star when the dragon touches it.

```text
for each star:
  if the dragon touches it:
    remove the star
    add 1 to the score
```

Today’s Ruby ideas are arrays, loops, collision, score, and removing objects.

## Load the lesson

Make sure Week 3 is saved, then run:

```text
spwn sync 04-collectibles/starter --into mygame
```

Launch your local DragonRuby and open `mygame/app/main.rb` in Sublime Text.

If the game gets messy, copy `04-collectibles/starter/app/main.rb` into `mygame/app/main.rb` and start again.

## Exercise 4.1 - Read the star array

Near the top of the file, find:

```ruby
args.state.stars ||= [
  { x: 200, y: 200 },
  { x: 600, y: 400 },
  { x: 1000, y: 200 }
]
```

This array contains three stars. Each star is a small data record with an `x` and a `y`.

Change one number, save, and play. Watch that star move.

## Exercise 4.2 - Add a star

Add a fourth star inside the array:

```ruby
{ x: 900, y: 100 },
```

Save and play. Walk the dragon over the new star and watch the score increase.

## Exercise 4.3 - Follow the loop

Find the code that loops over the stars. Read it out loud:

> “For each star, check whether the dragon touches it.”

The star disappears because `reject!` removes it from the array. The score increases at the same time.

## Checkpoint

You are done when you can say:

- “The stars are stored in an array.”
- “The game loops over every star.”
- “Collision tells the game when to remove a star.”
- “The score goes up when a star is removed.”

Save the working result:

```text
spwn look
spwn compare
spwn save -m "week 04: collect stars and score points"
spwn upload
```

Next: Week 5 is Pong. It will introduce position, velocity, direction, collision, and resetting a round.

---

## Adult notes

- This is Week 4 of the integrated curriculum: collectibles.
- The star is a gold square drawn with `args.outputs.solids`, so no asset pack is required.
- `overlap?` is a simple distance check, good enough for a first collectible.
- The starter and target contain the complete collection mechanic; the student changes the array by moving or adding a star.
- When the sprite pack arrives, replace the gold square with a star sprite. The lesson concept stays the same.
- Commit with a message such as `week 04: collect stars and score points`.
