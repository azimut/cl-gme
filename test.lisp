(in-package :cl-gme)

;; Below are some example calls to the library, notice that are on
;; a nsf (nintendo sound font) file but it can be any other of the
;; ones supported by gme
;;------------------------------------------------

(defun gmecount ()
  "returns the number of tracks on file"
  (with-foreign-object (ggme :pointer)
    (with-foreign-string (ss "/home/sendai/testfield/alien.nsf")
      (foreign-funcall "gme_open_file"
                       :string ss
                       :pointer ggme
                       :int -1
                       :pointer)
      (foreign-funcall "gme_track_count"
                       :pointer (mem-ref ggme :pointer)
                       :int))))

(defun gmevoicecount ()
  "number of voices available on the sound font"
  (with-foreign-object (ggme :pointer)
    (with-foreign-string
        (ss "/home/sendai/testfield/alien.nsf")
      (foreign-funcall "gme_open_file"
                       :string ss :pointer ggme
                       :int 44100 :pointer)
      (foreign-funcall "gme_voice_count"
                       :pointer (mem-ref ggme :pointer)
                       :int))))

(defun gmevoicename (&optional (voice 1))
  "returns the string with the name of the voice"
  (with-foreign-object (ggme :pointer)
    (with-foreign-string
        (ss "/home/sendai/testfield/alien.nsf")
      (foreign-funcall "gme_open_file"
                       :string ss :pointer ggme
                       :int 44100 :pointer)
      (foreign-funcall "gme_voice_name"
                       :pointer (mem-ref ggme :pointer)
                       :int voice :string))))

(defun gmeinfo (&optional (tracknumber 1))
  "FIXME: it should return the lenght of the track, but instead it returns an
   always increasing number"
  (with-foreign-objects ((ggme :pointer)
                         (info :pointer))
    (with-foreign-string (ss "/home/sendai/testfield/alien.nsf")
      (foreign-funcall "gme_open_file"
                       :string ss
                       :pointer ggme
                       :int 44100
                       :pointer)
      (foreign-funcall "gme_track_info"
                       :pointer (mem-ref ggme :pointer)
                       :pointer info
                       :int tracknumber
                       :pointer)
      (print (foreign-slot-value info '(:struct gme_info_t)
                                 'length))
      (foreign-funcall "gme_free_info" :pointer (mem-ref info :pointer) :void))))


(defvar *tmp-sound* nil)
(defun gmeplay (&optional (track-number 0) (buff-size 500) (loops 1)
                  (mute-voices '()))
  (let ((nsf-file-path "/home/sendai/testfield/alien.nsf"))
    (with-foreign-objects ((ggme :pointer) (array :short buff-size))
      (with-foreign-string (ss nsf-file-path)
        (foreign-funcall "gme_open_file"
                         :string ss
                         :pointer ggme
                         :int 44100
                         :pointer)
        (foreign-funcall "gme_start_track"
                         :pointer (mem-ref ggme :pointer)
                         :int track-number
                         :pointer))
      
        (when mute-voices
          (loop :for voice :in mute-voices
             :do
             (foreign-funcall "gme_mute_voice"
                              :pointer (mem-ref ggme :pointer)
                              :int voice
                              :int 1
                              :void)))
        
        (sdl2-mixer:open-audio 44100 :s16sys 2 buff-size)
        (sdl2-mixer:allocate-channels 1)
        ;; CHUNKS!!!
        (plus-c:c-with ((mychunk sdl2-ffi:mix-chunk))
          (loop :repeat loops
             :do             
             (if (equal 0 (sdl2-mixer:playing 0))                 
                 (progn
                   (foreign-funcall "gme_play"
                                    :pointer (mem-ref ggme :pointer)
                                    :int buff-size
                                    :pointer array
                                    :pointer)
                   (setf (mychunk :volume) 40
                         (mychunk :allocated) 1
                         (mychunk :abuf) array
                         (mychunk :alen) buff-size)
                   (sdl2-mixer:play-channel 0 mychunk 0))
                 (sleep .001)))))))


;; https://www.libsdl.org/projects/SDL_mixer/docs/SDL_mixer.html#SEC11
;;(sdl2-mixer:open-audio 44100 :s16sys 2 4096) ;; 4096?
;;(sdl2-mixer:allocate-channels 2)
;;(sdl2-mixer:play-channel 0 (are)  0)

(sdl2-mixer:open-audio 44100 :s16sys 2 500)

;; allocate chunk
;;(c-with ((mychunk sdl2-ffi:mix-chunk)) (mychunk :allocated))
