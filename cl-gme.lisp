(in-package :cl-gme)

(define-foreign-library gme
    (:unix (:or "/usr/lib64/libgme.so.0.6.2"
                "/usr/lib64/libgme.so.0.6.1"
                "/usr/lib64/libgme.so"))
  (t (:default "/usr/lib/libgme.so")))

(use-foreign-library gme)

;;----------------------------------------------------
;;;SWIG wrapper code starts here

(cl:defmacro defanonenum (cl:&body enums)
   "Converts anonymous enums to defconstants."
  `(cl:progn ,@(cl:loop for value in enums
                        for index = 0 then (cl:1+ index)
                        when (cl:listp value) do (cl:setf index (cl:second value)
                                                          value (cl:first value))
                        collect `(cl:defconstant ,value ,index))))

(cl:eval-when (:compile-toplevel :load-toplevel)
  (cl:unless (cl:fboundp 'swig-lispify)
    (cl:defun swig-lispify (name flag cl:&optional (package cl:*package*))
      (cl:labels ((helper (lst last rest cl:&aux (c (cl:car lst)))
                    (cl:cond
                      ((cl:null lst)
                       rest)
                      ((cl:upper-case-p c)
                       (helper (cl:cdr lst) 'upper
                               (cl:case last
                                 ((lower digit) (cl:list* c #\- rest))
                                 (cl:t (cl:cons c rest)))))
                      ((cl:lower-case-p c)
                       (helper (cl:cdr lst) 'lower (cl:cons (cl:char-upcase c) rest)))
                      ((cl:digit-char-p c)
                       (helper (cl:cdr lst) 'digit 
                               (cl:case last
                                 ((upper lower) (cl:list* c #\- rest))
                                 (cl:t (cl:cons c rest)))))
                      ((cl:char-equal c #\_)
                       (helper (cl:cdr lst) '_ (cl:cons #\- rest)))
                      (cl:t
                       (cl:error "Invalid character: ~A" c)))))
        (cl:let ((fix (cl:case flag
                        ((constant enumvalue) "+")
                        (variable "*")
                        (cl:t ""))))
          (cl:intern
           (cl:concatenate
            'cl:string
            fix
            (cl:nreverse (helper (cl:concatenate 'cl:list name) cl:nil cl:nil))
            fix)
           package))))))

;;;SWIG wrapper code ends here



(cl:defconstant GME_VERSION #x000601)

(cffi:defcfun ("gme_open_file" gme_open_file) :string
  (path :pointer)
  (out :pointer)
  (sample_rate :int))

(cffi:defcfun ("gme_track_count" gme_track_count) :int
  (arg0 :pointer))

(cffi:defcfun ("gme_start_track" gme_start_track) :string
  (arg0 :pointer)
  (index :int))

(cffi:defcfun ("gme_play" gme_play) :string
  (arg0 :pointer)
  (count :int)
  (out :pointer))

(cffi:defcfun ("gme_delete" gme_delete) :void
  (arg0 :pointer))

(cffi:defcfun ("gme_set_fade" gme_set_fade) :void
  (arg0 :pointer)
  (start_msec :int))

(cffi:defcfun ("gme_track_ended" gme_track_ended) :int
  (arg0 :pointer))

(cffi:defcfun ("gme_tell" gme_tell) :int
  (arg0 :pointer))

(cffi:defcfun ("gme_tell_samples" gme_tell_samples) :int
  (arg0 :pointer))

(cffi:defcfun ("gme_seek" gme_seek) :string
  (arg0 :pointer)
  (msec :int))

(cffi:defcfun ("gme_seek_samples" gme_seek_samples) :string
  (arg0 :pointer)
  (n :int))

(defanonenum
	(gme_info_only #.-1))

(cffi:defcfun ("gme_warning" gme_warning) :string
  (arg0 :pointer))

(cffi:defcfun ("gme_load_m3u" gme_load_m3u) :string
  (arg0 :pointer)
  (path :pointer))

(cffi:defcfun ("gme_clear_playlist" gme_clear_playlist) :void
  (arg0 :pointer))

(cffi:defcfun ("gme_track_info" gme_track_info) :string
  (arg0 :pointer)
  (out :pointer)
  (track :int))

(cffi:defcfun ("gme_free_info" gme_free_info) :void
  (arg0 :pointer))

(cffi:defcstruct gme_info_t
	(length :int)
	(intro_length :int)
	(loop_length :int)
	(play_length :int)
	(i4 :int)
	(i5 :int)
	(i6 :int)
	(i7 :int)
	(i8 :int)
	(i9 :int)
	(i10 :int)
	(i11 :int)
	(i12 :int)
	(i13 :int)
	(i14 :int)
	(i15 :int)
	(system :string)
	(game :string)
	(song :string)
	(author :string)
	(copyright :string)
	(comment :string)
	(dumper :string)
	(s7 :string)
	(s8 :string)
	(s9 :string)
	(s10 :string)
	(s11 :string)
	(s12 :string)
	(s13 :string)
	(s14 :string)
	(s15 :string))

(cffi:defcfun ("gme_set_stereo_depth" gme_set_stereo_depth) :void
  (arg0 :pointer)
  (depth :double))

(cffi:defcfun ("gme_ignore_silence" gme_ignore_silence) :void
  (arg0 :pointer)
  (ignore :int))

(cffi:defcfun ("gme_set_tempo" gme_set_tempo) :void
  (arg0 :pointer)
  (tempo :double))

(cffi:defcfun ("gme_voice_count" gme_voice_count) :int
  (arg0 :pointer))

(cffi:defcfun ("gme_voice_name" gme_voice_name) :string
  (arg0 :pointer)
  (i :int))

(cffi:defcfun ("gme_mute_voice" gme_mute_voice) :void
  (arg0 :pointer)
  (index :int)
  (mute :int))

(cffi:defcfun ("gme_mute_voices" gme_mute_voices) :void
  (arg0 :pointer)
  (muting_mask :int))

(cffi:defcstruct gme_equalizer_t
	(treble :double)
	(bass :double)
	(d2 :double)
	(d3 :double)
	(d4 :double)
	(d5 :double)
	(d6 :double)
	(d7 :double)
	(d8 :double)
	(d9 :double))

(cffi:defcfun ("gme_equalizer" gme_equalizer) :void
  (arg0 :pointer)
  (out :pointer))

(cffi:defcfun ("gme_set_equalizer" gme_set_equalizer) :void
  (arg0 :pointer)
  (eq :pointer))

(cffi:defcfun ("gme_enable_accuracy" gme_enable_accuracy) :void
  (arg0 :pointer)
  (enabled :int))

(cffi:defcvar ("gme_ay_type" gme_ay_type)
 :pointer)

(cffi:defcvar ("gme_gbs_type" gme_gbs_type)
 :pointer)

(cffi:defcvar ("gme_gym_type" gme_gym_type)
 :pointer)

(cffi:defcvar ("gme_hes_type" gme_hes_type)
 :pointer)

(cffi:defcvar ("gme_kss_type" gme_kss_type)
 :pointer)

(cffi:defcvar ("gme_nsf_type" gme_nsf_type)
 :pointer)

(cffi:defcvar ("gme_nsfe_type" gme_nsfe_type)
 :pointer)

(cffi:defcvar ("gme_sap_type" gme_sap_type)
 :pointer)

(cffi:defcvar ("gme_spc_type" gme_spc_type)
 :pointer)

(cffi:defcvar ("gme_vgm_type" gme_vgm_type)
 :pointer)

(cffi:defcvar ("gme_vgz_type" gme_vgz_type)
 :pointer)

(cffi:defcfun ("gme_type" gme_type) :pointer
  (arg0 :pointer))

(cffi:defcfun ("gme_type_list" gme_type_list) :pointer)

(cffi:defcfun ("gme_type_system" gme_type_system) :string
  (arg0 :pointer))

(cffi:defcfun ("gme_type_multitrack" gme_type_multitrack) :int
  (arg0 :pointer))

(cffi:defcvar ("gme_wrong_file_type" gme_wrong_file_type)
 :string)

(cffi:defcfun ("gme_open_data" gme_open_data) :string
  (data :pointer)
  (size :long)
  (out :pointer)
  (sample_rate :int))

(cffi:defcfun ("gme_identify_header" gme_identify_header) :string
  (header :pointer))

(cffi:defcfun ("gme_identify_extension" gme_identify_extension) :pointer
  (path_or_extension :pointer))

(cffi:defcfun ("gme_identify_file" gme_identify_file) :string
  (path :pointer)
  (type_out :pointer))

(cffi:defcfun ("gme_new_emu" gme_new_emu) :pointer
  (arg0 :pointer)
  (sample_rate :int))

(cffi:defcfun ("gme_load_file" gme_load_file) :string
  (arg0 :pointer)
  (path :pointer))

(cffi:defcfun ("gme_load_data" gme_load_data) :string
  (arg0 :pointer)
  (data :pointer)
  (size :long))

(cffi:defcfun ("gme_load_custom" gme_load_custom) :string
  (arg0 :pointer)
  (arg1 :pointer)
  (file_size :long)
  (your_data :pointer))

(cffi:defcfun ("gme_load_m3u_data" gme_load_m3u_data) :string
  (arg0 :pointer)
  (data :pointer)
  (size :long))

(cffi:defcfun ("gme_set_user_data" gme_set_user_data) :void
  (arg0 :pointer)
  (new_user_data :pointer))

(cffi:defcfun ("gme_user_data" gme_user_data) :pointer
  (arg0 :pointer))

(cffi:defcfun ("gme_set_user_cleanup" gme_set_user_cleanup) :void
  (arg0 :pointer)
  (func :pointer))


;; --------------------------------------------------
;; END OF Swig

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
