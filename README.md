# cl-gme

Lisp bindings for [game-music-emu](https://bitbucket.org/mpyne/game-music-emu/wiki/Home) generated with Swig.

## Usage

2 macros are provided that should help with most of the common usage.
* `with-open` opens the track and ensures is closed
* `with-track` opens the track plus starts the track selected and mute voices if provided.

For example:
```lisp

(defun gmecount ()
  "returns the number of tracks on file"
  (with-open (ggme "/home/user/alien.nsf")
    (gme_track_count (mem-ref ggme :pointer)))
```

### Earing the output
On tests.lisp there are several ways to use this.
* Using [sdl-mix](https://github.com/lispgames/cl-sdl2-mixer) by reading big chunks (reading smaller ones and doing the C>lisp>C conversion resulted in glitches, might be due using Mix_Chunk, might be using Mix_Musix with the proper C handler it would work better).
* Using [cl-out123](https://github.com/Shirakumo/cl-out123/) worked fine as far as was tested (not much)
* Using [incudine](https://github.com/titola/incudine) is how I ended up using it. By creating a function that will convert it to a incudine buffer. Making it C>C>C i think.

# Demo
There is a flashy and little instructive video showcasing the bindings [here](https://www.youtube.com/watch?v=DasB0di7iAw) along with opencv bindings and incudine to get some rms from the audio output of each nes voice.
