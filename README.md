# dumb-diff

[![Build Status](https://travis-ci.org/jacktasia/dumb-diff.svg?branch=master)](https://travis-ci.org/jacktasia/dumb-diff)

![Dumb Diff Screenshot](media/screenshot.png?raw=true)

## About

Dumb Diff is an Emacs package for fast arbitrary diffs.

Calling `dumb-diff` will create two comparison buffers on top and one result buffer on the bottom. Every time you call `dumb-diff` it will update the result buffer and show the UI. You can use `dumb-diff-set-region-as-buffer1` and `dumb-diff-set-region-as-buffer2` to copy the content of selected regions directly into the buffer without needed to call `dumb-diff` first.

## Why?

I  often need to see the diff of arbitrary content that is either not in a file or is only part of one. For instance, I'll have a string somewhere in a file, and then someone will send me an edit for it. I have often found this situation awkward, so I made this. Similar functionality is somewhere in the `ediff` package and elsewhere. See [alternatives](#alternatives).

## How it works?

Dumb Diff uses your built-in `diff` program against dynamically created temporary files. The `diff` binary and its arguments are customizable via `dumb-diff-bin-path` and `dumb-diff-bin-args`.

## Installing

It's available on [MELPA](http://melpa.org/#/dumb-diff): <kbd>M-x</kbd> `package-install dumb-diff`

##### `use-package` example configuration.

    (use-package dumb-diff
      :bind (("C-c d" . dumb-diff)
             ("C-c 1" . dumb-diff-set-region-as-buffer1)
             ("C-c 2" . dumb-diff-set-region-as-buffer2))
      :ensure t)

I personally use `use-package` together with [hydra](https://github.com/abo-abo/hydra).

The recommended way to install Dumb Diff ~is~ will be via `package.el`. 

## Alternatives

Potential alternative packages for emacs:

* [ediff](https://www.gnu.org/software/emacs/manual/html_node/ediff/)
