#!/bin/bash
set -x
set -e

# cleanup
rm -f gme.lisp

# Single precision wrapper
swig -v \
     -cffi \
     -module gme \
     -includeall gme.i
sed -i 's/cl:defconstant/define-constant/g' gme.lisp
mv gme.lisp ../cl-gme-cffi.lisp
