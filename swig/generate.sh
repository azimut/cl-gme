#!/bin/bash
set -x
set -e

# cleanup
rm -f gme.lisp

# Single precision wrapper
swig -v \
     -cffi \
     -module gme \
     -noswig-lisp \
     -includeall gme.i
sed -i 's/cl:defconstant/define-constant/g' gme.lisp
mv gme.lisp ../cl-gme-cffi.lisp
