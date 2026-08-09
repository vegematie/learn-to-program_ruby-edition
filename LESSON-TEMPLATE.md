# Lesson authoring template

Use this shape for every future lesson. Do not publish a lesson that requires the student to build the project structure from scratch.

## `README.md`

```markdown
# NN - Short game title

## Mission

Describe what the player will see or do in one sentence.

## New idea

Explain one programming idea in Scratch-friendly words.

## Start with the working game

1. Say which previous lesson this continues.
2. Start DragonRuby by double-clicking the ordinary executable.
3. Open the existing `mygame/app/main.rb` in Sublime Text.

## Exercise NN.1 - Tiny change

Change only the lines marked `TRY THIS`. Save after each change and play.

## Checkpoint

Describe what changed on screen.
```

## `starter/app/main.rb`

- Must run before the student changes anything, even if the lesson's feature is intentionally incomplete.
- Must contain the complete game loop, drawing, assets, and state setup.
- Leave only the intended lesson change unfinished; do not make the student reconstruct unrelated code.
- Mark the intended edit with a `TRY THIS` comment.
- Leave no unexplained blank method, missing asset, or broken placeholder.
- Keep the intended student edit to roughly 1-8 lines.

## `target/app/main.rb`

- Contains the full finished game state after the lesson.
- Is used for comparison or rescue, not grading.

## Teaching test

Before adding a cumulative lesson, a parent should be able to start from the previous lesson checkpoint, launch DragonRuby, make the marked change, and see the result in one short session.
