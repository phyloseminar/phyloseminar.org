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
