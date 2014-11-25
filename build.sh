#!/bin/sh
python scripts/generate.py && (cd webpage; jekyll build)
