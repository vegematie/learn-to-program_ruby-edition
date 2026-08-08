# DragonRuby Game Toolkit — Codebase and Workflow Notes

**Base distribution:** `dragonruby-gtk-macos` (version `7.15`, dated Wed Aug 5 18:22:51 CDT 2026, git `4ed9a35`)  
**Source tree root:** `/Users/marcus.kim/repositories/individual/dragonruby-gtk-macos/dragonruby-macos/`  
**License tier:** Indie (this copy) — console tier above, Standard below  
**Live docs:** <https://docs.dragonruby.org>  
**Live samples:** <https://samples.dragonruby.org>  
**Discord:** <http://discord.dragonruby.org>  

All file paths below are relative to the `dragonruby-macos/` distribution root unless noted otherwise.

---

## 1. What DragonRuby GTK Is

- **A Ruby game toolkit, not a conventional engine.** DragonRuby is "a Ruby runtime" first; the "Toolkit" is the game-building layer on top. You write plain Ruby (ISO/IEC 30170:2012 / Ruby 2.x syntax). There is no editor, no node graph, no boilerplate `Game` base class you must subclass to start. The runtime is zero-dependency — no gems. (source: `docs/faq.md`)
- **The distribution is a self-contained zip.** The file you download is itself a game project template plus the engine binary. `README.txt` says: double-click `./dragonruby` to run; source is `./mygame/app/main.rb`; docs are online and also under `./docs/`. (source: `dragonruby-macos/README.txt`)
- **Multi-level cross-platform stack.** The FAQ describes six levels: Level 1 mRuby, Level 2 mRuby optimizations, Level 3 portable C libs, Level 4 SDL abstractions, Level 5 code gen/metadata, Level 6 LLVM AOT/JIT compiler. Targets include PC/Mac/Linux/RPi/WASM/iOS/Android/Nintendo Switch/PS4/Xbox/Stadia. (source: `docs/faq.md`)
- **Not fully open source, but parts are.** The philosophy doc says "sustainable open source (not fully OSS, parts are)". The standard license is free under certain conditions (income < $2k/mo, under 18, student, teacher, public service). The `dragonruby` binary can be included in public repos on a good-faith, revocable basis for non-license holders. (source: `docs/faq.md`, `docs/starting-a-new-project.md`, `.dragonruby/default_readme.txt` = "This game powered by DragonRuby Game Toolkit: https://dragonruby.org/")
- **Company:** DragonRuby LLP, 4 devs. Also ships RubyMotion. (source: `docs/faq.md`)

### License tiers (from the docs I read)

| Tier | What changes |
|------|-------------|
| Standard (free, conditional) | Desktop/Web/Linux/Pi only; no `dlopen`, no `compile_ruby`, no HD/HighDPI/All Screen, no mobile deployment, no Steam publishing via `dragonruby-publish` |
| Indie | Adds `dlopen`, Steam publishing via `dragonruby-publish`, some Pro features unlocked |
| Pro | `hd=true`, `highdpi=true`, `hd_letterbox`, `hd_max_scale`, `compile_ruby`, mobile (iOS/Android), texture atlases, shaders (`dragonruby-shadersim`, GLSL ES2), `packageid`, `orientation_ios`/`orientation_android`, console save enclaves via `DR.read_save_data`/`DR.write_save_data` |

Indicators are scattered across `docs/api/cvars.md`, `docs/api/grid.md`, `docs/api/runtime.md`, `docs/guides/deploying-to-itch.md`, `docs/guides/deploying-to-mobile.md`, `docs/guides/deploying-to-steam.md`. Where a feature says "This is a Pro feature" inline, I've taken that at face value.

---

## 2. How It Differs From Typical Game Frameworks

- **No delta time. Fixed 60 Hz tick.** The simulation runs at a fixed 60 Hz on its own thread, decoupled from the display refresh. There is no `dt` handed to you — the FAQ and the getting-started guide both say this explicitly. Convert "seconds" to ticks with `Numeric#seconds` (e.g. `5.seconds` → `300`). (source: `docs/faq.md`, `docs/guides/getting-started.md`, `docs/api/numeric.md`)
- **Hash-based rendering, not component trees.** You append plain hashes (or arrays, or `attr_sprite` classes) to `args.outputs.sprites`, `.solids`, `.labels`, `.lines`, `.borders`, `.primitives`, `.debug`. Order of rendering is: solids, sprites, primitives, labels, lines, borders, debug — with `.primitives` able to bypass ordering. (source: `docs/api/outputs.md`)
- **No boilerplate class required to start.** `tick args` is enough. Use `args.state ||= ...` / `args.state.x ||= ...` for persistent data. State is wiped on `DR.reset`. (source: `docs/api/state.md`)
- **Hot reload on save.** Save `app/main.rb` (or any loaded Ruby) and the game picks it up. There is also a REPL: put code inside `repl do ... end` (or `xrepl do ... end` to disable without deleting), save, and it runs once. Remove the `x` to enable, add it back to ignore. (source: `mygame/app/repl.rb`, `docs/faq.md`)
- **Sandboxed filesystem.** File access functions assume the `dragonruby` binary lives alongside the game. You cannot freely walk the host FS; assets must live inside the project. Save data goes to a platform-specific enclave (`DR.read_save_data`/`DR.write_save_data`). (source: `docs/guides/starting-a-new-project.md`, `docs/api/runtime.md`)
- **Sprite path naming rules.** Paths must have **no whitespace, no capital letters**, only lowercase plus `_`, `-`, `@`, `.`. This matters because of HD texture atlas substitution (`player@125.png`, etc.). (source: `docs/api/outputs.md`)
- **`Main` module vs bare functions.** Defining a `module Main` gives you top-level shorthand methods (`args`, `inputs`, `outputs`, `audio`, `state`, `events`) so you don't pass `args` everywhere. Without `Main`, you write `def tick args` and pass `args` explicitly. Tick precedence: `Main.tick` > `self.tick` > `Object.tick`. (source: `docs/api/runtime.md`)
- **Two macros that reduce arg-passing.** `attr_dr` on a class mixes in the `DR` env methods so instances don't need `args` passed in; `attr_sprite` auto-adds all sprite properties to a class so its instances can be pushed directly to `args.outputs.sprites`. (source: `docs/api/runtime.md`, `docs/api/outputs.md`, `docs/api/state.md`)
- **Console + replay + unit tests.** Debugging is via the DragonRuby Console, `--record`/`--replay`, and `--test` for unit tests. (source: `docs/faq.md`)

---

## 3. The Files and Folders in This Distribution

### Top-level (`dragonruby-macos/`)

```
dragonruby/                  # the executable (double-click to run on macOS)
mygame/                      # your game project — the only thing you edit for a new game
docs/                        # local copy of the docs site (mirrors docs.dragonruby.org)
samples/                     # 100+ sample apps, organized by topic and genre
.dragonruby/                 # hidden runtime dir (default_readme.txt: "This game powered by DragonRuby...")
.version.txt                 # "date: Wed Aug 5 18:22:51 CDT 2026\ngit: 4ed9a35fe4275710f9ea0a204e3d77c9dc197d1da"
CHANGELOG-CURR.txt           # current changelog (7.15 is the latest entry)
```

Also in the repo root (outside `dragonruby-macos/`): `.itch.toml`, `.agent-learning/`.

(source: tree exploration, `README.txt`, `VERSION.txt`, `CHANGELOG-CURR.txt`, `.dragonruby/default_readme.txt`)

### `mygame/` — the actual game project

```
mygame/
  app/
    main.rb                  # your game: module Main + def tick args (87 lines in this template)
    repl.rb                  # Ruby crash course + repl/xrepl workflow (307 lines)
  metadata/
    game_metadata.txt        # orientation, aspect_mode, aspect_size, scale_quality, hd, highdpi,
                             #   sprites_directory, hd_letterbox, hd_max_scale, origin, devid, devtitle,
                             #   gameid, gametitle, version, icon ...
    game_metadata.example-lowres.txt  # low-res examples (64x64, 84x48, 128x128)
    cvars.txt                # in-game webserver (port 9001, remote_clients), log levels,
                             #   fullscreen, borderless, background_sleep
    icon.png
    icon_ios.png
    ios_metadata.txt         # teamid, appid, appname, devcert, prodcert (Pro)
  sprites/
    circle/, hexagon/, isometric/, misc/, square/, tile/, triangle/   # sample sprite sheets
  sounds/
  fonts/
  data/
```

(source: tree exploration, `mygame/app/main.rb`, `mygame/app/repl.rb`, `mygame/metadata/game_metadata.txt`, `mygame/metadata/cvars.txt`, `mygame/metadata/game_metadata.example-lowres.txt`)

### `docs/`

```
docs/
  index.md                   # landing page (community, getting-started link, book link, videos, samples link)
  api/
    inputs.md                # args.inputs (1223 lines)
    outputs.md               # args.outputs (1068 lines)
    audio.md                 # args.audio (310 lines)
    runtime.md               # DR runtime, top-level functions, window/OS/platform, file IO (1777 lines)
    state.md                 # args.state (109 lines)
    events.md                # args.events: resize_occurred, orientation_changed, raw (23 lines)
    cvars.md                 # args.cvars: metadata hash from metadata/*.txt (53 lines)
    geometry.md              # Geometry module — trig, collision, vectors (1974 lines)
    grid.md                  # Grid module — logical vs pixel, orientation, allscreen, texture atlases (434 lines)
    layout.md                # Layout module — virtual 12x24 / 24x12 grid for UI placement (149 lines)
    numeric.md               # Numeric extensions — frame_index, lerp, remap, zmod?, compose_blendmode, etc. (561 lines)
    array.md                 # Array extensions — map_2d, include_any?, any_intersect_rect?, class-level overrides (275 lines)
    easing.md                # Easing module — spline, smooth_start/stop/step, ease, custom lambdas (590 lines)
    pixel_arrays.md          # args.pixel_arrays — ABGR pixel buffers (39 lines)
    zlib.md                  # Zlib.compress / Zlib.uncompress (29 lines)
  guides/
    getting-started.md       # 168-line tutorial by Ryan C Gordon
    starting-a-new-project.md # 60-line: unzip clean, commit everything, what to gitignore
    deploying-to-itch.md     # 173-line: itchio landing page + ./dragonruby-publish --package mygame
    deploying-to-mobile.md   # 66-line: iOS wizard $wizards.ios.start, Android APK signing
    deploying-to-steam.md    # 226-line: SteamPipe depots, launch options, steam_metadata.txt
    troubleshoot-performance.md  # 143-line: benchmark, avoid recursion, hash>array primitives, bulk outputs, render targets
    updating-dragonruby.md   # 174-line: Option 1 (copy new zip except mygame), Option 2 (butler/rsync scripts)
  misc/
    philosophy.md            # 50-line: challenge status quo, continuity of design, release early/often
    faq.md                   # 201-line: company, runtime, platform targets, license, REPL, debugging
  samples/ ... (also mirrored in the top-level samples/ dir?)
```

(source: tree exploration, every doc I read)

### `samples/` — 100+ sample apps

Organized by **topic number** (increasing difficulty) and **genre**:

- `01_rendering_basics/` — labels, lines, solids/borders, sprites, sounds, scale_quality. Each is a mini `app/main.rb`. I read `01_labels/app/main.rb` — uses `module Main` + `def tick args`, demonstrates `size_enum`/`size_px`, `alignment_enum`/`vertical_alignment_enum`, anchor variants, RGBA, custom fonts, `.primitives` passthrough.
- `02_input_basics/` — `01_moving_a_sprite/app/main.rb` is a good "first real pattern" read: bare `def boot args` + `def tick args`, `args.state.player ||= {...}`, `args.inputs.up/down/left/right`, pushes `args.state.player` directly to `args.outputs.sprites`. Also: `01_keyboard`, `02_mouse`, `03_mouse_point_to_rect`, `04_mouse_rect_to_rect`, `04_mouse_drag_and_drop`, `05_controller`, `06_touch`, `06_touch_onscreen_joystick`, `07_managing_scenes`, `07_managing_scenes_advanced`.
- Topic folders continue through `03_rendering_sprites`, `04_physics_and_collisions`, `05_mouse`, `06_save_load`, `07_advanced_audio`, `07_advanced_rendering`, `07_advanced_rendering_hd`, `08_procgen`, `08_tweening_lerping_easing_functions`, `09_performance`, `09_ui_controls`, `10_advanced_debugging`, `11_http`, `12_c_extensions`, `13_path_finding_algorithms`.
- Genre folders `99_genre_*`: 3d, arcade, board_game, boss_battle, card_game, crafting, dev_tools, dungeon_crawl, fighting, jrpg, lowrez (hello_world, labels, nokia_3310, nokia_3310_snake, resolution_64x64, resolution_64x64_with_touch_controls, platformer_128x128), mario, platformer, rpg_narrative, rpg_roguelike, rpg_tactical, rpg_topdown, rts, simulation, twenty_second_games.

(source: `ls` of `samples/01_rendering_basics/`, `samples/02_input_basics/`, top-level `samples/` listing, `docs/index.md`, `docs/api/grid.md` cross-refs to `samples/99_genre_lowrez/resolution_64x64` and `samples/99_genre_lowrez/nokia_3310_snake`, `docs/api/numeric.md` cross-refs, `docs/api/geometry.md` cross-refs to `samples/04_physics_and_collisions/11_bouncing_ball_with_gravity`, `docs/api/easing.md` cross-refs to `samples/07_advanced_rendering/20_rings`, `21_line_of_sight`, `samples/07_advanced_rendering/00_rotating_label`, `samples/07_advanced_rendering/02_render_targets_label_particles`)

---

## 4. Developer Workflow

### 4a. Creating / starting a new project

- **Unzip the DragonRuby zip fresh and use it as your starter.** The strong recommendation across `starting-a-new-project.md` and `deploying-to-itch.md` (and repeated in `deploying-to-mobile.md` and `deploying-to-steam.md`) is: **do not keep DragonRuby in a shared location**. Unzip a clean copy per game, commit everything. The directory structure in the zip should not be altered.
- **Public repo:** commit only `./mygame` contents.
- **Private / commercial:** gitignore only `/tmp/` and `/logs/`; commit everything else including samples/docs. Do **not** commit `dragonruby-publish` or `dragonruby-bind`. The `dragonruby` binary can be included for non-license holders (good-faith, revocable).
- (source: `docs/guides/starting-a-new-project.md`, `docs/guides/deploying-to-itch.md`)

### 4b. Editing

- Edit `mygame/app/main.rb`. A minimal game is:

```ruby
module Main
  def tick args
    args.outputs.labels << { x: 640, y: 360, text: "Hello", anchor_x: 0.5, anchor_y: 0.5 }
  end
end
```

- For state, initialize in `boot` and use `args.state.x ||= ...` in `tick`. Do **not** use bare ivars (`@player`) at the top level — that pollutes global object space and is not cleared by `DR.reset`. (source: `docs/api/state.md`)
- For experimentation, use `mygame/app/repl.rb`. Wrap code in `repl do ... end`; save to run once. Prefix with `x` (`xrepl`) to disable without deleting. (source: `mygame/app/repl.rb`, `docs/faq.md`)

### 4c. Running

- **GUI:** double-click the `./dragonruby` executable in the `dragonruby-macos/` root. (`README.txt`)
- **Terminal:** run the `dragonruby` binary from the `dragonruby-macos/` directory (sandboxed file access assumes the binary lives alongside the game). I did not test the exact invocation command; the docs say double-click is the supported path, and `starting-a-new-project.md` + `deploying-to-*.md` all say "the `dragonruby` binary lives alongside the game you are building."
- **Hot reload:** save a source file; the game picks it up.
- **In-game webserver (dev):** enabled via `metadata/cvars.txt` (`webserver.enabled=true`, default port `9001`, `webserver.remote_clients=true` for remote-hotloading). (source: `docs/api/cvars.md`, `mygame/metadata/cvars.txt`)
- **REPL:** see above.

### 4d. Debugging

- **DragonRuby Console** — open in-game; inspect `$args`, `$state`. (source: `docs/api/state.md`, `docs/faq.md`)
- **In-game debug rendering** — `args.outputs.debug` accepts strings (auto-stacked labels, white bg / black text) and `watch()` for styled watch vars. Not rendered in production. (source: `docs/api/outputs.md`)
- **Recording / replay** — `DR` supports `--record` and `--replay`. (source: `docs/faq.md`)
- **Unit tests** — `--test`. (source: `docs/faq.md`)
- **Logs** — there is a `logs/` directory and `puts.txt` (mentioned in the summary; I did not open the file). `cvars.txt` covers log levels: `spam`, `debug`, `info`, `warn`, `error`, `unfiltered`, `nothing`. (source: `mygame/metadata/cvars.txt`)
- **Performance audit** — `DR.warn_array_primitives!` at the top of `tick` flags Array-form primitives; use `DR.benchmark` for method variants. (source: `docs/guides/troubleshoot-performance.md`, `docs/api/runtime.md`)

### 4e. Configuring metadata

`mygame/metadata/game_metadata.txt` controls:

- `orientation` (`landscape` default, or `portrait`, or `landscape,portrait` / `portrait,landscape` for both)
- `aspect_mode` (`0` = 16:9 default, `1` = 1:1)
- `aspect_size` (default `720`; at `aspect_mode=0` this is the height seed → `logical_w = (aspect_size/9)*16`, `logical_h = aspect_size`; at `aspect_mode=1` both dimensions equal `aspect_size`)
- `scale_quality` (`0`=nearest neighbor, `1`=anisotropic/best, `2`=anisotropic/best, `3`=pixelart; default `0`)
- `hd` (Pro), `highdpi` (Pro, requires `hd`), `hd_letterbox` (Pro, default `true`), `hd_max_scale` (Pro, `0`=size to fit, or `100/125/150/175/200/250/300/400`)
- `origin` (`bottom_left` default or `center`; can also change at runtime via `Grid.origin_bottom_left!`/`Grid.origin_center!`)
- `sprites_directory` (Pro: path to search for HD texture atlases)
- `ignore_directories` (comma-delimited list excluded when packaging)
- `compile_ruby` (Pro: compile game code to bytecode during packaging)
- `packageid` (Pro: Android package id, reverse domain)
- `orientation_ios` / `orientation_android` (Pro overrides)
- Release fields (commented out by default): `devid`, `devtitle`, `gameid`, `gametitle`, `version`, `icon`

`mygame/metadata/cvars.txt` controls runtime config: `webserver.enabled/port/remote_clients`, `renderer.background_sleep` (default `50`, `0` to disable), log levels, `fullscreen`, `borderless`.

`args.cvars` is a hash of metadata pulled from `metadata/*.txt`. Each CVar has `value`, `name`, `description`, `type`, `locked`. Example: `args.cvars["game_metadata.version"].value.to_s`. (source: `docs/api/cvars.md`, `docs/api/grid.md`, `mygame/metadata/game_metadata.txt`, `mygame/metadata/cvars.txt`, `mygame/metadata/game_metadata.example-lowres.txt`)

### 4f. Building a distribution

- **Itch.io — `./dragonruby-publish --package mygame`** from the `dragonruby-macos/` directory. Creates `./build` containing binaries. Upload manually. Subsequent updates: `./dragonruby-publish mygame` (packages and publishes to itch.io). (source: `docs/guides/deploying-to-itch.md`)
  - Itch HTML settings: check "This file will be played in the browser", ensure "Embed options -> SharedArrayBuffer support" is checked, viewport 960x540 landscape / 540x960 portrait, "Fullscreen button" checked. (source: `docs/guides/deploying-to-itch.md`)
- **Mobile (Pro only):**
  - iOS: from the Console, `$wizards.ios.start env: :dev` (USB device), `:hotload` (USB + hotload), `:sim` (simulator), `:prod` (App Store). Requires Mac, macOS Catalina+, iOS device, paid Apple Developer Account. (source: `docs/guides/deploying-to-mobile.md`)
  - Android: `dragonruby-publish` creates an APK. Sign with `apksigner`, install with `adb`. Need `packageid=TLD.YOURCOMPANY.YOURGAME` in `game_metadata.txt` before publishing. (source: `docs/guides/deploying-to-mobile.md`)
- **Steam (Indie/Pro):** `dragonruby-publish` + `metadata/steam_metadata.txt` (filtered out of packages). Standard license must use Steamworks toolchain directly. The guide covers SteamPipe depots, launch options per OS, `steamcmd` login. (source: `docs/guides/deploying-to-steam.md`)
- **macOS app bundle:** I did not find a separate `dragonruby-bind` invocation documented in the files I read. The deploy guides reference `dragonruby-publish` as the packaging tool and mention a `./build`/`builds` output. The exact step to produce a `.app` bundle on macOS is not spelled out in the docs I read beyond "double-click the executable" for dev and `dragonruby-publish` for itch.io. I'd want to confirm by checking `dragonruby-publish --help` or the `dragonruby-bind` binary if present. **(TODO: verify the exact build command and whether a `dragonruby-bind` step is needed for a native .app bundle.)**
- **Audio pre-processing:** re-encode to OGG with ffmpeg before building, especially for web. Example in `deploying-to-itch.md`. WAV max 44.1kHz; OGG recommended. (source: `docs/api/audio.md`, `docs/guides/deploying-to-itch.md`)
- **Updating DragonRuby:** Option 1 — download new zip, unzip, copy everything **except `mygame/`** (and on Mac/Linux, copy the hidden `.dragonruby/` too). Option 2 — butler/rsync scripts for Standard vs Indie/Pro. (source: `docs/guides/updating-dragonruby.md`)

### 4g. Recommended background_sleep behavior

If the game shouldn't run at full speed when unfocused, leave `renderer.background_sleep=50` (default). Set `renderer.background_sleep=0` in `cvars.txt` to run at full speed in background. A common pattern: in `tick`, if `!args.inputs.keyboard.has_focus && args.gtk.production && Kernel.tick_count != 0`, render a "paused" overlay and optionally mute audio. (source: `docs/guides/deploying-to-itch.md`, `mygame/metadata/cvars.txt`)

---

## 5. Key Concepts Deep Dive

### 5a. Ticks and lifecycle

- **Core:** `tick args` is the only required function; called 60 times/sec. Fixed 60 Hz, no delta time, separate thread from display refresh. (source: `docs/faq.md`, `docs/guides/getting-started.md`)
- **Lifecycle functions (top-level, `DR` runtime):** `boot` (once at startup), `tick` (main), `reset` (before `DR.reset`), `did_reset` (after reset), `shutdown` (before exit, also on reboot). (source: `docs/api/runtime.md`)
- **Counters:** `Kernel.tick_count` (current tick), `Kernel.global_tick_count`. `Numeric#elapsed_time` returns frames since a tick count (optionally with an override). `Numeric#seconds` converts seconds to ticks. `Numeric#zmod?(n)` is `self % n == 0`. (source: `docs/api/numeric.md`, `docs/api/runtime.md`)
- **Scheduling:** `DR.on_tick_count` schedules a block. (source: `docs/api/runtime.md`)
- **Reset/reboot:** `DR.reset` clears `args.state`. `DR.reboot` also resets sprites. (source: `docs/api/state.md`, `docs/api/runtime.md`, `CHANGELOG-CURR.txt`: "Sprites are reset when DR.reboot is invoked.")
- **Main module scoping:** if you define `module Main`, `tick` is `Main.tick`; precedence `Main.tick` > `self.tick` > `Object.tick`. (source: `docs/api/runtime.md`)

### 5b. Inputs (`args.inputs`)

- **Top-level `last_active`** = `:keyboard` / `:mouse` / `:controller`.
- **Combined directional** (keyboard + controller + analog): `up`, `down`, `left`, `right`; `left_right` / `up_down` return `-1` / `0` / `+1`; directional vectors available; `left_right_wasd` / `left_right_arrow`; `directional_vector_up/down/left/right`. (source: `docs/api/inputs.md`)
- **Mouse:** `x`, `y`, `previous_x`, `previous_y`, `relative_x`, `relative_y`, `moved`, `rect()`, `point()`, `has_focus`, `inside_rect?`, `inside_circle?`, `button_left/middle/right`, `button_bits`, `wheel`, `click`/`down`/`previous_click`/`up` per button, `key_down`/`held`/`up` per button, `buttons.left.buffered_click`/`buffered_held`, touch `finger_left`/`finger_right`. (source: `docs/api/inputs.md`)
- **Controller:** `controller_one`..`controller_four`, `connected`/`name`/`active`, `up/down/left/right`, dpad variants, `left_analog_x_raw`/`y_raw` (`-32767..32767`), `_perc` (`-1..1`), `analog_angle` (degrees, `.to_radius`), `directional_vector_*`, `analog_dead_zone` (default `3600`), `accept`/`cancel` (a/b swap for Switch Pro), truthy_keys (expensive), `key_down`/`key_held`/`key_up`, dynamic `key_STATE?`. (source: `docs/api/inputs.md`)
- **Keyboard:** `active`, `has_focus`, `up/down/left/right`, `left_right_wasd`/`arrow`, `directional_vector_*`, per-key properties, `key_down`/`key_held`/`key_up`/`key_repeat`, dynamic `key_down?(key)`, `truthy_keys`, `keys` hash, `key_down.char`. Available keys: a-z, digits, arrows, WASD scancodes, editing keys, navigation, function keys, modifiers (shift/control/alt/meta, `ctrl_KEY` dynamic), symbols, braces, numpad, app control, raw_key. (source: `docs/api/inputs.md`)
- **Caveat:** `truthy_keys` is "expensive". (source: `docs/api/inputs.md`)

### 5c. Rendering (`args.outputs`)

- **Render order:** solids, sprites, primitives, labels, lines, borders, debug. `.primitives` accepts all primitives and bypasses ordering. (source: `docs/api/outputs.md`)
- **Background:** `args.outputs.background_color = [r,g,b]` or `{r,g,b}`. (source: `docs/api/outputs.md`)
- **Debug:** `args.outputs.debug` — strings render as auto-stacked labels with white bg / black text; `watch()` for styled watch vars; not rendered in production; renders above everything. (source: `docs/api/outputs.md`)
- **Solids:** rect primitives. Avoid large numbers (use sprites instead for many). Array form `[x,y,w,h]` or `[x,y,w,h,r,g,b,a]`; hash form `{x,y,w,h,r,g,b,a,anchor_x,anchor_y,blendmode_enum}`; class form with `primitive_marker :solid`. (source: `docs/api/outputs.md`, `docs/guides/troubleshoot-performance.md` — prefer `args.outputs.sprites << { ..., path: :solid }` over `args.outputs.solids`.)
- **Borders:** same as solids but unfilled. (source: `docs/api/outputs.md`)
- **Sprites:** required keys `x,y,w,h,path`. Anchors (`anchor_x`/`anchor_y`, `angle_anchor_x`/`angle_anchor_y`), `flip_horizontally`/`flip_vertically`, `angle` (degrees, rotates around center), cropping — `tile_x/y/w/h` (top-left origin) vs `source_x/y/w/h` (bottom-left origin), blending (`a/r/g/b`, `blendmode_enum` deprecated, `blendmode`), `scale_quality_enum`, triangles via `x2/y2/x3/y3`. Path rules: no whitespace, no capitals, only lowercase + `_`/`-`/`@`/`.`. Array form `[x,y,w,h,path]`; hash form; class form with `attr_sprite` macro. `attr_sprite` auto-adds all sprite properties so instances can be pushed directly. (source: `docs/api/outputs.md`)
- **Labels:** default anchor top-left (set `anchor_x:0, anchor_y:0` for bottom-left). Array form `[x,y,text,size_enum,alignment_enum,r,g,b,a,font]`; hash form with `size_enum` (opaque units; `0` = smallest comfortable; each +1 = +2px; at 720p `size_enum 0` = 22px), `size_px` overrides, `alignment_enum` (0=left, 1=center, 2=right), `vertical_alignment_enum`, `anchor_x/y`, `font`, `blendmode_enum`, `scale_quality_enum`; class form with `primitive_marker :label`. (source: `docs/api/outputs.md`, `samples/01_rendering_basics/01_labels/app/main.rb`)
- **Lines:** `[x,y,x2,y2]` or hash or class with `primitive_marker :line`. (source: `docs/api/outputs.md`)
- **Render targets:** `args.outputs[:symbol]` — virtual canvas, cached until written to, use for combined sprites, camera, scene management, lighting; accessing invalidates cache. (source: `docs/api/outputs.md`)
- **Screenshots:** `{x,y,w,h,path,r,g,b,a}` chroma key. (source: `docs/api/outputs.md`)
- **Shaders:** Indie/Pro only; `dragonruby-shadersim`, GLSL ES2, `outputs.shader_path` and `outputs.shader_uniforms`. (source: `docs/api/outputs.md`)
- **Performance notes:** prefer Hash over Array primitives; use `.each` over `.map` when you don't need the return; batch outputs (`args.outputs.sprites << collection.map{...}`); use render targets for cameras with many primitives; don't lerp `size_enum`/`size_px`/font (glyph caching) — use render targets for label scaling. (source: `docs/guides/troubleshoot-performance.md`)
- **Solids vs sprites:** for many solids, use `args.outputs.sprites << { ..., path: :solid, r:, g:, b: }` — `:solid` is a pre-cached texture. (source: `docs/guides/troubleshoot-performance.md`)

### 5d. Coordinate system and resolution

- **Bottom-left origin** by default: `0,0` at bottom-left. Game is always 1280x720 logical (at default settings), scaled/letterboxed to fit the window. (source: `docs/guides/getting-started.md`)
- **Logical vs pixel categories:** `Grid` exposes logical values (720p — 1280x720 landscape, 720x1280 portrait) and `_px` pixel values. You almost always use logical. `_px` is for texture atlas sanity checks, C extensions, shaders (Pro). For Standard license, `_px` returns logical values. (source: `docs/api/grid.md`)
- **Orientation:** `Grid.orientation` = `:landscape` (default) or `:portrait`; `Grid.portrait?`/`landscape?`; `Grid.orientation_changed?` true only on the frame of change (needs comma-delimited orientation in metadata). (source: `docs/api/grid.md`, `docs/api/events.md`)
- **Origin:** `Grid.origin_name` = `:bottom_left` (default) or `:center`. Runtime: `Grid.origin_bottom_left!`/`Grid.origin_center!`. `Grid.bottom`, `Grid.top` (= `Grid.h`), `Grid.left`, `Grid.right`, `Grid.w`, `Grid.h`, `Grid.rect`, `Grid.aspect_ratio_w/h`, `Grid.aspect_size`. (source: `docs/api/grid.md`)
- **Aspect mode/size table** (from `grid.md`):
  - `aspect_mode=0` (16:9), `aspect_size` = height seed:
    - 48→84x48, 72→128x72, 90→160x90, 144→256x144, 180→320x180, 360→640x360, 576→1024x576, 720→1280x720 (default)
  - `aspect_mode=1` (1:1), both = `aspect_size`:
    - 32→32x32, 64→64x64, 128→128x128, 256→256x256, 512→512x512, 720→720x720
- **All Screen mode (Pro, `hd_letterbox=false`):** edge-to-edge rendering; 1280x720 safe area centered. Best-fit resolutions: 720p, HD+ 1600x900, 1080p 1920x1080, 1440p 2560x1440, 1880p 3200x1800, 4k 3840x2160, 5k 6400x2880. Allscreen properties: `allscreen_left/x`, `allscreen_right/y`, `allscreen_top`, `allscreen_bottom`, `allscreen_w/h`, `allscreen_rect`, `allscreen_offset_x/y/offset`. Always logical pixels; can be negative for `origin:bottom_left`. Don't use for interactive UI (notch/ultrawide edge). (source: `docs/api/grid.md`)
- **Texture atlases (Pro):** `native_scale`, `render_scale` (= `native_scale` if `hd_max_scale=0`, else best-fit pixel-perfect), `texture_scale` (float: 720p=1.0, HD+=1.25, 1080p=1.5, Full HD+=1.75, 1440p=2.0, 1880p=2.5, 4k=3.0, 5k=4.0), `texture_scale_enum` (100/125/150/175/200/250/300/400). Sprite path substitution: `sprites/player.png` → at 1080p → `sprites/player@150.png` (150x150), fallback to lower res if not found. (source: `docs/api/grid.md`)
- **Layout grid:** virtual 12 rows x 24 cols (landscape) / 24 x 12 (portrait). `Layout.rect(row:, col:, w:, h:)` returns `{x,y,w,h,center:{x,y}}`; optional `allscreen:true`. `Layout.allscreen_rect` is a passthrough with `allscreen:true` default. `Layout.debug_primitives` for placement. (source: `docs/api/layout.md`)

### 5e. Game state (`args.state`)

- **Property bag, retained across ticks.** Initialize to `{}` in `boot` (recommended; future versions may enforce it). Use `args.state.x ||= ...` for lazy init. Cleared on `DR.reset`. (source: `docs/api/state.md`)
- **Open data structure** — you can assign arbitrary nested hashes. Example from `mygame/app/main.rb`: `args.state.logo_rect ||= { x: 0, y: 0, w: 128, h: 128 }`. (source: `mygame/app/main.rb`, `docs/api/state.md`)
- **For rapid prototyping, prefer `args.state` over bare ivars.** Bare ivars (`@player`) at the top level pollute global object space and are not cleared by `DR.reset`. (source: `docs/api/state.md`)
- **Classes + `attr_dr` + ivars** is the long-term path. Provide a top-level `reset` function to nil out game instances. Example pattern from `state.md`:

```ruby
class Game
  attr_dr
  def tick
    @player ||= { x: 0, y: 0 }
    @player.x += 1
    ...
  end
end

def boot args
  args.state = {}
end

def tick args
  $game ||= Game.new
  $game.args = args
  $game.tick
end

def reset args
  $game = nil
end
```

- **Console access:** `$state` global gives access to `args.state` from the console; recommended for debugging only. (source: `docs/api/state.md`)

### 5f. Events (`args.events`)

- **`resize_occurred`** — `true` if window resized or orientation changed. (source: `docs/api/events.md`)
- **`orientation_changed`** — `true` on the frame orientation changes; important to handle if you use render targets and support both landscape/portrait (metadata `orientation=landscape,portrait` or `portrait,landscape`). (source: `docs/api/events.md`)
- **`raw`** — array of hashes; processed already, unlikely you need it directly (debugging). (source: `docs/api/events.md`)

### 5g. Audio (`args.audio`)

- **Hash of playing audio sources.** Non-looping sounds are removed automatically after playback; `:length` is added on the next tick. (source: `docs/api/audio.md`)
- **Global volume:** `args.audio.volume`. (source: `docs/api/audio.md`)
- **One-time play:** `args.audio[:coin] = { input: "sounds/coin.wav" }` or `args.outputs.sounds << "sounds/coin.wav"`. (source: `docs/api/audio.md`)
- **Looping:** `{ input: "sounds/bg-music.ogg", looping: true }`. Stop by setting to `nil` or deleting the key. (source: `docs/api/audio.md`)
- **Properties:** `input`, `gain` (0.0–1.0 float), `pitch` (1.0 = float), `paused`, `looping`, `x/y/z` (-1.0..1.0), plus metadata keys. After loaded: `playtime`, `playlength`. Must use floats for gain/pitch. (source: `docs/api/audio.md`)
- **Crossfade:** example pattern in `audio.md`. (source: `docs/api/audio.md`)
- **Sound synthesis:** `input` as `[channels, sample_rate, sound_source]` where `sound_source` is a `Proc` (continuous, no looping effect) or an array of samples (-1.0..1.0). WAV max 44.1kHz. OGG recommended. ffmpeg re-encoding tips in `audio.md`. (source: `docs/api/audio.md`, `docs/guides/deploying-to-itch.md`)

### 5h. Geometry (`Geometry` module, mixed into Hash/Array/Entity)

- **Mixins available on Hash/Array/Entity:** `intersect_rect?`, `inside_rect?`, `scale_rect`, `angle_to`, `angle_from`, `point_inside_circle?`, `center_inside_rect`, `center_inside_rect_x/y`, `anchor_rect`, `rect_center_point`. Either `rect.intersect_rect?(other)` or `Geometry.intersect_rect?(rect, other)`. (source: `docs/api/geometry.md`)
- **Trig:** `angle` / `angle_to` (degrees from start→end; `.to_radians`), `angle_from` (degrees end→start), `angle_turn_direction` (1 clockwise / -1 ccw), `angle_delta` (smallest delta), `angle_within_range?`, `rotate_point(point, angle_deg, around_point?)`, `angle_vec2` / `angle_vec2_r` (hash `{x,y}` from degrees/radians), `angle_cardinal_vec2` / `_r` (snapped to 45°), `distance`, `distance_squared`, `line_angle`, `line_rise_run`, `line_vec2`, `line_normal`, `vec2_dot_product`, `vec2_magnitude`, `vec2_normalize`, `vec2_normal`, `vec2_add`, `vec2_subtract`/`vec2_sub`, `vec2_scale`, `vec2_angle`. (source: `docs/api/geometry.md`)
- **Collision:** `intersect_rect?` (tolerance default 0.1, anchors considered), `inside_rect?`, `intersect_circle?` (rect/circle both sides, anchor considered), `point_inside_circle?`, `ray_test` (returns `:left`/`:right`/`:on`), `line_intersect` (segments), `ray_intersect` (infinite lines), `find_intersect_rect` (first, faster than `find`), `find_all_intersect_rect` (all, faster than `find_all`), `circle_intersect_line?`, `point_on_line?`, `each_intersect_rect` (block per pair, optional `using:` symbol/proc), `find_collisions` (first collision per entry within a quadtree partition — returns hash mapping intersecting pairs). (source: `docs/api/geometry.md`)
- **Use `using:` with `find_intersect_rect` / `each_intersect_rect`** to extract rect info from objects (symbol method name or proc). (source: `docs/api/geometry.md`)

### 5i. Grid / Layout / Numeric / Array / Easing / Pixel Arrays / Zlib (the helper modules)

- **Grid:** see 5d. (source: `docs/api/grid.md`)
- **Layout:** see 5d (virtual grid). (source: `docs/api/layout.md`)
- **Numeric:** `frame` / `frame_index` (sprite animation indexing — count, hold_for, repeat, repeat_index, tick_count_override), `rand` (Range-aware), `elapsed_time`, `elapsed?`, `to_sf` (2-decimal string), `to_si` (underscored int), `vector_x`/`vector_y` (degrees→components; `_r` for radians), `idiv`/`fdiv`, `zmod?`, `lerp` (quick-and-dirty ease, optional `tolerance:`), `remap`, `clamp`, `clamp_wrap`, `mid`/`min`/`max`/`between?`/`mid?`, `times`, `map`, `seconds`, `to_degrees`/`to_d`/`to_degrees_from_radians`, `to_radians`/`to_r`/`to_radians_from_degrees`, `compose_blendmode` (for render target blendmodes). (source: `docs/api/numeric.md`)
- **Array:** `map_2d` (2D array→block per index), `include_any?`, `any_intersect_rect?` (objects responding to left/right/top/bottom, optional tolerance 0.1), `map` (example: render state array as sprites), `each` (same), `reject_nil` (alias `compact`), `reject_false`, `product` (combinations), plus **class-level overrides** that are faster when not mutating during iteration: `all?`, `any?`, `compact!`/`compact`, `each`, `each_with_index`, `filter_map`, `find_all`, `flat_map`, `map!`/`map`, `map_with_index`, `reject!`/`reject`, `select!`/`select`, `transpose`. Usage: `Array.map(collection) {...}` instead of `collection.map{...}`. (source: `docs/api/array.md`, `docs/guides/troubleshoot-performance.md`)
- **Easing:** `spline` (bezier, start/current/duration/4-point definitions), `smooth_start`, `smooth_stop`, `smooth_step` (invocation variants: `initial:/final:/perc:/power:/flip:` or `start_at:/end_at:/tick_count:/power:/flip:` or `start_at:/duration:/tick_count:/power:/flip:`), `mix` (blend two eases), `lerp vs Easing` (Numeric#lerp is simple but not frame-perfect; Easing+slerp is deterministic), `ease` (chained time-stamped, `!> not super fast`; definitions: `:identity`, `:flip`, `:quad/:cube/:quart/:quint`, aliases `smooth_start_quad` etc., `smooth_stop_*` = `:flip, :power, :flip`). Custom: pass a lambda, or extend `Easing` module with a method and reference by name. (source: `docs/api/easing.md`)
- **Pixel Arrays:** `args.pixel_array(:symbol)` — `w/h` + `pixels` (ABGR hex). Fill with `fill(#ABGR, offset, count)`. Index: `pixels[(height - y) * width + x]` (bottom-left coords). Render via `path: :symbol`. Convert RGB hex to ABGR: reverse pairs + prepend alpha (e.g. `#87CEEB` skyblue → `#EBCE87` → `#FFEBCE87`). (source: `docs/api/pixel_arrays.md`)
- **Zlib:** `Zlib.compress`/`Zlib.deflate`, `Zlib.uncompress`/`Zlib.inflate`. Optional `String#compress`/`#uncompress` patch. (source: `docs/api/zlib.md`)

### 5j. Runtime / `DR` / `args.gtk` (window, platform, file IO, utilities)

- **Top-level functions:** `boot`, `tick`, `reset`, `did_reset`, `shutdown`. (source: `docs/api/runtime.md`)
- **Pretty printing:** `pp`, `pretty_print`, `pretty_inspect`. (source: `docs/api/runtime.md`)
- **Class macros:** `attr` (alias `attr_accessor`), `attr_dr` (adds DR env methods to class), `attr_sprite` (adds all sprite properties — see outputs). (source: `docs/api/runtime.md`, `docs/api/outputs.md`, `docs/api/state.md`)
- **Indie/Pro:** `dlopen` (C extensions), `get_dlopen_path`. (source: `docs/api/runtime.md`)
- **Window:** `window_fullscreen?`, `can_resize_window?`, `set_window_fullscreen`, `toggle_window_fullscreen`, `set_window_size` (dev only), `set_window_position` (dev only), `set_window_scale` (dev only; valid scales `0.1/0.25/0.5/0.75/1.25/1.5/2.0/2.5/3.0/4.0`), `set_window_title` (dev only), `can_close_window?`, `move_window_to_next_display`, `maximize_window`, `can_change_orientation?`, `toggle_orientation` (dev only), `set_orientation` (dev only), `set_hd_max_scale` (Pro, dev only), `toggle_hd_letterbox`/`set_hd_letterbox` (Pro, dev only), `raise_window` (dev only). (source: `docs/api/runtime.md`)
- **Environment/utility:** `on_tick_count` (schedule block), `calcstringbox` (returns `{w,h}` tuple), `calcstringbox_h` (returns `{w,h}`), `get_string_rect` (returns `{x:0,y:0,w,h,center}`), `get_pixels` (returns `{w,h,pixels}` ABGR array), `request_quit`, `quit_requested?`, `platform?`/`platform` (`macos`/`win`/`linux`/`web`/`android`/`ios`/`touch`/`steam`/`steam_deck`/`steam_desktop`), `production?`, `platform_mappings` (hash), `openurl`, `system` (dev only), `exec` (dev only, returns string), `show_cursor`/`hide_cursor`/`cursor_shown?`, `set_mouse_grab` (0=ungrab, 1=grab, 2=hide+grab+relative), `set_system_cursor` (`"arrow"/"ibeam"/"wait"/"hand"`), `set_cursor` (sprite), `create_uuid`, `getenv`/`setenv`. (source: `docs/api/runtime.md`)
- **File IO (sandboxed; binary must live alongside game):** `list_files`, `stat_file` (returns `{path,file_size,mod_time,create_time,access_time,readonly,file_type}`), `read_save_data`/`write_save_data` (save enclave — platform-specific: Win AppData, Mac `$HOME/Library/Application Support/[gametitle]`, Linux `$HOME/.local/share/[gametitle]`, Web IndexedDB), `read_file`/`write_file`/`append_file`/`delete_file`. Consoles have dedicated save enclaves; prefer `read_save_data`/`write_save_data` over `read_file`/`write_file` for user data. (source: `docs/api/runtime.md`, `CHANGELOG-CURR.txt`)

### 5k. `args.cvars` (metadata as runtime config)

- Hash of metadata pulled from `metadata/*.txt`. Each entry: `value`, `name`, `description`, `type`, `locked`. Query keys with `$args.cvars.keys` in console. Example: `args.cvars["game_metadata.version"].value.to_s`. (source: `docs/api/cvars.md`)
- `cvars.txt` entries: `webserver.enabled` (default false), `webserver.port` (default 9001), `webserver.remote_clients` (default false), `renderer.background_sleep` (default 50, 0 to disable). (source: `docs/api/cvars.md`, `mygame/metadata/cvars.txt`)

---

## 6. Practical Starting Points for New Devs

1. **Start with `docs/guides/getting-started.md`.** It's a 168-line tutorial by Ryan C Gordon. It covers the tick model, label rendering, sprite loading, coordinate system, `args.state`, no-delta-time, hot reload, and a mouse input example. (source: `docs/guides/getting-started.md`)
2. **Use `module Main` early.** It gives you `args`/`inputs`/`outputs`/`audio`/`state`/`events` as top-level methods, so you're not threading `args` through everything. (source: `docs/api/runtime.md`, `mygame/app/main.rb`, `samples/01_rendering_basics/01_labels/app/main.rb`)
3. **Prefer hash-based primitives, then migrate to `attr_sprite` classes as complexity grows.** The getting-started guide and the state.md example both show hash-first workflows. `attr_sprite` lets you push class instances directly to `args.outputs.sprites`. (source: `docs/guides/getting-started.md`, `docs/api/outputs.md`, `docs/api/state.md`)
4. **Use `args.state ||= ...` / `args.state.x ||= ...` for init.** Initialize `args.state = {}` in `boot`. Avoid bare ivars at the top level. (source: `docs/api/state.md`, `docs/guides/getting-started.md`, `samples/02_input_basics/01_moving_a_sprite/app/main.rb`)
5. **Use the samples as reference — there are 100+ of them.** Topic folders `01`–`13` increase in difficulty; genre folders `99_genre_*` show complete mini-games. The docs cross-reference specific samples constantly (e.g. `samples/04_physics_and_collisions/11_bouncing_ball_with_gravity`, `samples/07_advanced_rendering/20_rings`, `samples/99_genre_lowrez/resolution_64x64`). Live demos at <https://samples.dragonruby.org>. (source: `docs/index.md`, every API doc cross-ref, `ls` of samples)
6. **Use `repl.rb` for experimentation.** Wrap code in `repl do ... end` (or `xrepl` to disable); save to run once. Good for poking at the API without editing main.rb. (source: `mygame/app/repl.rb`, `docs/faq.md`)
7. **Use debug rendering and watch.** `args.outputs.debug << "text"` and `args.outputs.debug << watch(var)` for in-game inspection. Open the DragonRuby Console for `$args`/`$state`. (source: `docs/api/outputs.md`, `docs/api/state.md`, `docs/faq.md`)
8. **Understand the no-delta-time model.** Fixed 60 Hz. Use `Kernel.tick_count`, `Numeric#elapsed_time`, `Numeric#seconds`, `Numeric#zmod?(60)` for "every second" checks. For frame-perfect animations, use `Easing` + `Numeric#lerp` rather than raw `lerp`. (source: `docs/faq.md`, `docs/guides/getting-started.md`, `docs/api/numeric.md`, `docs/api/easing.md`)
9. **Be aware of the filesystem sandbox and sprite path rules.** Assets must live inside the project; the binary must live alongside the game. Sprite paths: no whitespace, no capitals, only lowercase + `_`/`-`/`@`/`.`. Save data goes through `DR.read_save_data`/`DR.write_save_data` (platform enclave). (source: `docs/guides/starting-a-new-project.md`, `docs/api/outputs.md`, `docs/api/runtime.md`)
10. **Keep the distribution structure intact.** Don't rearrange the zip. For each new game, unzip a clean copy. Gitignore only `/tmp/` and `/logs/` for private/commercial; public repos need only `./mygame` contents. (source: `docs/guides/starting-a-new-project.md`, `docs/guides/deploying-to-itch.md`)
11. **Join the Discord.** It's the primary support channel and the devs are there. (source: `docs/index.md`, `docs/faq.md`)
12. **Release early/often.** The philosophy doc explicitly calls for this. (source: `docs/misc/philosophy.md`)
13. **Performance: hash over array primitives, batch outputs, use render targets for cameras, don't lerp label size/font, use `Array.map` class-level when not mutating, add `DR.warn_array_primitives!` to audit.** (source: `docs/guides/troubleshoot-performance.md`)

---

## 7. Notable Quotes / Philosophy (from `docs/misc/philosophy.md`)

- Challenge the status quo — Unity/GameMaker "rot your brain".
- Continuity of design — spectrum from tuples → hashes → entities → classes; a "pit of success" is discouraged.
- Release early/often.
- Sustainable monetization; sustainable open source (not fully OSS, parts are).
- People over entities.
- Building should be fun.
- Real-world application drives features.

(source: `docs/misc/philosophy.md`)

---

## 8. Things I Did Not Verify / TODO

- **Exact run command.** `README.txt` says "Double click the ./dragonruby executable." I did not run the binary or confirm a terminal invocation. The deploy guides all assume the binary lives in the `dragonruby-macos/` root alongside `mygame/`.
- **Exact macOS `.app` bundle build command.** `deploying-to-itch.md` covers `./dragonruby-publish --package mygame` (produces `./build`). I did not confirm whether a separate `dragonruby-bind` step is required for a native `.app`, or what `dragonruby-publish` emits on macOS specifically. **(TODO: run `./dragonruby-publish --help` or inspect the binary if present, and/or read its bundled docs, to confirm the macOS bundle output.)**
- **`logs/` and `puts.txt`** were mentioned but not opened. (source: summary notes)
- **`dragonruby-publish` and `dragonruby-bind` binaries** — presence/capabilities not inspected directly; referenced by the deploy guides as the packaging tool.
- **`app/repl.rb` full contents** — read (307 lines), but only summarized; the `repl`/`xrepl` workflow and Ruby crash-course content are in that file literally.
- **`metadata/icon.png`, `icon_ios.png`, `ios_metadata.txt`** — not opened; referenced in `cvars.md` and the tree.

---

*Sources for every factual claim are cited inline above as `(source: <path>)` or `(source: <url>)`. All paths are relative to the `dragonruby-macos/` distribution root unless they start with `docs/` in which case they're `dragonruby-macos/docs/...`, or are repository-root files.*
