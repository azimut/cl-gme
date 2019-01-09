(in-package #:cl-gme)

(defun indices (max)
  (loop :for i :from 0 :to (1- max)
     :collect i))

(defun comp-voices (voices nvoices)
  (loop
     :for i :in (indices nvoices)
     :when (not (position i voices))
     :collect i))

(defmacro with-open ((var file &key (rate 44100)) &body body)
  "opens FILE and returns a file descriptor into VAR
   closes the descriptor after the block ends"
  `(cffi:with-foreign-string (cffi-filename ,file)
     (cffi:with-foreign-object (,var :pointer)
       (gme_open_file cffi-filename ,var ,rate)
       (unwind-protect (progn ,@body)
         (gme_delete (mem-ref ,var :pointer))))))

(defmacro with-track ((var file track-number
                           &key
                           (rate 44100)
                           (voices '()))
                      &body body)
  "opens FILE in TRACK-NUMBER and returns file descriptor into VAR
   closes the file descriptor after the block ends"
  `(with-open (,var ,file :rate ,rate)
     ;; ensure we do try to listen more tracks than available ones
     (let ((ntracks (gme_track_count (mem-ref ,var :pointer))))
       (gme_start_track (mem-ref ,var :pointer) (min (1- ntracks) ,track-number)))
     ;; mute voices when provided
     (when ,voices
       (let ((nvoices (gme_voice_count (mem-ref ,var :pointer))))
         (mapcar (lambda (v) (gme_mute_voice (cffi:mem-ref ,var :pointer) v 1))
                 (comp-voices ,voices nvoices))))
     ,@body))

;;--------------------------------------------------

(defun track-count (file)
  "returns the number of tracks on FILE"
  (declare (type string file))
  (with-open (ggme file)
    (gme_track_count (mem-ref ggme :pointer))))

(defun voice-count (file)
  "returns the number of voices on FILE"
  (declare (type string file))
  (with-open (ggme file)
    (gme_voice_count (mem-ref ggme :pointer))))

(defun voice-names (file)
  "returns a list of cons with the voice number and name"
  (with-open (ggme file)
    (let* ((p (mem-ref ggme :pointer))
           (nvoices (gme_voice_count p)))
      (loop :for voice :from 0 :upto (1- nvoices) :collect
           (cons voice (gme_voice_name p voice))))))

(defun track-info (file &optional (track-number 0))
  "FIXME: it should return the lenght of the track, but instead it returns an
always increasing number if I do not close the tracker. Otherwise it returns
always the same value"  
  (declare (type string file))
  (with-open (ggme file)
    (with-foreign-object (info :pointer)
      (gme_track_info (mem-ref ggme :pointer) info track-number)
      (with-foreign-slots ((length intro_length loop_length play_length game song)
                           info
                           (:struct gme_info_t))
        (format t "Length: ~a ~%ILength: ~a ~%LLength: ~a ~%PLength: ~a"
                length loop_length intro_length play_length)
        (format t "~%Game: ~a Song: ~a"
                game song))
      (gme_free_info (mem-ref info :pointer)))))
