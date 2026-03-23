# branch-pilot [![en](https://img.shields.io/badge/lang-en-blue.svg)](README.md) [![ru](https://img.shields.io/badge/lang-ru-green.svg)](README.ru.md)

> Лёгкий branch workflow guard для Codex, который подсказывает, когда стоит остаться в текущей ветке, уйти в новую ветку или сначала разделить смешанные изменения.

`branch-pilot` — это отдельный репозиторий с одним Codex-скиллом и одной понятной задачей: быстро посмотреть на текущее git-состояние перед нетривиальной работой и коротко объяснить, стоит ли продолжать в этой ветке или лучше вынести задачу в новую.

## Что Он Делает

- проверяет текущую ветку, статус, diff stats и недавние коммиты
- предупреждает, если нетривиальная работа идёт прямо в `main` или `master`
- предлагает 1-3 хороших имени ветки, если безопаснее работать в новой
- говорит, когда изменения выглядят смешанными и их лучше разделить
- пишет коротко, по делу и без лишней Git-теории

## Для Кого

- для новичков, которым пока некомфортно с Git
- для вайбкодеров, которым нужны безопасные дефолты без лекции
- для соло-билдеров, которые не хотят смешивать несколько задач в одной ветке
- для пользователей Codex, которым нужна branch-подсказка перед рискованной реализацией

## Установка В Codex

Шаг 1: установить скилл в Codex.

Можно просто попросить Codex:

```text
Use $skill-installer to install https://github.com/podznakom/branch-pilot/tree/main/skills/branch-pilot
```

Ручная установка:

```bash
cp -R skills/branch-pilot ~/.codex/skills/
```

После установки перезапусти Codex.

## Первый Запуск В Репозитории

Шаг 2: в первый явный вызов `branch-pilot` в репозитории он должен заметить, что repo ещё не настроен, и спросить, нужно ли сейчас пропатчить `AGENTS.md`.

Пример:

```text
Use $branch-pilot to check whether this work should stay on the current branch.
```

Если пользователь соглашается, он делает две вещи:

- убеждается, что в репозитории есть `.agents/skills/branch-pilot/`
- патчит корневой `AGENTS.md`, чтобы Codex сам вызывал `$branch-pilot` перед нетривиальной работой

Если хочется сразу пройти install-path, можно и напрямую сказать `install branch-pilot`, `set up branch-pilot` или `patch AGENTS.md for branch-pilot`.

После этого обычно не нужно вызывать его вручную.

## Что Происходит Во Время Работы

После настройки repo `branch-pilot` быстро смотрит на текущее git-состояние и возвращает короткое решение:

- stay on current branch
- create a new branch
- split current work
- ready to commit
- ready for PR later

Если лучше перейти в новую ветку, он также предлагает 1-3 нормальных имени ветки.

## Чего Он Не Делает Автоматически

- не создаёт ветки
- не переключает ветки
- не коммитит
- не пушит
- не мержит
- не делает force-push
- не меняет remote state молча

## Пример Вывода

```md
### branch-pilot
One-line decision: create a new branch

### why
- You are in `main`.
- This task is larger than a tiny safe edit.
- A separate branch is safer and easier to review.

### do this now
Ask me to create one of these and continue there.
- branch type: feature
- good branch names: feature/auth-form-cleanup, feature/login-error-states, feature/form-validation-pass
```

## Структура Репозитория

- [skills/branch-pilot](./skills/branch-pilot/) - installable skill
- [README.md](./README.md) - описание на английском
- [README.ru.md](./README.ru.md) - описание на русском

## Чем Полезен

- держит `main` и `master` чище
- уменьшает случайно смешанные ветки
- упрощает review и rollback
- даёт нормальную человеческую подсказку и не тормозит обычную работу

## Лицензия

MIT
