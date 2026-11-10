# Phyloseminar.org

Online seminar series on phylogenetics.

## Talk Structure

Each talk lives in `material/{number}{lastname}/` with:
- `info.yaml` - metadata (title, name, category, institution, date, posted, youtube-url)
- `abstract.txt` - talk abstract
- `intro.txt` - introduction script with speaker bio
- `{lastname}.jpg` - speaker photo

## info.yaml Format

```yaml
title: "Talk Title"
name: "Speaker Name"
category: "Series Name"
institution: "University"
date: '2026-03-05 9:00:00'      # talk date, usually 9am PT
posted: '2026-02-03 10:00:00'   # when announced
youtube-url: https://www.youtube.com/watch?v=XXX  # added after talk
```

## intro.txt Template

```
Hello everyone, and welcome to phyloseminar.org.
This is the Nth talk in a series on [topic].

Please use the YouTube live comment box to ask questions.

Today's speaker is [Name].

[Bio paragraph(s)]

Welcome, [First Name], and thank you for participating!
```

## Numbering

Talks are numbered sequentially.

## Seminar planning

Series planning lives in `planning/`, which is gitignored because it holds private correspondence and this repo is public. Write nothing about invitations or speaker status into tracked files.

- Use one file per series, `planning/YYYY-topic.md`, containing a speaker table, a next-actions checklist, and a dated log
- When the user pastes an email, update the speaker's status and the log
- Check candidate speakers against past speakers (`grep -h '^name' material/*/info.yaml`) and the literature (`bip` / nexus refs)
- Draft emails for the user to send and never send them yourself
