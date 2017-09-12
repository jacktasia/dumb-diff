WORK IN PROGRESS (not submitted to MELPA yet)

# dumb-diff

![Dumb Diff Screenshot](media/screenshot.png?raw=true)

## About

Dumb Diff is an Emacs package for fast arbitrary diffs.

## Why?

I have often had to make a diff of arbitrary content that is either not in a file or only part of one. For example, I'll have a block of something embedded in a file and then someone will IM me an edit for it. I often found workflows like this awkward, so I made Dumb Diff.

Calling `dumb-diff` will create two comparison buffers on top and one result buffer on the bottom. Every time you call `dumb-diff` it will update the result buffer and show the UI. You can use `dumb-diff-set-region-as-buffer1` and `dumb-diff-set-region-as-buffer2` to copy the content of selected regions directly into the buffer without needed to call `dumb-diff` first.

## How it works?

Dumb Diff uses your built-in `diff` program against dynamically created temporary files. The `diff` binary and its arguments are customizable via `dumb-diff-bin-path` and `dumb-diff-bin-args`.

## Installing

The recommended way to install Dumb Diff ~is~ will be via `package.el`. It's available on [MELPA](http://melpa.org/#/dumb-diff): <kbd>M-x</kbd> `package-install dumb-diff`

##### `use-package` example configuration.

    (use-package dumb-diff
      :bind (("C-c d" . dumb-diff)
             ("C-c 1" . dumb-diff-set-region-as-buffer1)
             ("C-c 2" . dumb-diff-set-region-as-buffer2))
      :ensure t)

I personally use `use-package` together with [hydra](https://github.com/abo-abo/hydra)