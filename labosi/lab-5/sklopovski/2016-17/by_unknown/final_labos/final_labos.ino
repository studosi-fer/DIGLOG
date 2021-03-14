// Memory-mapped registri lijevog i desnog modula tonegen
volatile char *tl = (void *) 0xc0000000;
volatile char *tr = (void *) 0xc0000002;
volatile char *led = (void *) 0xffffff10;

// MIDI kodovi
#define D0  50
#define E0  52
#define F0  53
#define G0  55
#define A0  57
#define H0  59
#define C   60
#define D   62
#define E   64
#define F   65
#define G   67
#define A   69
#define H   71
#define P   0   // pauza, nema tona

static void play(int l, int r, int t) {
  *tl = l;
  *tr = r;
  *led = (l << 4) | (r & 0xf);
  printf("%d %d\n", l, r); // Tools -> Serial Monitor ili Plotter @ 115200
  delay(177 * t);
}

// the setup function runs once when you press reset or power the board
void setup() {
}

// the loop function runs over and over again forever
void loop() {
  int i;

  //zanemarite ritam, nemam toliko vremena bas
 
      play(A0, P, 4);
      play(A0, E, 1);
      play(A0, D, 1);
      play(A0, E, 2);
      play(A0, A0, 2);

      play(F0, P, 4);
      play(F0, F, 1);
      play(F0, E, 1);
      play(F0, F, 1);
      play(F0, E, 1);
      play(F0, D, 2);

      play(D0, P, 4);
      play(D0, F, 1);
      play(D0, E, 1);
      play(D0, F, 2);
      play(D0, A0, 2);

      play(G0, P, 4);
      play(G0, D, 1);
      play(G0, C, 1);
      play(G0, D, 1);
      play(G0, C, 1);
      play(G0, H0, 1);
      play(G0, D, 1);
      
      play(A0, C, 5);
      play(A0, H0, 1);
      play(A0, C, 1);

      play(G0, D, 5);
      play(G0, C, 1);
      play(G0, D, 1);

      play(F0, E, 1);
      play(F0, D, 1);
      play(F0, C, 1);
      play(F0, H0, 1);
      play(F0, A0, 2);
      play(F0, F, 2);

      play(E0, E, 3);
      play(E0, P, 1);
      play(E0, E, 1);
      play(E0, F, 1);
      play(E0, E, 1);
      play(E0, D, 2);
      play(E0, E, 4);

      
  //linkme620
}
