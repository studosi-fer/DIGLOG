/*
  Program koji racuna hammingov kod zadanog podatkovnog niza
  
  -- program je .cpp a ne .c  (makar nije neki problem pretvorit ga u .c)
  -- program je fool-proof; npr. za 010asd%#6;012002 ce racunat samo za 010
*/

#include <stdio.h>

/*
  lobit je 'funkcija' koja mi vraca najmanji bit koji je 1
  npr. lobit(1010) je 10 (tj. lobit(10) je 2)
  lobit(10000) je 10000 (lobit(16) je 16)
  
  primijetite da je lobit(100..0) = 100..0 (lobit(2^n) je 2^n)
  -- na ovaj nacin mogu provjeravati dali je broj oblika 2^n
*/
#define lobit(x) ((x)&-(x))

int main()
{
  // maksimalna duzina poruke; ovaj "= {0}" je bitan jer ucitava sve brojeve na nulu
  // (a to je bitno jer se zastitni bitovi racunaju od nule, a ne od `junk-a' koji se nalazio na ovoj memorijskoj lokaciji prije)
  char buf[1024] = {0};
  
  // 1. i 2. bit su zastitni zato pocinjemo ucitavati na 3. mjestu
  int len = 3;
  
  //  ucitavanje podatkovnih bitova, zastitni bitovi se preskacu (za njih se ostavlja mjesto)
  for (char a = getchar(); a == '0' || a == '1'; a = getchar())
  {
    if (len == lobit(len)) ++len; // ako je ova pozicija potencija broja 2, preskoci (jer je tu zastitni bit)
    buf[len++] = a - '0';
  }
  len--;
  
  // idi po svim pozicijama
  for (int k = 1; k < len; ++k)

    // ako je zastitni bit tu onda racunaj (k je 2^n)
    if (k == lobit(k))
      
      // gledaj sve pozicije poslije zastitnog bita
      for (int i = k+1; i <= len; ++i)
        
        // ako i sadrzi k u binarnom zapisu (to je taj famozni and)
        // npr. 1010 & 10 = 10 (tj. dekadski 10 & 2 = 2) -> znaci sadrzi   (ovo bi bilo zastitni bit 2 i pozicija 10)
        // 1001 & 10 = 0                                 ->  ne   sadrzi   (ovo bi bilo zastitni bit 2 i pozicija 9)
        if (i & k)
          
          // xor-aj zastitni bit s trenutnim bitom
          buf[k] ^= buf[i];
  
  
  // ispisi
  
  for (int k = 1; k <= len; ++k)
    putchar(buf[k] + '0');
  
  putchar('\n');
}
