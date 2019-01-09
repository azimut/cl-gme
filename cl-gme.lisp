(in-package #:cl-gme)

(defun indices (max)
  (loop :for i :from 0 :to (1- max)
     :collect i))

(defun comp-voices (voices nvoices)
  (loop
     :for i :in (indices nvoices)
     :when (not (position i voices))
     :collect i))

(defmacro with-open ((var filename &key (rate 44100)) &body body)
  `(cffi:with-foreign-string (cffi-filename ,filename)
     (cffi:with-foreign-object (,var :pointer)
       (gme_open_file cffi-filename ,var ,rate)
       (unwind-protect (progn ,@body)
         (gme_delete (mem-ref ,var :pointer))))))

(defmacro with-track ((var filename track
                           &key (rate 44100) (voices '())) &body body)
  `(cffi:with-foreign-string (cffi-filename ,filename)
     (cffi:with-foreign-object (,var :pointer)
       (gme_open_file cffi-filename ,var ,rate)
       ;; ensure we do try to listen more tracks than available ones
       (let ((ntracks (gme_track_count (mem-ref ,var :pointer))))
         (gme_start_track (mem-ref ,var :pointer) (min (1- ntracks) ,track)))
       ;; mute voices when provided
       (when ,voices
         (let ((nvoices (gme_voice_count (mem-ref ,var :pointer))))
           (mapcar (lambda (v) (gme_mute_voice (cffi:mem-ref ,var :pointer) v 1))
                   (comp-voices ,voices nvoices))))
       (unwind-protect (progn ,@body)
         (gme_delete (mem-ref ,var :pointer))))))
