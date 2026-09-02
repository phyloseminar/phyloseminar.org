---
name: tweet
description: Generate the next social media post for a given theme (announce or reminder) from material/ talk data, validate the YouTube link, append the tweet to tweets.txt, and open it in zed.
---

# Tweet generation

Phyloseminar.org posts two kinds of tweets/skeets per talk, pulled straight from
`material/{number}{lastname}/info.yaml` and `abstract.txt`. All tweets of both
themes accumulate in one running file at the repo root: `tweets.txt`. Entries
are appended in chronological order (as generated), separated by a single
blank line. This file is gitignored — it's a personal posting log, not repo
content.

Invoke as `/tweet announce` or `/tweet reminder`. One invocation = one theme =
one new tweet (for the next talk that theme hasn't covered yet), not one
invocation per talk.

## Getting the talk's date/time/timezone right

Don't hand-roll timezone math. `scripts/generate.py` already resolves each
talk's `date` against `config.yaml`'s `local-timezone` (America/Los_Angeles)
with correct DST handling, and bakes the offset-aware ISO datetime into the
generated HTML as `<time datetime="...">`, right next to the speaker's name
in the same panel.

1. Run `python3 scripts/generate.py` from the repo root to regenerate
   `webpage/index.html` (fast — it's just the mako render, not the full
   `bundle exec jekyll build`).
2. Find the talk's panel in `webpage/index.html` (search for the speaker's
   name) and read the `datetime="..."` attribute on the `<time>` element in
   that same panel, e.g. `2026-09-21T09:00:00-07:00`.
3. From that ISO string derive the weekday, `H:MM AM/PM`, and timezone
   abbreviation (`-07:00` → PDT, `-08:00` → PST) — this is just string/date
   parsing (e.g. `python3 -c "import datetime; ..."` on the literal offset),
   not a DST judgment call.

## Themes

**announce** — posted once, around when the talk is announced (`posted` date).
Normal format:

```
Next talk: {Name} ({Institution}) on "{Title}" {Weekday}, {Month} {Day}, {Year} at {H:MM AM/PM} {TZ abbreviation}
```

Example:
```
Next talk: Sergei Kosakovsky Pond (Temple University) on "Attention on Evolution: Foundation Models for Molecular Adaptation and Epistasis" Monday, October 19, 2026 at 9:00 AM PDT
```

**Themed-series intro variant**: if this talk is the *first* upcoming talk
whose `category` differs from the category of the most recent talk already
covered by an announce tweet (or there is no prior announce tweet at all),
AND at least one other upcoming talk shares this `category`, use the intro
form instead, naming the shared theme in plain words and introducing this
talk as "First talk":

```
Our next {N} talks will be on {theme, in plain words derived from the category}. First talk: {Name} ({Institution}) on "{Title}" {Weekday}, {Month} {Day}, {Year} at {H:MM AM/PM} {TZ abbreviation}
```

Example:
```
Our next three talks will be on advances in mutation and selection models. First talk: Ed Susko (Dalhousie University) on "Modeling site-and-branch heterogeneity in phylogenetic datasets" Monday, September 21, 2026 at 9:00 AM PDT
```

Subsequent talks in the same themed group just get the normal "Next talk:"
form — only the first of the group gets the intro.

**reminder** — posted ~24 hours before the talk. Format:

```
{Name} ({Institution}) will be speaking in 24 hours on "{Title}" {youtube-url}
```

Example:
```
Cedric Chauve (Simon Fraser University) will be speaking in 24 hours on "Handling uncertainty in ancestral gene orders reconstruction" https://www.youtube.com/watch?v=EsvFwGQqC5A
```

reminder requires `youtube-url` to be set in `info.yaml`. If it isn't set yet:

1. Ask the user for the link directly in conversation (don't guess or
   fabricate one).
2. Accept either a plain YouTube URL or a StreamYard wrapper of the form
   `https://streamyard.com/view_on_platform/youtube?link={encoded YouTube URL}`.
   If it's the StreamYard form, strip it down to the `link=` query parameter
   (URL-decoded) to get the plain `https://www.youtube.com/watch?v=...` URL —
   never post the StreamYard wrapper itself.
3. **Validate before writing anything down.** Fetch the plain YouTube URL
   (e.g. `curl -sA Mozilla/5.0 <url>`) and pull out `"scheduledStartTime":"<unix ts>"`
   and `"title":"..."` from the page. Convert the timestamp to
   America/Los_Angeles and confirm it matches the talk's `date` in
   `info.yaml`, and confirm the title mentions this talk's number and
   speaker (e.g. "Phyloseminar #157: Ed Susko ..."). If either check fails,
   report the mismatch to the user and stop — don't write a bad URL into
   `info.yaml`.
4. Once validated, add `youtube-url: {clean url}` to that talk's
   `info.yaml`. (This is safe to do well before the talk airs — whether a
   talk shows as upcoming vs. recorded is driven entirely by `date` vs. now
   in `scripts/generate.py`, not by the presence of `youtube-url`.)

## Procedure

1. Read every `material/*/info.yaml`, parsing `date`, `posted`, and
   `category`.
2. Read the existing `tweets.txt` (create it if absent). Figure out which
   talks are already covered for the requested theme by matching on speaker
   name or talk number appearing in an existing entry of that theme's format.
3. Pick the next talk this theme hasn't covered yet:
   - **announce**: the upcoming (future `date`) talk with the earliest `date`
     that has no announce entry yet.
   - **reminder**: the upcoming talk with the earliest `date` that has no
     reminder entry yet. If its `youtube-url` isn't set, follow the "ask,
     strip, validate, write" steps above before composing the tweet.
4. Get the talk's weekday/date/time/timezone via the generated-HTML method
   above.
5. Compose the tweet text per the theme's format (checking the
   themed-series-intro condition for announce tweets).
6. Append it to `tweets.txt`, preceded by a blank line if the file is
   non-empty.
7. Open `tweets.txt` in zed (`zed tweets.txt`).
8. Report the new tweet text back to the user.

If no eligible talk is found (all upcoming talks already covered, or no
upcoming talks), say so instead of inventing one.
