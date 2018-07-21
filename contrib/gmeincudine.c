#include <stdio.h>
#include <gme/gme.h>

void gmefile_to_buffer(double *buf,
                       Music_Emu *gmefile,
                       unsigned long frames,
                       unsigned long offset)
{
  // We read it by little chunks otherwise things blew up on sbcl
  // probably due too much memory allocation/usage
  short lbuf[4096];
  unsigned long i, j;
  if(offset<frames){
    for(i=offset; i<frames; i++){
      if((i % 4096) == 0){
        gme_play(gmefile, 4096, lbuf);
        for(j=i; j<(i + 4096); j++){
          buf[j] = (double)lbuf[j - i];
        }
      }
    }
  }
}
