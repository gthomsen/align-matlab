# align-matlab

A simple set of alignment rules (read: one) to support MATLAB in Emacs.  This
works with the native `octave-mode` as well
as [`matlab-mode`](/home/user/code/matlab-alignment/).

# Usage

Add the following into your startup file:

``` lisp
(autoload 'align-matlab-load "align-matlab" "Enable alignment in MATLAB mode." nil)
(align-matlab-load)
```
