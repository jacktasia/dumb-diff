# dumb-diff

![Dumb Diff Screenshot](media/screenshot.png?raw=true)

## About

Dumb Diff is an Emacs package for fast arbitrary diffs.

## Why?

Sometimes I need to do a diff of arbitrary content that is either not in a file or only part of one. For example, I'll have a block of something embedded in a file and then someone will IM me a change for it. Previously it's been faster to just google `online diff` and copy/paste both parts than making new files or buffers. This lead me to create Dumb Diff.

## Installing

The recommended way to install Dumb Diff ~is~ will be via `package.el`. It's available on [MELPA](http://melpa.org/#/dumb-diff): <kbd>M-x</kbd> `package-install dumb-diff`

##### `use-package` example configuration.

I use `use-package` like so:

    (use-package dumb-diff
      :bind (("C-c d" . dumb-diff))
      :ensure t)