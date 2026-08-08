# OpenMMO 서버 — 데이터베이스 incorporated 방식

작성일: 2026-08-06  
대상 저장소: `/Users/marcus.kim/repositories/oss/OpenMMO`  
이 문서는 서버 쪽 코드가 어떤 식으로 DB를 붙여서 쓰는지만 다룬다. 클라이언트/에이전트 클라이언트 구조는 여기서 깊이 다루지 않는다.

---

## 1. 한 줄 요약

이 서버는 **단일 SQLite 파일 하나**를 영구 저장소로 쓴다.  
별도 DB 서버는 없고, 샤드/복제/연결 풀링도 SQLite 임베디드 수준에서만 동작한다.

- DB 파일: `data/game_data.db`
- 접근 레이어: `server/src/auth.rs`의 `AuthService`
- 커넥션 관리: `r2d2` + `r2d2_sqlite` (연결 풀)
- 쿼리/저장 라이브러리: `rusqlite` (C 바인딩 SQLite, `bundled` feature로 정적 포함)

핵심 아이디어는 간단하다.

- **계정/캐릭터/인벤토리/차단목록/세계시간**만 DB에 저장한다.
- 던전·아이템·몬스터·NPC·상인 같은 **세계 콘텐츠 정의는 DB가 아니라 JSON/CSV**에서 읽어 온다.
- 게임 런타임 상태는 메모리에 올리고, 변경된 것만 주기적으로/종료 시에 DB에 쓴다.

---

## 2. 실제 DB 파일과 위치

- 경로: 프로젝트 루트의 `data/game_data.db`
- `AuthService::default_db_path()`가 `PathBuf::from("data/game_data.db")`를 반환한다.
- 서버 시작 시 `AuthService::new(db_path)`에서 열어 커넥션 풀을 만든다.

즉 이 서버는 실행되는 순간부터 같은 폴더 안의 `data/game_data.db`를 읽고 쓰는 구조다.

---

## 3. 어떤 테이블을 쓰나

스키마는 `auth.rs`의 `new()`와 헬퍼 메서드에서 `CREATE TABLE IF NOT EXISTS`로 만든다.  
현재 스키마의 테이블은 아래 5개다.

### 3.1 accounts

계정 테이블. 로그인 가능한 주체(사람 또는 NPC)를 저장한다.

- `player_name TEXT PRIMARY KEY`
- `google_sub TEXT`
- `created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))`

중요한 점:

- 계정 이름은 이메일/이름에서 유도하지 않고 **랜덤**으로 만든다. 개인 데이터를 오래 남기지 않기 위해서다.
- 사람 계정은 Google OAuth 로그인 시 `google_sub`로 식별한다.
- NPC/헤드리스 계정은 `npc_` 접두사 전용 네임스페이스로 분리한다. 사람 계정이 NPC 토큰 경로와 절대 겹치지 않게 하려는 설계다.

### 3.2 characters

플레이어 캐릭터 테이블. 계정의 하위 레코드로 저장된다.

- `id INTEGER PRIMARY KEY`
- `account_name TEXT NOT NULL` → `accounts(player_name)` FK, `ON DELETE CASCADE`
- `character_name TEXT NOT NULL UNIQUE`
- `created_at`, `level`, `max_hp`, `xp`, `gold`, `gender`, `class`, `admin_role`
- 능력치: `attr_str/dex/con/int/wis/cha/guard`
- 위치/방향: `last_x, last_y, last_z, last_rotation`
- 상태: `health`, `floor_level`
- 외래키: `characters.account_name → accounts.player_name`

특징:

- 계정당 캐릭터는 **최대 3개**까지 만들 수 있다.
- 캐릭터 이름은 **대소문자 구분 없이 유일**해야 한다.
- 생성 시 초기 위치/회전은 `world_config().spawn_position`에서 가져온다.

### 3.3 character_items

캐릭터 인벤토리 테이블. 배낭 스택과 장착 아이템을 같이 저장한다.

- `id INTEGER PRIMARY KEY`
- `character_id INTEGER NOT NULL` → `characters(id)` FK, `ON DELETE CASCADE`
- `item_def_id TEXT NOT NULL`
- `quantity INTEGER NOT NULL DEFAULT 1`
- `equip_slot TEXT` (장착 슬롯, 없으면 배낭 스택)
- `enchant INTEGER NOT NULL DEFAULT 0`

인덱스:

- `idx_character_items_character_id ON character_items(character_id)`

이 인덱스가 있는 이유는, 모든 인벤토리 읽기와 저장 시 DELETE/INSERT가 `character_id`로 필터링되기 때문이다. 없으면 캐릭터 수만큼 풀 스캔이 발생한다.

### 3.4 character_blocks

차단 목록 테이블.

- `character_id INTEGER NOT NULL`
- `blocked_name TEXT NOT NULL`
- PK: `(character_id, blocked_name)`

특이한 점: 차단 대상은 **캐릭터 id가 아니라 이름**으로 저장한다. 그래서 대상이 오프라인이어도 id 조회 없이 저장되고, 대상이 삭제된 뒤에도 이름이 유지된다. 같은 이름으로 다시 만든 남용 계정을 차단하는 데 유리하기 때문이다.

### 3.5 world_time

월드 시계를 하나만 저장하는 테이블.

- `id INTEGER PRIMARY KEY CHECK (id = 1)`
- `year, month, day, hour, minute INTEGER NOT NULL`
- `updated_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))`

---

## 4. 컬럼이 없으면 추가하는 마이그레이션 방식

이 서버는 별도 마이그레이션 프레임워크를 쓰지 않는다. 대신 시작 시점에 PRAGMA로 현재 컬럼을 확인하고, 없으면 `ALTER TABLE`로 추가하는 방식을 직접 구현해 뒀다.

관련 헬퍼:

- `ensure_accounts_columns`
- `ensure_characters_schema` → `ensure_character_attribute_columns`
- `ensure_character_item_columns`
- `ensure_blocks_schema`
- `ensure_world_time_schema`

예를 들어 캐릭터 속성 컬럼은 `world_config().spawn_position` 값까지 `ALTER TABLE`로 기본값을 넣어 추가한다. 즉 새 컬럼 추가가 콘텐츠 설정과 엮여 있다.

---

## 5. DB는 무엇을 저장하고, 무엇을 저장하지 않나

### 5.1 DB가 저장하는 것

- 계정 정보 (`accounts`)
- 캐릭터 기본 정보 + 현재 위치/방향/레벨/XP/맥스HP/헬스/플로어/골드 (`characters`)
- 캐릭터 인벤토리 (`character_items`)
- 캐릭터별 차단 이름 (`character_blocks`)
- 월드 시계 (`world_time`)

### 5.2 DB에 저장하지 않는 것

- 아이템/몬스터/던전/NPC/상인 등의 **게임 정의 데이터**
- 이쪽은 `data/*.json`, `data-src/*.csv` 등에서 읽어 온다.
- 예: `data/items.json`, `data-src/items.csv`, `data/monsters.json` 등

즉 **영속 플레이어 데이터**와 **읽기전용 콘텐츠 정의**가 분리돼 있다. 이 구분이 이 서버 DB 이해에서 제일 중요하다.

---

## 6. 저장 타이밍: 언제 DB에 쓰나

이 서버는 매번 변화마다 즉시 쓰지 않는다. 대신 **메모리에서 dirty 표시 → 모아서 저장**한다.

### 6.1 로그인/로딩

- 로그인은 `login_google` 또는 `login_npc`가 처리한다.
- 캐릭터 로딩은 `list_characters` / `get_character_for_account`로 한다.
- 로그인 성공 시 캐릭터 위치/속성/인벤토리를 DB에서 읽어 메모리에 올린다.

### 6.2 플레이 중: dirty 저장

- 캐릭터 상태가 바뀌면 `mark_dirty(player_id)`로 dirty 집합에 넣는다.
- 인벤토리가 바뀌면 `dirty_inventories` 쪽도.mark 된다.

관련 필드 (`game_state/mod.rs` 기준):

- `dirty_players: Arc<RwLock<HashSet<PlayerId>>>`
- `dirty_inventories: Arc<RwLock<HashSet<PlayerId>>>`
- `persistence_lock: Arc<Mutex<()>>`

저장 방식:

- `flush_dirty_saves(auth)`가 dirty 상태를 모아서 `AuthService.save_batch`로 쓴다.
- `save_batch`는 **캐릭터 상태 업데이트 + 인벤토리 교체 + 세계시간 갱신**을 하나의 트랜잭션으로 커밋한다.
- 저장 대상 예시: 위치, 회전, XP, 레벨, max_hp, health, floor_level, gold, 인벤토리, 세계시간.

### 6.3 주기적 저장

- `main.rs`의 시간 동기화 틱에서 **4틱마다** `flush_dirty_saves`를 호출한다.
- 매 뚜껑(tick)마다 `save_world_time`를 호출해 세계시계를 갱신한다.

### 6.4 로그아웃/세션 교체 시

- 플레이어 나갈 때 `persist_and_detach_player`가 현재 캐릭터 상태와 인벤토리를 저장한다.
- 같은 계정으로 새 세션이 들어오면 기존 세션을 먼저 저장 후 떼어낸다. 그래야 교체 로그인 시점에 저장본이 최신으로 보장된다.

### 6.5 서버 종료 시

- 종료 직전에 `persist_shutdown_snapshot`이 모든 연결된 캐릭터와 인벤토리를 한 번에 저장한다.
- 로그아웃 개별 처리로 5,000번 커밋하는 대신, 종료 시 한 트랜잭션으로 묶는다.

---

## 7. 실제 저장 단위: CharacterSaveData

`auth.rs`에 `CharacterSaveData`가 정의돼 있다. DB에 쓰는 실제 필드만 모아 놓은 구조체다.

- `character_id`
- `x, y, z`
- `rotation`
- `xp, level, max_hp, health, floor_level, gold`

즉 **캐릭터 레코드 전체를 매번 덮어쓰는 게 아니라**, 바뀐 필드만 업데이트한다. `write_character_states`가 `UPDATE characters SET ... WHERE id = ?`로 이걸 처리한다.

인벤토리는 반대로 **전체 교체** 방식이다. `replace_inventories`가 먼저 `DELETE FROM character_items WHERE character_id = ?`로 지우고 새로 INSERT한다.

세계시간도 UPSERT다. `INSERT ... ON CONFLICT(id) DO UPDATE SET ...`로 한 행을 덮어쓴다.

---

## 8. 연결 풀과 트랜잭션

- `AuthService`는 `r2d2::Pool<SqliteConnectionManager>`를 갖는다.
- 열 때 `PRAGMA foreign_keys = ON`을 실행한다.
- `save_batch`는 `conn.unchecked_transaction()`으로 트랜잭션을 만들고, 캐릭터/인벤토리/세계시간을 한 번에 커밋한다.
- 로그아웃 저장, 주기적 플러시, 종료 스냅샷 모두 `save_batch`를 통해 같은 경로를 탄다.

---

## 9. 요약: 이 서버의 DB를 이해하는 가장 쉬운 방식

- **DB = SQLite 파일 하나**  
- **접근 = AuthService** 하나  
- **저장 대상 = 계정 + 캐릭터 + 인벤토리 + 차단목록 + 세계시간만**  
- **콘텐츠 정의 = JSON/CSV** (DB 아님)  
- **저장 방식 = 메모리에 올리고, dirty만 모아서 periodic/logout/shutdown 시점에 한 트랜잭션으로 저장**

즉 이 서버에서 DB는 “플레이어 진전을 잃지 않게 남기는 저장소”이고, 서버가 돌아가는 동안 세계를 정의하는 콘텐츠는 별도의 읽기전용 데이터로 다뤄진다.

---

## 10. 학생이 나중에 보면 좋은 것

- 실제 테이블 목록과 컬럼을 직접 보고 싶으면 서버 루트에서 아래처럼 보면 된다(권한/환경 허용 시):
  - `sqlite3 data/game_data.db ".schema"`
- 계정에 캐릭터가 실제로 어떻게 붙어 있는지, 인벤토리가 어떤 행으로 들어 있는지는 위 스키마를 보면 바로 감이 온다.
- 세계 콘텐츠 정의가 DB가 아니라 JSON/CSV라는 점은 `data/` 폴더 안을 한 번 보면 금방 이해된다.
