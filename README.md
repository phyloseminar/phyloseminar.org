# phyloseminar.org

![build and deployment](https://github.com/phyloseminar/phyloseminar.org/actions/workflows/build.yml/badge.svg)

This repository contains the ingredients and scripts to make
the [phyloseminar.org](https://www.phyloseminar.org) website.

Written by Brian Claywell, Aaron Gallagher, and Erick Matsen.


## Running locally

Install rbenv, making sure that you have done this

    echo 'eval "$(rbenv init -)"' >> ~/.zshrc

and restarted the terminal.

Then this directory:

    bundle install

Then in the `webpage` directory:

    bundle exec jekyll serve
