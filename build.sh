#!/bin/sh
python scripts/generate.py && (cd webpage; bundle exec jekyll build)
