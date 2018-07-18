(in-package :cl-gme)

;; Below are some example calls to the library, notice that are on
;; a nsf (nintendo sound font) file but it can be any other of the
;; ones supported by gme
;;------------------------------------------------

(require 'sdl2-mixer)

(defparameter *nsf-file-path* "/home/sendai/testfield/alien.nsf")

(defun gmecount ()
  "returns the number of tracks on file"
  (with-open (ggme *nsf-file-path*)
    (foreign-funcall "gme_track_count"
                     :pointer (mem-ref ggme :pointer)
                     :int)))

(defun gmevoicecount ()
  "number of voices available on the sound font"
  (with-open (ggme *nsf-file-path*)
    (foreign-funcall "gme_voice_count"
                     :pointer (mem-ref ggme :pointer)
                     :int)))

(defun gmevoicename (&optional (voice 0))
  "returns the string with the name of the voice"
  (with-open (ggme *nsf-file-path*)
    (foreign-funcall "gme_voice_name"
                     :pointer (mem-ref ggme :pointer)
                     :int voice :string)))

(defun gmeinfo (&optional (tracknumber 1))
  "FIXME: it should return the lenght of the track, but instead it returns an
always increasing number if I do not close the tracker. Otherwise it returns
always the same value"
  (with-open (ggme *nsf-file-path*)
    (with-foreign-object (info :pointer)
      (foreign-funcall "gme_track_info"
                       :pointer (mem-ref ggme :pointer)
                       :pointer info
                       :int tracknumber
                       :pointer)
      (with-foreign-slots ((length loop_length intro_length play_length)
                           info (:struct gme_info_t))
        (format t " Length: ~a ~%ILength: ~a ~%LLength: ~a ~%PLength: ~a"
                length loop_length intro_length play_length))
      (gme_free_info (mem-ref info :pointer)))))

;; trying with "small" chunks makes the playing reaaaaly slow
;; sometimes it works ok-ish, but really bad in comparison to big buffers
;; multiples of 44100
;; still sucks...I think I just need to have the read/write part happen at a lower level
(defun gmeplay (&optional (track-number 0)
                  (buff-size 500) (loops 1)
                  (mute-voices '()))
  (with-track (ggme *nsf-file-path* track-number)
    (with-foreign-objects ((array :short buff-size))
      (when mute-voices
        (loop :for voice :in mute-voices
           :do (gme_mute_voice (mem-ref ggme :pointer) voice 1)))
      (sdl2-mixer:open-audio 44100 :s16sys 2 buff-size)
      (sdl2-mixer:allocate-channels 1)
      ;; CHUNKS!!!
      (plus-c:c-with ((mychunk sdl2-ffi:mix-chunk))
        (setf (mychunk :volume) 30
              (mychunk :allocated) 1
              (mychunk :abuf) array
              (mychunk :alen) buff-size)
        (loop :with i = 0
           :do
           (if (equal 0 (sdl2-mixer:playing 0))
               (progn
                 (incf i)
                 (when (> i loops) (return))
                 (gme_play (mem-ref ggme :pointer) buff-size array)
                 (sdl2-mixer:play-channel 0 mychunk 0))
               ;; needs to be smaaaall (.0001),
               ;; and even so the glitch is audible
               (sleep .01)))
        (sdl2-mixer:close-audio))))
  ;; https://www.libsdl.org/projects/SDL_mixer/docs/SDL_mixer.html#SEC11
  ;;(sdl2-mixer:open-audio 44100 :s16sys 2 4096) ;; 4096?
  ;;(sdl2-mixer:allocate-channels 2)
  ;;(sdl2-mixer:play-channel 0 (are)  0)

  ;;(sdl2-mixer:open-audio 44100 :s16sys 2 500)

  ;; allocate chunk
  ;;(c-with ((mychunk sdl2-ffi:mix-chunk)) (mychunk :allocated))
  )

;; Trying to write to a .txt as an attempt to make it available to incudine
;; NOTE: (* .00001 ) if you want to play it elsewhere
(defun gmerecord (&optional (track-number 0) (buff-size 500) (loops 1)
                    (mute-voices '()))
  (with-open (ggme *nsf-file-path*)
    (with-foreign-object (array :short buff-size)
      (gme_start_track (mem-ref ggme :pointer) track-number)
      (when mute-voices
        (loop :for voice :in mute-voices
           :do (gme_mute_voice (mem-ref ggme :pointer) voice 1)))
      ;; CHUNKS!!!
      (with-open-file
          (f "/home/sendai/out.txt"
             :direction :output
             :if-exists :supersede)
        (gme_play (mem-ref ggme :pointer) buff-size array)
        (dotimes (i buff-size)
          (write-line (format nil "~F" (mem-aref array :short i))
                      f))))))

;; --------------------------------------------------

(defvar *arr* nil)
;; Used to put the file into a vector, useful for cl-out123
;; NOTE: (* .00001 ) if you want to play it elsewhere
(defun gmevector (&optional (track-number 0)
                    (buff-size 500) (loops 1)
                    (mute-voices '()))
  (setf *arr* (make-array buff-size :element-type 'single-float))
  (with-track (ggme *nsf-file-path* track-number)
    (with-foreign-object (array :short buff-size)
      (when mute-voices
        (loop :for voice :in mute-voices
           :do (gme_mute_voice (mem-ref ggme :pointer) voice 1)))
      ;; CHUNKS!!!
      (gme_play (mem-ref ggme :pointer) buff-size array)
      (dotimes (i buff-size)
        (setf (aref *arr* i)
              (float (mem-aref array :short i)))))))
