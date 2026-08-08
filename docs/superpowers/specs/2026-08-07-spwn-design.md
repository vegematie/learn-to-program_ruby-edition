# spwn — child-friendly git wrapper

**Status:** design approved by user
**Context:** part of `learn-to-program-game_ruby`, a DragonRuby course for a 12-year-old beginner
**Goal:** a thin text-based interface over git that uses friendlier, game-flavoured words while still accepting real git commands

## What spwn is

`spwn` should not add its own git logic beyond routing, friendly wording, and the small `spwn save` convenience action. It is a wrapper, not a reimplementation.

## Implementation shape

`spwn` should be easy to expand. The command routing should be driven by a small mapping table inside the `spwn` script itself, not by a growing pile of separate `if/elif` branches.

Each row should say enough to route the command, for example:
- one or more friendly names
- one or more accepted real git words
- the git command or commands to run
- whether the row is a pass-through or a small convenience action

Adding a new alias should be a matter of adding a row, not editing control flow. The script itself stays small; growth happens through the table.

The README should be the primary teaching surface. `spwn` should be explainable from the same mappings that drive it, so the course text and the tool stay in sync.

## Design philosophy

- Friendly words first; real git words also accepted
- No invented git verbs
- Minimal behaviour of its own; git is the source of truth
- When a friendly word and a real git word both exist for the same action, the command the user typed wins
- Child-friendly help and error wording where it matters
- Safe defaults, especially for actions that can discard work

## Command surface

### Friendly commands

Stage and snapshot:
- `spwn add <files>` — stage specific files
- `spwn add .` — stage current directory
- `spwn add -A` — stage all changes
- `spwn save "message"` — convenient add + commit for "I am done with these changes"
- `spwn commit -m "message"` — real git word also accepted
- `spwn status` — repo state
- `spwn compare` — `git diff`
- `spwn history` — `git log`

Multiverse:
- `spwn multiverse` — `git branch`
- `spwn hop <multiverse>` — `git switch <multiverse>`
- `spwn new <multiverse>` — `git switch -c <multiverse>`
- `spwn return <file>` — `git restore <file>`
- `spwn adopt <commit-ish>` — deferred; detached HEAD inspection is not part of the initial child-facing surface

Sharing:
- `spwn upload` — `git push`
- `spwn download` — `git pull`

Meta:
- `spwn help` — friendly help that also names the real git words
- `spwn init` — `git init`
- `spwn version` — `git --version` or similar useful version info

### Real git command acceptance

Real git command words should be accepted alongside friendly words wherever exposure is useful. This includes, for example, `spwn commit`, `spwn branch`, `spwn push`, `spwn pull`, `spwn status`, `spwn init`, and `spwn stash` if stash is ever wanted as an adult escape hatch.

The point is not to reproduce every git command immediately. The point is that `spwn` should never block a real git word that the user already knows or needs.

## Stash

Stash is not part of the child-facing vocabulary for now. It can exist later as an adult escape hatch if needed.

## Error handling and safety

- `spwn` only makes sense inside a git repo. If there is no `.git`, say so in plain words and suggest the right next step.
- Unknown friendly commands should give a short help hint rather than a raw shell error.
- `spwn save` is a convenience, not a silent assumption that everything should be added. `spwn add` stays explicit.
- `spwn upload` should fail in a helpful way when there is nothing to share or the remote needs attention.
- `spwn hop` should warn or refuse before switching away from uncommitted work, using plain words where possible.
- `spwn return` should be conservative and clear about what is about to be lost.

## Open questions

- Should `spwn` add extra confirmations around risky actions, or stay thin and rely on git's normal behaviour?
- Which real git command words should be accepted immediately, and which should be added gradually?

## Next step

Write an implementation plan from this spec using the writing-plans skill.
