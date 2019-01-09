%module gme
%{
/* Includes the header in the wrapper code */
#include "gme.h"
%}

%insert("lisphead") %{
(define-foreign-library gme
    (:unix (:or "/usr/lib64/libgme.so.0.6.2"
                "/usr/lib64/libgme.so.0.6.1"
                "/usr/lib64/libgme.so"))
  (t (:default "/usr/lib/libgme.so")))
(use-foreign-library gme)
(in-package #:cl-gme)
(defmacro define-constant (name value &optional doc)
  `(defconstant ,name (if (boundp ',name) (symbol-value ',name) ,value)
                      ,@(when doc (list doc))))
%}

%feature("export");
/* %feature("intern_function", "1"); */

/* Parse the header file to generate wrappers */
%include "/usr/include/gme/gme.h"
