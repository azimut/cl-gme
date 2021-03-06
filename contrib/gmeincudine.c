// NOTE: We read it by little chunks otherwise things blew up on sbcl
// probably due too much memory allocation/usage
//
// FIXME: I do need to add logic to use chunks based
//        on the sample rate, so I can just slice by seconds

#include <stdio.h>
#include <gme/gme.h>

void gmefile_to_buffer(double *buf,
                       Music_Emu *gmefile,
                       unsigned long frames,
                       unsigned long offset)
{
  short lbuf[4410];
  unsigned long i, j;
  
  // Skip forward
  if(offset>0){
    gme_seek_samples(gmefile, offset);
  }
  // Get these much frames
  for(i=0; i<frames; i++){
    if((i % 4410) == 0){
      gme_play(gmefile, 4410, lbuf);
      for(j=i; j<(i + 4410); j++){
        buf[j] = (double)lbuf[j - i];
      }
    }
  }
}

