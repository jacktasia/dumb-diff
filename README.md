# dumb-diff

[![Build Status](https://travis-ci.org/jacktasia/dumb-diff.svg?branch=master)](https://travis-ci.org/jacktasia/dumb-diff) [![MELPA](http://melpa.org/packages/dumb-diff-badge.svg)](http://melpa.org/#/dumb-diff)

![Dumb Diff Screenshot](media/screenshot_word_diff.png?raw=true)


## About

Dumb Diff is an Emacs package for fast arbitrary diffs. It will automatically show "word diffs."

Calling `dumb-diff` will create two comparison buffers on top and one result buffer on the bottom. Every time you call `dumb-diff` it will update the result buffer and show the UI. You can use `dumb-diff-set-region-as-buffer1` and `dumb-diff-set-region-as-buffer2` to copy the content of selected regions directly into the buffer without needed to call `dumb-diff` first.

## Why?

I often need to see the diff of arbitrary content that is either not in a file or is only part of one. For instance, I'll have a string somewhere in a file, and then someone will send me an edit for it. I have often found this situation awkward, so I made this. Similar functionality is somewhere in the `ediff` package and elsewhere. See [alternatives](#alternatives).

## How it works?

Dumb Diff uses your built-in `diff` program against dynamically created temporary files. The `diff` binary and its arguments are customizable via `dumb-diff-bin-path` and `dumb-diff-bin-args`.

## Installing

It's available on [MELPA](http://melpa.org/#/dumb-diff): <kbd>M-x</kbd> `package-install dumb-diff`

## `.emacs` options

* `(setq dumb-diff-on-set-show-diff-only t)` If using a set-region-as-bufferN, when `t` will only show the diff result buffer while `nil` will show the comparison buffers and diff result buffer. (defaults to `t`)
* `(setq dumb-diff-clear-buffers-on-quit t)` When `t`, quitting dumb diff will clear the comparison and result buffers. (defaults to `t`)

## `use-package` example configuration.

    (use-package dumb-diff
      :bind (("C-c d" . dumb-diff)
             ("C-c 1" . dumb-diff-set-region-as-buffer1)
             ("C-c 2" . dumb-diff-set-region-as-buffer2)
             ("C-c q" . dumb-diff-quit))
      :ensure t)

I personally use `use-package` together with [hydra](https://github.com/abo-abo/hydra).

## Alternatives

Potential alternative packages for emacs:

* [ediff](https://www.gnu.org/software/emacs/manual/html_node/ediff/)
