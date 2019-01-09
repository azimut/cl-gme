;;; This file was automatically generated by SWIG (http://www.swig.org).
;;; Version 3.0.12
;;;
;;; Do not make changes to this file unless you know what you are doing--modify
;;; the SWIG interface file instead.

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



(define-constant GME_VERSION #x000602)

(cl:export 'GME_VERSION)

(cffi:defcfun ("gme_open_file" gme_open_file) :string
  (path :pointer)
  (out :pointer)
  (sample_rate :int))

(cl:export 'gme_open_file)

(cffi:defcfun ("gme_track_count" gme_track_count) :int
  (arg0 :pointer))

(cl:export 'gme_track_count)

(cffi:defcfun ("gme_start_track" gme_start_track) :string
  (arg0 :pointer)
  (index :int))

(cl:export 'gme_start_track)

(cffi:defcfun ("gme_play" gme_play) :string
  (arg0 :pointer)
  (count :int)
  (out :pointer))

(cl:export 'gme_play)

(cffi:defcfun ("gme_delete" gme_delete) :void
  (arg0 :pointer))

(cl:export 'gme_delete)

(cffi:defcfun ("gme_set_fade" gme_set_fade) :void
  (arg0 :pointer)
  (start_msec :int))

(cl:export 'gme_set_fade)

(cffi:defcfun ("gme_track_ended" gme_track_ended) :int
  (arg0 :pointer))

(cl:export 'gme_track_ended)

(cffi:defcfun ("gme_tell" gme_tell) :int
  (arg0 :pointer))

(cl:export 'gme_tell)

(cffi:defcfun ("gme_tell_samples" gme_tell_samples) :int
  (arg0 :pointer))

(cl:export 'gme_tell_samples)

(cffi:defcfun ("gme_seek" gme_seek) :string
  (arg0 :pointer)
  (msec :int))

(cl:export 'gme_seek)

(cffi:defcfun ("gme_seek_samples" gme_seek_samples) :string
  (arg0 :pointer)
  (n :int))

(cl:export 'gme_seek_samples)

(defanonenum 
	(gme_info_only #.-1))

(cl:export 'gme_info_only)

(cffi:defcfun ("gme_warning" gme_warning) :string
  (arg0 :pointer))

(cl:export 'gme_warning)

(cffi:defcfun ("gme_load_m3u" gme_load_m3u) :string
  (arg0 :pointer)
  (path :pointer))

(cl:export 'gme_load_m3u)

(cffi:defcfun ("gme_clear_playlist" gme_clear_playlist) :void
  (arg0 :pointer))

(cl:export 'gme_clear_playlist)

(cffi:defcfun ("gme_track_info" gme_track_info) :string
  (arg0 :pointer)
  (out :pointer)
  (track :int))

(cl:export 'gme_track_info)

(cffi:defcfun ("gme_free_info" gme_free_info) :void
  (arg0 :pointer))

(cl:export 'gme_free_info)

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

(cl:export 'gme_info_t)

(cl:export 'length)

(cl:export 'intro_length)

(cl:export 'loop_length)

(cl:export 'play_length)

(cl:export 'i4)

(cl:export 'i5)

(cl:export 'i6)

(cl:export 'i7)

(cl:export 'i8)

(cl:export 'i9)

(cl:export 'i10)

(cl:export 'i11)

(cl:export 'i12)

(cl:export 'i13)

(cl:export 'i14)

(cl:export 'i15)

(cl:export 'system)

(cl:export 'game)

(cl:export 'song)

(cl:export 'author)

(cl:export 'copyright)

(cl:export 'comment)

(cl:export 'dumper)

(cl:export 's7)

(cl:export 's8)

(cl:export 's9)

(cl:export 's10)

(cl:export 's11)

(cl:export 's12)

(cl:export 's13)

(cl:export 's14)

(cl:export 's15)

(cffi:defcfun ("gme_set_stereo_depth" gme_set_stereo_depth) :void
  (arg0 :pointer)
  (depth :double))

(cl:export 'gme_set_stereo_depth)

(cffi:defcfun ("gme_ignore_silence" gme_ignore_silence) :void
  (arg0 :pointer)
  (ignore :int))

(cl:export 'gme_ignore_silence)

(cffi:defcfun ("gme_set_tempo" gme_set_tempo) :void
  (arg0 :pointer)
  (tempo :double))

(cl:export 'gme_set_tempo)

(cffi:defcfun ("gme_voice_count" gme_voice_count) :int
  (arg0 :pointer))

(cl:export 'gme_voice_count)

(cffi:defcfun ("gme_voice_name" gme_voice_name) :string
  (arg0 :pointer)
  (i :int))

(cl:export 'gme_voice_name)

(cffi:defcfun ("gme_mute_voice" gme_mute_voice) :void
  (arg0 :pointer)
  (index :int)
  (mute :int))

(cl:export 'gme_mute_voice)

(cffi:defcfun ("gme_mute_voices" gme_mute_voices) :void
  (arg0 :pointer)
  (muting_mask :int))

(cl:export 'gme_mute_voices)

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

(cl:export 'gme_equalizer_t)

(cl:export 'treble)

(cl:export 'bass)

(cl:export 'd2)

(cl:export 'd3)

(cl:export 'd4)

(cl:export 'd5)

(cl:export 'd6)

(cl:export 'd7)

(cl:export 'd8)

(cl:export 'd9)

(cffi:defcfun ("gme_equalizer" gme_equalizer) :void
  (arg0 :pointer)
  (out :pointer))

(cl:export 'gme_equalizer)

(cffi:defcfun ("gme_set_equalizer" gme_set_equalizer) :void
  (arg0 :pointer)
  (eq :pointer))

(cl:export 'gme_set_equalizer)

(cffi:defcfun ("gme_enable_accuracy" gme_enable_accuracy) :void
  (arg0 :pointer)
  (enabled :int))

(cl:export 'gme_enable_accuracy)

(cffi:defcvar ("gme_ay_type" gme_ay_type)
 :pointer)

(cl:export 'gme_ay_type)

(cffi:defcvar ("gme_gbs_type" gme_gbs_type)
 :pointer)

(cl:export 'gme_gbs_type)

(cffi:defcvar ("gme_gym_type" gme_gym_type)
 :pointer)

(cl:export 'gme_gym_type)

(cffi:defcvar ("gme_hes_type" gme_hes_type)
 :pointer)

(cl:export 'gme_hes_type)

(cffi:defcvar ("gme_kss_type" gme_kss_type)
 :pointer)

(cl:export 'gme_kss_type)

(cffi:defcvar ("gme_nsf_type" gme_nsf_type)
 :pointer)

(cl:export 'gme_nsf_type)

(cffi:defcvar ("gme_nsfe_type" gme_nsfe_type)
 :pointer)

(cl:export 'gme_nsfe_type)

(cffi:defcvar ("gme_sap_type" gme_sap_type)
 :pointer)

(cl:export 'gme_sap_type)

(cffi:defcvar ("gme_spc_type" gme_spc_type)
 :pointer)

(cl:export 'gme_spc_type)

(cffi:defcvar ("gme_vgm_type" gme_vgm_type)
 :pointer)

(cl:export 'gme_vgm_type)

(cffi:defcvar ("gme_vgz_type" gme_vgz_type)
 :pointer)

(cl:export 'gme_vgz_type)

(cffi:defcfun ("gme_type" gme_type) :pointer
  (arg0 :pointer))

(cl:export 'gme_type)

(cffi:defcfun ("gme_type_list" gme_type_list) :pointer)

(cl:export 'gme_type_list)

(cffi:defcfun ("gme_type_system" gme_type_system) :string
  (arg0 :pointer))

(cl:export 'gme_type_system)

(cffi:defcfun ("gme_type_multitrack" gme_type_multitrack) :int
  (arg0 :pointer))

(cl:export 'gme_type_multitrack)

(cffi:defcfun ("gme_multi_channel" gme_multi_channel) :int
  (arg0 :pointer))

(cl:export 'gme_multi_channel)

(cffi:defcvar ("gme_wrong_file_type" gme_wrong_file_type)
 :string)

(cl:export 'gme_wrong_file_type)

(cffi:defcfun ("gme_open_data" gme_open_data) :string
  (data :pointer)
  (size :long)
  (out :pointer)
  (sample_rate :int))

(cl:export 'gme_open_data)

(cffi:defcfun ("gme_identify_header" gme_identify_header) :string
  (header :pointer))

(cl:export 'gme_identify_header)

(cffi:defcfun ("gme_identify_extension" gme_identify_extension) :pointer
  (path_or_extension :pointer))

(cl:export 'gme_identify_extension)

(cffi:defcfun ("gme_type_extension" gme_type_extension) :string
  (music_type :pointer))

(cl:export 'gme_type_extension)

(cffi:defcfun ("gme_identify_file" gme_identify_file) :string
  (path :pointer)
  (type_out :pointer))

(cl:export 'gme_identify_file)

(cffi:defcfun ("gme_new_emu" gme_new_emu) :pointer
  (arg0 :pointer)
  (sample_rate :int))

(cl:export 'gme_new_emu)

(cffi:defcfun ("gme_new_emu_multi_channel" gme_new_emu_multi_channel) :pointer
  (arg0 :pointer)
  (sample_rate :int))

(cl:export 'gme_new_emu_multi_channel)

(cffi:defcfun ("gme_load_file" gme_load_file) :string
  (arg0 :pointer)
  (path :pointer))

(cl:export 'gme_load_file)

(cffi:defcfun ("gme_load_data" gme_load_data) :string
  (arg0 :pointer)
  (data :pointer)
  (size :long))

(cl:export 'gme_load_data)

(cffi:defcfun ("gme_load_custom" gme_load_custom) :string
  (arg0 :pointer)
  (arg1 :pointer)
  (file_size :long)
  (your_data :pointer))

(cl:export 'gme_load_custom)

(cffi:defcfun ("gme_load_m3u_data" gme_load_m3u_data) :string
  (arg0 :pointer)
  (data :pointer)
  (size :long))

(cl:export 'gme_load_m3u_data)

(cffi:defcfun ("gme_set_user_data" gme_set_user_data) :void
  (arg0 :pointer)
  (new_user_data :pointer))

(cl:export 'gme_set_user_data)

(cffi:defcfun ("gme_user_data" gme_user_data) :pointer
  (arg0 :pointer))

(cl:export 'gme_user_data)

(cffi:defcfun ("gme_set_user_cleanup" gme_set_user_cleanup) :void
  (arg0 :pointer)
  (func :pointer))

(cl:export 'gme_set_user_cleanup)


