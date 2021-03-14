/*
    Program koji rjesava 10. zadatak iz 2. DZ DigLog 2008./2009.
    (c) Teletubbie
    
    napomena: za tocnost rjesenja ne garantiram, iako mogu reci da sam isprobao
              na par primjera ukljucujuci svoj i da je dobro ispalo
*/

#include <stdio.h>
#include <stdlib.h>

// tu stavite svoje brojke !!!!!

#define TD1 64
#define TD2 32
#define TOT 97

typedef unsigned char int8;

int8 xorr(int8 x, int8 y)
{
  if (x == 0 && y == 0)
    return 0;
  if (x == 1 && y == 0)
    return 1;
  if (x == 0 && y == 1)
    return 1;
  if (x == 1 && y == 1)
    return 0;
  printf("error in xor!\n");
}

int main()
{
  int t;
  int8 b[TOT+1] = {0}, c[TOT+1] = {0}, d[TOT+1] = {0}, e[TOT+1] = {0}, f[TOT+1] = {0};
  
  for (t = 1; t <= TOT; t++)
  {
    // racuna B:
    if (t >= TD1)
      b[t] = xorr(1, 1);
    
    // racuna C:
    if (t >= TD2)
      c[t] = 1-b[t-TD2]; // ovo je u biti not( b[] )
    
    // racuna D:
    if (t >= TD1)
      d[t] = xorr(c[t-TD1], 1);
    
    // racuna E:
    if (t >= TD1)
      e[t] = xorr(c[t-TD1], d[t-TD1]);
    
    // racuna F:
    if (t >= TD1)
      f[t] = xorr(e[t-TD1], xorr(d[t-TD1], c[t-TD1]));
  }
  
  printf("B = %d\n", b[TOT]);
  printf("C = %d\n", c[TOT]);
  printf("D = %d\n", d[TOT]);
  printf("E = %d\n", e[TOT]);
  printf("f = %d\n", f[TOT]);
}
